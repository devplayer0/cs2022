library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8_16bit is
	port(
		s :		in	std_logic_vector(2 downto 0);
		ln0 :	in	std_logic_vector(15 downto 0);
		ln1 :	in	std_logic_vector(15 downto 0);
		ln2 :	in	std_logic_vector(15 downto 0);
		ln3 :	in	std_logic_vector(15 downto 0);
		ln4 :	in	std_logic_vector(15 downto 0);
		ln5 :	in	std_logic_vector(15 downto 0);
		ln6 :	in	std_logic_vector(15 downto 0);
		ln7 :	in	std_logic_vector(15 downto 0);
		z :		out	std_logic_vector(15 downto 0)
	);
end mux8_16bit;

architecture behavioral of mux8_16bit is
begin
	z <=
		ln0 when s = "000" else
		ln1 when s = "001" else
		ln2 when s = "010" else
		ln3 when s = "011" else
		ln4 when s = "100" else
		ln5 when s = "101" else
		ln6 when s = "110" else
		ln7 when s = "111" else
		x"0000" after 5 ns;
end Behavioral;

