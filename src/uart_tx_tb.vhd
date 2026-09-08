library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- sends "Hello" + LF at a fast baud rate so the sim stays short
entity uart_tx_tb is
end;

architecture tb of uart_tx_tb is
	constant CLK_PERIOD : time    := 10 ns; -- 100MHz
	constant CLK_FRQ    : integer := 100_000_000;
	constant BAUD_RATE  : integer := 25_000_000; -- 4 clks per bit
	constant SKEW       : time    := CLK_PERIOD / 4;
	constant MSG        : string  := "Hello" & LF;

	signal clk   : std_logic := '0';
	signal data  : std_logic_vector(7 downto 0);
	signal valid : std_logic := '0';
	signal ready : std_logic;
	signal tx    : std_logic;
begin

	dut : entity work.uart_tx
		generic map(
			CLK_FRQ   => CLK_FRQ,
			BAUD_RATE => BAUD_RATE
		)
		port map(
			clk     => clk,
			data    => data,
			valid   => valid,
			ready   => ready,
			uart_tx => tx
		);

	clk <= not clk after CLK_PERIOD / 2;

	process
	begin
		wait until rising_edge(clk);
		wait for SKEW; -- drive just after a clk edge, never on one

		for i in MSG'range loop
			data  <= std_logic_vector(to_unsigned(character'pos(MSG(i)), 8));
			valid <= '1';
			wait until rising_edge(clk);
			wait until rising_edge(clk) and ready = '1'; -- byte accepted
		end loop;
		valid <= '0';

		wait until rising_edge(clk) and ready = '1'; -- last frame finished
		report "sent " & MSG severity note;
		std.env.stop; -- stop, not finish: finish kills xsim and closes the wave window
	end process;

end;
