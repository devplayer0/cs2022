library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_extend is
	port(
		offset_6b :	in	std_logic_vector(5 downto 0);
		extended : 	out	std_logic_vector(15 downto 0)
	);
end pc_extend;

architecture behavioral of pc_extend is
begin
	extended(15 downto 6) <= (others => '1') when offset_6b(5) = '1' else (others => '0');
	extended(5 downto 0) <= offset_6b;
end behavioral;
