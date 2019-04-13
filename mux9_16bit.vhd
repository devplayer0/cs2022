library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux9_16bit is
	port(
		s :		in	std_logic_vector(3 downto 0);
		ln0 :	in	std_logic_vector(15 downto 0);
		ln1 :	in	std_logic_vector(15 downto 0);
		ln2 :	in	std_logic_vector(15 downto 0);
		ln3 :	in	std_logic_vector(15 downto 0);
		ln4 :	in	std_logic_vector(15 downto 0);
		ln5 :	in	std_logic_vector(15 downto 0);
		ln6 :	in	std_logic_vector(15 downto 0);
		ln7 :	in	std_logic_vector(15 downto 0);
		ln8 :	in	std_logic_vector(15 downto 0);
		z :		out	std_logic_vector(15 downto 0)
	);
end mux9_16bit;

architecture behavioral of mux9_16bit is
begin
	z <=
		ln0 when s = "0000" else
		ln1 when s = "0001" else
		ln2 when s = "0010" else
		ln3 when s = "0011" else
		ln4 when s = "0100" else
		ln5 when s = "0101" else
		ln6 when s = "0110" else
		ln7 when s = "0111" else
		ln8 when s(3) = '1' else
		x"0000" after 1 ns;
end behavioral;
