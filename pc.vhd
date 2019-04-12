library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
	port(
		clock, reset, inc, load :	in	std_logic;
		offset :					in	std_logic_vector(15 downto 0);
		value : 					out	std_logic_vector(15 downto 0) := x"0000"
	);
end pc;

architecture behavioral of pc is
begin
	pc_proc: process(reset, clock)
		variable cur_val : unsigned(15 downto 0);
	begin
		if (reset = '1') then cur_val := x"0000";
		elsif (rising_edge(clock)) then
			if (inc = '1') then
				cur_val := cur_val + 1;
			elsif (load = '1') then
				cur_val := cur_val + unsigned(offset);
			end if;
		end if;
		value <= std_logic_vector(cur_val) after 1 ns;
	end process;
end behavioral;
