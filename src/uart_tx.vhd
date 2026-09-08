library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Baud Rate = 9600
-- Bits = 8 LSB first
-- Parity Bits = none
-- Stop Bits = 1

entity uart_tx is
	generic(
		CLK_FRQ   : integer := 100_000_000;
		BAUD_RATE : integer := 9600
	);
	port (
		clk     : in  std_logic;					-- 100MHz
		data    : in  std_logic_vector(7 downto 0); -- data must be valid when ready goes high
		valid   : in  std_logic;					-- pulse for 1 clk to send data
		ready   : out std_logic := '1';				-- low when a tx starts, high after done
		uart_tx : out std_logic := '1'				-- connect to external pin
	);
end;

architecture rtl of uart_tx is
	signal   done        : std_logic                      := '0'; -- goes high when the stop bit ends
	signal   tx_data     : std_logic_vector(9 downto 0)   := (others => '1');
	constant MAX_COUNT   : integer                        := (CLK_FRQ / BAUD_RATE) - 1;
	signal   count       : integer range 0 to MAX_COUNT   := 0;
	constant MAX_BITS    : integer                        := 9;
	signal   bit_index   : integer range 0 to MAX_BITS    := 0;
begin

	process(clk) is
	begin
		if (rising_edge(clk)) then
			if (ready = '1') then
				if (valid = '1') then
					ready <= '0';
					tx_data <= '1' & data & '0';
				end if;
			else
				if (done = '1') then
					ready <= '1';
				end if;
			end if;
		end if;
	end process;

	uart_tx <= '1' when (ready = '1') else tx_data(bit_index);

	baud_timer : process(clk) is
	begin
		if (rising_edge(clk)) then
			if (ready = '1') then
				count <= 0;
				bit_index <= 0;
				done <= '0';
			else
				if (count = MAX_COUNT) then
					if (bit_index = MAX_BITS) then
						done <= '1';
					else
						bit_index <= bit_index + 1;
					end if;
					count <= 0;
				else
					count <= count + 1;
				end if;
			end if;
		end if;
	end process;

end;
