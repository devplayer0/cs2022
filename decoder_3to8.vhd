library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_3to8 is
	port(
		a :	in	std_logic_vector(2 downto 0);
		q :	out	std_logic_vector(0 to 7)
	);
end decoder_3to8;

architecture behavioral of decoder_3to8 is
begin
	q <=
		"10000000" when a = "000" else
		"01000000" when a = "001" else
		"00100000" when a = "010" else
		"00010000" when a = "011" else
		"00001000" when a = "100" else
		"00000100" when a = "101" else
		"00000010" when a = "110" else
		"00000001" when a = "111" else
		x"00" after 5 ns;
end behavioral;
