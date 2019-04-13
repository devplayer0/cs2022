library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_4to9 is
	port(
		a :	in	std_logic_vector(3 downto 0);
		q :	out	std_logic_vector(0 to 8)
	);
end decoder_4to9;

architecture behavioral of decoder_4to9 is
begin
	q <=
		"100000000" when a = "0000" else
		"010000000" when a = "0001" else
		"001000000" when a = "0010" else
		"000100000" when a = "0011" else
		"000010000" when a = "0100" else
		"000001000" when a = "0101" else
		"000000100" when a = "0110" else
		"000000010" when a = "0111" else
		"000000001" when a(3) = '1' else
		"000000000" after 1 ns;
end behavioral;
