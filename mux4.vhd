library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4 is
	port(
		s :		in	std_logic_vector(1 downto 0);
		ln0 :	in	std_logic;
		ln1 :	in	std_logic;
		ln2 :	in	std_logic;
		ln3 :	in	std_logic;
		z :		out	std_logic
	);
end mux4;

architecture behavioral of mux4 is
begin
	z <=
		ln0 when s = "00" else
		ln1 when s = "01" else
		ln2 when s = "10" else
		ln3 when s = "11" else
		'0' after 1 ns;
end behavioral;
