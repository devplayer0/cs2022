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
		"10000000" when a = x"0" else
		"01000000" when a = x"1" else
		"00100000" when a = x"2" else
		"00010000" when a = x"3" else
		"00001000" when a = x"4" else
		"00000100" when a = x"5" else
		"00000010" when a = x"6" else
		"00000001" when a = x"7" else
		x"00" after 5 ns;
end Behavioral;

