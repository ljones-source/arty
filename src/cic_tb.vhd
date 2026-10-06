library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- sends "Hello" + LF at a fast baud rate so the sim stays short
entity cic_tb is
end;

architecture tb of cic_tb is
	constant CLK_PERIOD : time    := 10 ns; -- 100MHz

	signal t0   : std_logic := '1';
	signal clk  : std_logic := '0';
	signal din  : unsigned(11 downto 0) := (others => '0');
	signal dout : unsigned(11 downto 0);
	signal rdy  : std_logic;
begin

	clk <= not clk after CLK_PERIOD / 2;

	dut : entity work.cic
		port map(
			clk => clk,
			en => '1',
			din => din,
			dout => dout,
			rdy => rdy
		);

	process (clk)
	begin
		if (rising_edge(clk)) then
			if (t0 = '1') then
				din <= to_unsigned(0, 12);
				t0 <= '0';
			else
				din <= to_unsigned(4, 12);
			end if;
		end if;
	end process;

end;
