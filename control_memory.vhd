library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_memory is
	port(
		address :	in	std_logic_vector(7 downto 0);
		cw :		out	std_logic_vector(27 downto 0)
	);
end control_memory;

architecture behavioral of control_memory is
	type mem_t is array(0 to 255) of std_logic_vector(27 downto 0);
	signal mem : mem_t := (
		others => x"0000000"
	);
begin
	cw <= mem(to_integer(unsigned(address)));
end behavioral;
