
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cic is port (
	clk  : in  std_logic;
	en   : in  std_logic;
	din  : in  unsigned(11 downto 0) := (others => '0');
	dout : out unsigned(11 downto 0) := (others => '0');
	rdy  : out std_logic := '0');
end;

architecture rtl of cic is
	constant M : integer := 256;
	constant N : integer := 3;
	type u36_array is array(integer range<>) of unsigned(35 downto 0);
	signal int_pipe : u36_array(0 to N) := (others => (others => '0'));
	signal int_out : unsigned(35 downto 0);
	signal count : integer range 0 to M-1 := 0;
	signal comb_strobe : std_logic := '0';
	signal comb_in : unsigned(35 downto 0);
	signal comb_hold : u36_array(0 to N-1) := (others => (others => '0'));
	signal comb_pipe : u36_array(0 to N) := (others => (others => '0'));
begin

	integrator : process(clk)
	begin
		if (rising_edge(clk)) then
			if (en = '1') then
				int_pipe(0) <= resize(din, 36);
				for i in 1 to N loop
					int_pipe(i) <= int_pipe(i) + int_pipe(i-1);
				end loop;
				int_out <= int_pipe(int_pipe'right);
			end if;
		end if;
	end process;

	decimator : process(clk)
	begin
		if (rising_edge(clk)) then
			comb_strobe <= '0';
			if (en = '1') then
				if count /= M-1 then count <= count + 1; end if;
				if (count = M-1) then
					count <= 0;
					comb_strobe <= '1';
					comb_in <= int_out;
				end if;
			end if;
		end if;
	end process;

	comb : process(clk)
	begin
		if (rising_edge(clk)) then
			rdy <= '0';
			if (comb_strobe = '1') then
				comb_pipe(0) <= comb_in;
				comb_hold(0) <= comb_pipe(0);
				for i in 1 to N loop
					comb_pipe(i) <= comb_pipe(i-1) - comb_hold(i-1);
					if (i < N) then
						comb_hold(i) <= comb_pipe(i);
					end if;
				end loop;
				dout <= comb_pipe(comb_pipe'right)(35 downto 24);
				rdy <= '1';
			end if;
		end if;
	end process;

end;
