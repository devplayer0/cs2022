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
		3 =>		x"c020014", -- INC - increment register
		4 =>		x"c020064", -- DEC - decrement register
		5 =>		x"c020024", -- ADD - add registers
		6 =>		x"c020054", -- SUB - subtract registers
		7 =>		x"c020084", -- AND - logical &
		8 =>		x"c0200a4", -- OR  - logical |
		9 =>		x"c0200c4", -- XOR - logical ^
		10 =>		x"c0200e4", -- NOT - logical ~
		11 =>		x"c02000c", -- LD  - load from memory
		12 =>		x"c020001", -- ST  - store to memory
		13 =>		x"c020201", -- STI - store immediate to memory

		192 =>		x"001c002", -- instruction fetch
		193 =>		x"0030000", -- instruction execute

		others =>	x"0020000"  -- go to halt instruction if unknown opcode
	);
begin
	cw <= mem(to_integer(unsigned(address)));
end behavioral;
