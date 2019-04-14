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
		-- main opcode table
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
		14 =>		x"8121004", -- SLI - shift left by immediate (stores source in r8), dst and a must be the same!
		15 =>		x"8021004", -- SL  - shift left by register (stores source in r8), dst and a must be the same!
		16 =>		x"8821004", -- SRI - shift right by immediate (stores source in r8), dst and a must be the same!
		17 =>		x"8721004", -- SR  - shift right by register (stores source in r8), dst and a must be the same!
		18 =>		x"c022000", -- B   - unconditional branch
		19 =>		x"8e20000", -- BEQ - branch if register is zero ("equal")
		127 =>		x"c020000", -- NOP - do nothing

		-- left shift
		128 =>		x"8220104", -- copy the shift amount into dst (from register)
		129 =>		x"0000304", -- copy the shift amount into dst (from immediate)
		130 =>		x"8680000", -- is the shift amount (in a) equal to 0? if so, go to setting dst to r8. otherwise, continue.
		131 =>		x"0001584", -- shift r8 left by one
		132 =>		x"0000064", -- decrement a
		133 =>		x"8220000", -- goto checking shift done
		134 =>		x"c020804", -- set dst to r8 and goto IF

		-- right shift
		135 =>		x"8920104", -- copy the shift amount into dst (from register)
		136 =>		x"0000304", -- copy the shift amount into dst (from immediate)
		137 =>		x"8d80000", -- is the shift amount (in a) equal to 0? if so, go to setting dst to r8. otherwise, continue.
		138 =>		x"0001544", -- shift r8 right by one
		139 =>		x"0000064", -- decrement a
		140 =>		x"8920000", -- goto checking shift done
		141 =>		x"c020804", -- set dst to r8 and goto IF

		-- beq
		142 =>		x"1280000", -- goto unconditional branch if zero
		143 =>		x"c020000", -- otherwise continue as normal

		192 =>		x"000c002", -- instruction fetch (and increment pc)
		193 =>		x"0030000", -- instruction execute

		others =>	x"0020000"  -- go to halt instruction if unknown opcode
	);
begin
	cw <= mem(to_integer(unsigned(address))) after 1 ns;
end behavioral;
