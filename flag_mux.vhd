library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flag_mux is
	port(
		flags_in :	in	std_logic_vector(3 downto 0) := x"0";
		s :			in	std_logic_vector(2 downto 0) := "000";
		flag :		out	std_logic
	);
end flag_mux;

architecture behavioral of flag_mux is
	signal flags : std_logic_vector(7 downto 0);
begin
	flags(7) <= not flags_in(2);
	flags(6) <= not flags_in(0);
	flags(5 downto 2) <= flags_in;
	flags(1) <= '1';
	flags(0) <= '0';

	flag <= flags(to_integer(unsigned(s))) after 1 ns;
end behavioral;
