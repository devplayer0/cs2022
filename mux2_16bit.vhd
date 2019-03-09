library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2_16bit is
	port(
		s :		in	std_logic;
		ln0 :	in	std_logic_vector(15 downto 0);
		ln1 :	in	std_logic_vector(15 downto 0);
		z :		out	std_logic_vector(15 downto 0)
	);
end mux2_16bit;

architecture behavioral of mux2_16bit is
begin
	z <=
		ln0 when s = '0' else
		ln1 when s = '1' else
		x"0000" after 1 ns;
end behavioral;
