library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16 is
	port(
		load :	in	std_logic;
		clock :	in	std_logic;
		data :	in	std_logic_vector(15 downto 0);
		q :		out	std_logic_vector(15 downto 0) := x"0000"
	);
end reg16;

architecture behavioral of reg16 is
begin
	process(clock) begin
		if (rising_edge(clock)) then
			if load = '1' then
				q <= data after 5 ns;
			end if;
		end if;
	end process;
end behavioral;
