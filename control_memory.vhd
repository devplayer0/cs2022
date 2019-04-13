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
		0 =>		x"0020000", -- HLT - halt (loop forever)
		1 =>		x"c020224", -- ADI - add immediate
		2 =>		x"c020254", -- SUI - subtract immediate

		192 =>		x"001c002", -- instruction fetch
		193 =>		x"0030000", -- instruction execute

		others =>	x"0020000"  -- go to halt instruction if unknown opcode
	);
begin
	cw <= mem(to_integer(unsigned(address)));
end behavioral;
