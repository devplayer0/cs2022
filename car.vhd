library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity car is
	port(
		reset, clock, load :	in	std_logic;
		to_load :				in	std_logic_vector(7 downto 0);
		address :				out	std_logic_vector(7 downto 0)
	);
end car;

architecture behavioral of car is
begin
	process(clock, reset)
		variable cur_value : unsigned(7 downto 0) := x"00";
	begin
		if (reset = '1') then
			cur_value := x"c0";
		elsif (rising_edge(clock)) then
			if load = '1' then
				cur_value := unsigned(to_load);
			else
				cur_value := cur_value + 1;
			end if;
		end if;
		address <= std_logic_vector(cur_value) after 1 ns;
	end process;
end behavioral;
