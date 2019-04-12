library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2_8bit is
	port(
		s :		in	std_logic;
		ln0 :	in	std_logic_vector(7 downto 0);
		ln1 :	in	std_logic_vector(7 downto 0);
		z :		out	std_logic_vector(7 downto 0)
	);
end mux2_8bit;

architecture behavioral of mux2_8bit is
begin
	z <=
		ln0 when s = '0' else
		ln1 when s = '1' else
		x"00" after 1 ns;
end behavioral;
