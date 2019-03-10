library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2 is
	port(
		s :		in	std_logic;
		ln0 :	in	std_logic;
		ln1 :	in	std_logic;
		z :		out	std_logic
	);
end mux2;

architecture behavioral of mux2 is
begin
	z <=
		ln0 when s = '0' else
		ln1 when s = '1' else
		'0' after 1 ns;
end behavioral;
