library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flag_mux is
	port(
		n, z, v, c :	in	std_logic;
		s :				in	std_logic_vector(2 downto 0) := "000";
		flag :			out	std_logic
	);
end flag_mux;

architecture behavioral of flag_mux is
	signal flags : std_logic_vector(7 downto 0);
begin
	flags(7) <= not z;
	flags(6) <= not c;
	flags(5) <= n;
	flags(4) <= z;
	flags(3) <= v;
	flags(2) <= c;
	flags(1) <= '1';
	flags(0) <= '0';

	flag <= flags(to_integer(unsigned(s))) after 1 ns;
end behavioral;
