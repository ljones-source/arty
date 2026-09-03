library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
	port (
		clk   : in  std_logic;
		sw    : in  std_logic_vector(3 downto 0);
		led   : out std_logic_vector(3 downto 0);
		led_r : out std_logic_vector(3 downto 0);
		led_g : out std_logic_vector(3 downto 0);
		led_b : out std_logic_vector(3 downto 0));
end top;

architecture rtl of top is
	signal counter : unsigned(31 downto 0) := (others => '0');
	signal sec     : unsigned(1 downto 0)  := (others => '0');
	type u8_array is array(integer range<>) of unsigned(7 downto 0);
	signal duty_r  : u8_array(0 to 3);
	signal duty_g  : u8_array(0 to 3);
	signal duty_b  : u8_array(0 to 3);
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
end;
