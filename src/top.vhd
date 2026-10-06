library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
library UNISIM;
use UNISIM.VComponents.all;

entity top is
	port (
		clk   : in  std_logic;
		sw    : in  std_logic_vector(3 downto 0);
		led   : out std_logic_vector(3 downto 0);
		led_r : out std_logic_vector(3 downto 0);
		led_g : out std_logic_vector(3 downto 0);
		led_b : out std_logic_vector(3 downto 0);
		uart_tx : out std_logic;
		vaux4_n : in std_logic;
		vaux4_p : in std_logic);
end top;

architecture rtl of top is
	constant CLK_FRQ_HZ : natural := 100_000_000;
	signal led_idx : unsigned(1 downto 0) := (others => '0');
	signal counter : natural range 0 to CLK_FRQ_HZ-1 := 0;
	signal tx_char  : std_logic_vector(7 downto 0);
	signal tx_ready : std_logic;
	-- UART frame: one 12-bit sample as 3 hex digits, then CR LF
	function ascii(c : character) return std_logic_vector is
	begin
		return std_logic_vector(to_unsigned(character'pos(c), 8));
	end function;
	function hex_digit(n : unsigned(3 downto 0)) return character is
		constant DIGITS : string(1 to 16) := "0123456789ABCDEF";
	begin
		return DIGITS(to_integer(n) + 1);
	end function;
	signal frame_idx : integer range 0 to 4  := 0;
	signal frame_val : unsigned(11 downto 0) := (others => '0');
	-- XADC
	constant XADC_VAUX4 : std_logic_vector(6 downto 0) := "0010100";
	signal xadc_den   : std_logic := '0';
	signal xadc_do    : std_logic_vector(15 downto 0);
	signal xadc_drdy  : std_logic;
	signal xadc_eoc   : std_logic;
	signal sample     : unsigned(11 downto 0) := (others => '0');
	signal sample_valid : std_logic := '0';
	signal pot        : unsigned(11 downto 0) := (others => '0');
	signal phase      : unsigned(31 downto 0) := (others => '0');
	signal tick_cnt   : unsigned(7 downto 0)  := (others => '0');
	-- 1024-entry sine ROM, 12-bit unsigned (0..4095, centred on 2047.5)
	type sine_rom_t is array(0 to 1023) of unsigned(11 downto 0);
	function make_sine return sine_rom_t is
		variable r : sine_rom_t;
	begin
		for i in r'range loop
			r(i) := to_unsigned(integer(round(2047.5 + 2047.5 * sin(MATH_2_PI * real(i) / 1024.0))), 12);
		end loop;
		return r;
	end function;
	constant SINE : sine_rom_t := make_sine;
	signal cic_out    : unsigned(11 downto 0) := (others => '0');
	signal cic_rdy    : std_logic := '0';
	signal sending    : std_logic := '0';
begin
	clock : process(clk)
	begin
		if (rising_edge(clk)) then
			if (counter >= CLK_FRQ_HZ) then
				led_idx <= led_idx + 1;
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;

	with to_integer(led_idx) select
		led <= "1000" when 0,
			   "0100" when 1,
			   "0010" when 2,
			   "0001" when 3,
			   "0000" when others;

	cic_inst : entity work.cic
	port map(
		clk => clk,
		en => sample_valid,
		din => sample,
		dout => cic_out,
		rdy => cic_rdy
	);

	uart_tx_inst : entity work.uart_tx
	generic map(baud_rate => 115200)
	port map(
		clk => clk,
		data => tx_char,
		valid => sending,
		ready => tx_ready,
		uart_tx => uart_tx
	);

	with frame_idx select tx_char <=
		ascii(hex_digit(frame_val(11 downto 8))) when 0,
		ascii(hex_digit(frame_val(7 downto 4)))  when 1,
		ascii(hex_digit(frame_val(3 downto 0)))  when 2,
		ascii(CR)                                when 3,
		ascii(LF)                                when others;

	send_frame : process(clk) is
	begin
		if (rising_edge(clk)) then
			if (sending = '0') then
				if (cic_rdy = '1') then
					frame_val <= cic_out;
					frame_idx <= 0;
					sending <= '1';
				end if;
			elsif tx_ready = '1' then
				if (frame_idx = 4) then
					sending <= '0';
				else
					frame_idx <= frame_idx + 1;
				end if;
			end if;
		end if;
	end process;

	xadc_inst : XADC
	generic map(
		INIT_40 => X"2114",  -- CFG0: avg 16, unipolar, continuous, long acq, ch 0x14
		INIT_41 => X"3F0F",  -- CFG1: single-channel mode, alarms off
		INIT_42 => X"0800",  -- CFG2: DCLK/8 -> 12.5 MHz ADCCLK
		SIM_DEVICE => "7SERIES"
	)
	port map(
		alm => open,
		busy => open,
		channel => open,
		do => xadc_do,
		drdy => xadc_drdy,
		eoc => xadc_eoc,
		eos => open,
		jtagbusy => open,
		jtaglocked => open,
		jtagmodified => open,
		muxaddr => open,
		ot => open,
		convst => '0',
		convstclk => '0',
		daddr => XADC_VAUX4,
		dclk => clk,
		den => xadc_den,
		di => X"0000",
		dwe => '0',
		reset => '0',
		vauxn => (4 => vaux4_n, others => '0'),
		vauxp => (4 => vaux4_p, others => '0'),
		vn => '0',
		vp => '0'
	);

	xadc_drp : process(clk) is
	begin
		if (rising_edge(clk)) then
			xadc_den <= '0';
			if (xadc_eoc = '1') then
				xadc_den <= '1';
			elsif (xadc_drdy = '1') then
				pot <= unsigned(xadc_do(15 downto 4));
			end if;
		end if;
	end process;

	-- NCO: fs = clk/256 = 390.625 kHz feeds the CIC. f_sine = pot/8192 * fs (0 .. ~fs/2)
	nco : process(clk) is
	begin
		if (rising_edge(clk)) then
			tick_cnt <= tick_cnt + 1;
			sample_valid <= '0';
			if (tick_cnt = 255) then
				phase <= phase + shift_left(resize(pot, 32), 19);
				sample <= SINE(to_integer(phase(31 downto 22)));
				sample_valid <= '1';
			end if;
		end if;
	end process;

end;
