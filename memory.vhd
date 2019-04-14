library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
	port(
		address :		in	std_logic_vector(15 downto 0);
		data_in :		in	std_logic_vector(15 downto 0);
		clock, load : 	in	std_logic;
		data_out :		out	std_logic_vector(15 downto 0)
	);
end memory;

architecture behavioral of memory is
	type mem_t is array(0 to 511) of std_logic_vector(15 downto 0);
begin
	mem_proc: process(clock) is
		variable mem : mem_t := (
			0 =>		x"0203", -- adi r0, r0, 3
			1 =>		x"0242", -- adi r1, r0, 2
			2 =>		x"048c", -- sui r2, r1, 4
			3 =>		x"06d0", -- inc r3, r2
			4 =>		x"0918", -- dec r4, r3
			5 =>		x"0b59", -- add r5, r3, r1
			6 =>		x"0daa", -- sub r6, r5, r2
			7 =>		x"0fdd", -- and r7, r3, r5 ; (2 & 7)
			8 =>		x"11c8", -- or r7, r1, r0  ; (5 | 3)
			9 =>		x"13f5", -- xor r7, r6, r5 ; (6 ^ 7)
			10 =>		x"15c8", -- not r7, r1     ; (~5)

			11 =>		x"13b6", -- xor r6, r6, r6
			12 =>		x"17b0", -- ld r6, [r6]
			13 =>		x"036f", -- adi r5, r5, #7
			14 =>		x"036f", -- adi r5, r5, #7
			15 =>		x"036f", -- adi r5, r5, #7
			16 =>		x"036f", -- adi r5, r5, #7
			17 =>		x"036f", -- adi r5, r5, #7
			18 =>		x"182f", -- st r7, [r5] ; (r5 = 42)
			19 =>		x"17a8", -- ld r6, [r5]
			20 =>		x"1a2b", -- sti 3, [r5]
			21 =>		x"17a8", -- ld r6, [r5]

			22 =>		x"1db5", -- sli r6, 5
			23 =>		x"1f6b", -- sl r5, r3 ; (<< 2)
			24 =>		x"1db0", -- sli r6, 0
			25 =>		x"1292", -- xor r2, r2, r2
			26 =>		x"1f6a", -- sl r5, r2 ; (<< 0)

			27 =>		x"21fa", -- sri r7, 2
			28 =>		x"2368", -- sr r5, r0 ; (>> 3)

			29 =>		x"2403", -- b +3
			30 =>		x"13ff", -- xor r7, r7, r7
			31 =>		x"2402", -- b +2
			32 =>		x"03ff", -- adi r7, r7, 7
			33 =>		x"25c5", -- b -3

			34 =>		x"260a", -- beq +2, r1
			35 =>		x"0449", -- sui r1, r1, 1
			36 =>		x"25c5", -- b -3
			37 =>		x"024f", -- adi r1, r1, 7

			others =>	x"0000"  -- hlt
		);
	begin
		if rising_edge(clock) and load = '1' then
			mem(to_integer(unsigned(address(8 downto 0)))) := data_in;
		end if;
		data_out <= mem(to_integer(unsigned(address(8 downto 0))));
	end process;
end behavioral;
