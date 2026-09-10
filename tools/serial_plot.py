#!/usr/bin/env python3
"""Strip-chart the XADC hex stream: one bar per sample, no deps beyond pyserial.

usage: serial_plot.py [port] [baud] [every]
       every = print 1 in N samples (default 8 -> ~24 lines/s at 9600 baud)
"""
import sys, shutil, serial

port  = sys.argv[1] if len(sys.argv) > 1 else "/dev/ttyUSB1"
baud  = int(sys.argv[2]) if len(sys.argv) > 2 else 9600
every = int(sys.argv[3]) if len(sys.argv) > 3 else 8
width = shutil.get_terminal_size().columns - 16

with serial.Serial(port, baud, timeout=1) as s:
    for i, raw in enumerate(s):
        try:
            code = int(raw.strip(), 16)
        except ValueError:
            continue                        # partial first line / line noise
        if i % every or not 0 <= code < 4096:
            continue
        n = code * width // 4095
        print(f"{code:03X} {code / 4096:.3f}V |{'#' * n}{' ' * (width - n)}|")
