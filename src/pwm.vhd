library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm is port (
	clk : in std_logic;
	duty : in unsigned(7 downto 0);
	pwm_out : out std_logic);
end;

architecture rtl of pwm is
	signal count : unsigned(7 downto 0) := (others => '0');
begin
	process(clk) is
	begin
		if (rising_edge(clk)) then
			count <= count + 1;
		end if;
	end process;

	pwm_out <= '1' when (count < duty) else '0';

end;
