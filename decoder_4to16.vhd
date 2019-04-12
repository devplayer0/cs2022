library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_4to16 is
	port(
		a :	in	std_logic_vector(3 downto 0);
		q :	out	std_logic_vector(0 to 15)
	);
end decoder_4to16;

architecture behavioral of decoder_4to16 is
begin
	q <=
		"1000000000000000" when a = "0000" else
		"0100000000000000" when a = "0001" else
		"0010000000000000" when a = "0010" else
		"0001000000000000" when a = "0011" else
		"0000100000000000" when a = "0100" else
		"0000010000000000" when a = "0101" else
		"0000001000000000" when a = "0110" else
		"0000000100000000" when a = "0111" else
		"0000000010000000" when a = "1000" else
		"0000000001000000" when a = "1001" else
		"0000000000100000" when a = "1010" else
		"0000000000010000" when a = "1011" else
		"0000000000001000" when a = "1100" else
		"0000000000000100" when a = "1101" else
		"0000000000000010" when a = "1110" else
		"0000000000000001" when a = "1111" else
		x"0000" after 1 ns;
end behavioral;
