library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
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
	signal counter : unsigned(31 downto 0) := (others => '0');
	signal sec     : unsigned(1 downto 0)  := (others => '0');
	type u8_array is array(integer range<>) of unsigned(7 downto 0);
	signal duty_r  : u8_array(0 to 3);
	signal duty_g  : u8_array(0 to 3);
	signal duty_b  : u8_array(0 to 3);
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
begin
	clock : process(clk) is
		constant CLK_FRQ_HZ : natural := 100_000_000;
		constant ONE_SEC    : unsigned(31 downto 0) := to_unsigned(CLK_FRQ_HZ-1, 32);
	begin
		if (rising_edge(clk)) then
			if (counter >= ONE_SEC) then
				sec <= sec + 1;
				counter <= (others => '0');
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;

	with to_integer(sec) select
		led <= "1000" when 0,
			   "0100" when 1,
			   "0010" when 2,
			   "0001" when 3,
			   "0000" when others;

	rgb_gen : for n in 0 to 3 generate
		constant R : u8_array(0 to 3) := (
			0 => 8x"FF", 1 => 8x"00", 2 => 8x"00", 3 => 8x"00"
		);
		constant G : u8_array(0 to 3) := (
			0 => 8x"00", 1 => 8x"FF", 2 => 8x"00", 3 => 8x"FF"
		);
		constant B : u8_array(0 to 3) := (
			0 => 8x"00", 1 => 8x"00", 2 => 8x"FF", 3 => 8x"FF"
		);
	begin
		duty_r(n) <= R(n) when (sw(n) = '1') else (others => '0');
		duty_g(n) <= G(n) when (sw(n) = '1') else (others => '0');
		duty_b(n) <= B(n) when (sw(n) = '1') else (others => '0');
		pwm_r : entity work.pwm
		port map(
			clk => clk,
			duty => duty_r(n),
			pwm_out => led_r(n)
		);
		pwm_g : entity work.pwm
		port map(
			clk => clk,
			duty => duty_g(n),
			pwm_out => led_g(n)
		);
		pwm_b : entity work.pwm
		port map(
			clk => clk,
			duty => duty_b(n),
			pwm_out => led_b(n)
		);
	end generate;

	uart_tx_inst : entity work.uart_tx
	port map(
		clk => clk,
		data => tx_char,
		valid => '1',           -- always a byte waiting; tx_ready paces us
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
			if (tx_ready = '1') then       -- uart_tx just took tx_char
				if (frame_idx = 4) then
					frame_idx <= 0;
					frame_val <= sample;   -- latch once, so all 3 digits agree
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
			xadc_den <= '0';               -- den must be a one-cycle strobe
			if (xadc_eoc = '1') then
				xadc_den <= '1';           -- new result in 0x14, go read it
			elsif (xadc_drdy = '1') then
				sample <= unsigned(xadc_do(15 downto 4));
			end if;
		end if;
	end process;

end;
