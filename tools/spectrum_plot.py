#!/usr/bin/env python3
"""Live matplotlib view of the XADC hex stream: waveform on top, spectrum below.

Keeps the last N samples (default 4096) in a ring buffer. The spectrum is the
Hann-windowed rFFT of that buffer in dB relative to full scale. The sample rate
is measured from the arrival timestamps of the samples in the buffer, so the
frequency axis is right whatever baud rate the design is built for; pass --fs
to override it.

usage (from the tools/ directory, after `uv sync`):
    uv run spectrum_plot.py [port] [baud] [--n 4096] [--fs HZ] [--interval MS]
"""
import argparse
import sys
import threading
import time
from collections import deque

import matplotlib.pyplot as plt
import numpy as np
import serial
from matplotlib.animation import FuncAnimation

FULL_SCALE = 4096          # 12-bit XADC code range
VREF = 1.0                 # volts at code 4095 (unipolar XADC)
FRAME_BITS = 5 * 10        # "XXX\r\n" = 5 bytes of 8N1 -> nominal fs = baud / 50


class SampleBuffer:
    """Thread-safe ring buffer of (timestamp, code) pairs."""

    def __init__(self, n):
        self.n = n
        self.codes = deque(maxlen=n)
        self.times = deque(maxlen=n)
        self.lock = threading.Lock()
        self.total = 0
        self.bad = 0

    def push(self, code, t):
        with self.lock:
            self.codes.append(code)
            self.times.append(t)
            self.total += 1

    def snapshot(self):
        with self.lock:
            return np.fromiter(self.codes, dtype=float), np.fromiter(self.times, dtype=float)


def reader(port, baud, buf, stop):
    """Background thread: parse hex lines from the serial port into buf."""
    with serial.serial_for_url(port, baudrate=baud, timeout=0.5) as s:
        while not stop.is_set():
            raw = s.readline()
            if not raw:
                continue
            try:
                code = int(raw.strip(), 16)
            except ValueError:
                buf.bad += 1               # partial first line / line noise
                continue
            if 0 <= code < FULL_SCALE:
                buf.push(code, time.monotonic())
            else:
                buf.bad += 1


def measured_fs(times, fallback):
    """Average sample rate over the buffered samples, or fallback if too few."""
    if len(times) < 16:
        return fallback
    span = times[-1] - times[0]
    return (len(times) - 1) / span if span > 0 else fallback


def spectrum_db(codes):
    """Hann-windowed magnitude spectrum in dBFS, DC removed."""
    x = (codes - codes.mean()) / (FULL_SCALE / 2)      # +-1.0 = full-scale swing
    w = np.hanning(len(x))
    X = np.fft.rfft(x * w)
    mag = np.abs(X) * 2 / w.sum()                      # amplitude-correct for window
    return 20 * np.log10(np.maximum(mag, 1e-9))


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("port", nargs="?", default="/dev/ttyUSB1", help="serial port or pyserial URL (default /dev/ttyUSB1)")
    ap.add_argument("baud", nargs="?", type=int, default=115200, help="baud rate (default 115200)")
    ap.add_argument("--n", type=int, default=4096, help="samples in the buffer / FFT length (default 4096)")
    ap.add_argument("--fs", type=float, default=None, help="force the sample rate in Hz instead of measuring it")
    ap.add_argument("--interval", type=int, default=100, help="redraw interval in ms (default 100)")
    args = ap.parse_args()

    buf = SampleBuffer(args.n)
    stop = threading.Event()
    nominal_fs = args.baud / FRAME_BITS
    t = threading.Thread(target=reader, args=(args.port, args.baud, buf, stop), daemon=True)
    t.start()

    fig, (ax_t, ax_f) = plt.subplots(2, 1, figsize=(10, 7), constrained_layout=True)
    fig.canvas.manager.set_window_title(f"XADC spectrum  {args.port} @ {args.baud}")

    (line_t,) = ax_t.plot([], [], lw=0.8)
    ax_t.set_xlabel("time (s)")
    ax_t.set_ylabel("input (V)")
    ax_t.set_ylim(0, VREF)
    ax_t.grid(True, alpha=0.3)

    (line_f,) = ax_f.plot([], [], lw=0.8)
    ax_f.set_xlabel("frequency (Hz)")
    ax_f.set_ylabel("magnitude (dBFS)")
    ax_f.set_ylim(-100, 5)
    ax_f.grid(True, alpha=0.3)

    status = ax_t.set_title("waiting for data...")

    def update(_frame):
        codes, times = buf.snapshot()
        if len(codes) < 2:
            return line_t, line_f, status
        fs = args.fs if args.fs else measured_fs(times, nominal_fs)

        volts = codes * VREF / (FULL_SCALE - 1)
        tt = np.arange(len(codes)) / fs
        line_t.set_data(tt, volts)
        ax_t.set_xlim(0, args.n / fs)

        if len(codes) >= 16:
            db = spectrum_db(codes)
            freqs = np.fft.rfftfreq(len(codes), d=1 / fs)
            line_f.set_data(freqs[1:], db[1:])          # skip the DC bin
            ax_f.set_xlim(0, fs / 2)
            peak = np.argmax(db[1:]) + 1
            peak_txt = f"   peak {freqs[peak]:.2f} Hz @ {db[peak]:.1f} dBFS"
        else:
            peak_txt = ""

        fill = f"{len(codes)}/{args.n}" if len(codes) < args.n else "full"
        status.set_text(
            f"{volts[-1]:.3f} V   fs = {fs:.1f} Hz   buffer {fill}   "
            f"bad lines {buf.bad}{peak_txt}"
        )
        return line_t, line_f, status

    ani = FuncAnimation(fig, update, interval=args.interval, cache_frame_data=False)  # noqa: F841
    try:
        plt.show()
    finally:
        stop.set()
        t.join(timeout=1)


if __name__ == "__main__":
    try:
        main()
    except serial.SerialException as e:
        sys.exit(f"serial error: {e}")
    except KeyboardInterrupt:
        pass
