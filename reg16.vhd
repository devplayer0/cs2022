library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16 is
	port(
		reset, load, clock :	in	std_logic;
		data :					in	std_logic_vector(15 downto 0);
		q :						out	std_logic_vector(15 downto 0)
	);
end reg16;

architecture behavioral of reg16 is
begin
	process(reset, clock) begin
		if reset = '1' then
			q <= X"0000" after 1 ns;
		elsif (rising_edge(clock)) then
			if load = '1' then
				q <= data after 1 ns;
			end if;
		end if;
	end process;
end behavioral;
