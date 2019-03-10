library ieee;
use ieee.std_logic_1164.all;

entity function_unit_tb is
end function_unit_tb;

architecture behavior of function_unit_tb is
	component function_unit
		port(
			a, b :			in	std_logic_vector(15 downto 0);
			fs :			in	std_logic_vector(4 downto 0);
			f :				out	std_logic_vector(15 downto 0);
			v, c, n, z :	out std_logic
		);
	end component;

	signal a, b, f :	std_logic_vector(15 downto 0);
	signal fs :			std_logic_vector(4 downto 0);
	signal v, c, n, z :	std_logic;
begin
	uut: function_unit port map (
		a => a,
		b => b,
		fs => fs,
		f => f,
		v => v,
		c => c,
		n => n,
		z => z
	);

	sim_proc: process
	begin
		a <= x"00fc";
		b <= x"0003";

		-- arithmetic
		-- transfer A
		fs <= "00000";
		wait for 50 ns;

		-- increment
		fs <= "00001";
		wait for 50 ns;

		-- add
		fs <= "00010";
		wait for 50 ns;

		-- add w/ carry
		fs <= "00011";
		wait for 50 ns;

		-- add a + ~b
		fs <= "00100";
		wait for 50 ns;

		-- subtract
		fs <= "00101";
		wait for 50 ns;

		-- decrement
		fs <= "00110";
		wait for 50 ns;

		-- transfer
		fs <= "00111";
		wait for 50 ns;

		-- logic
		-- and
		fs <= "01000";
		wait for 4 ns;

		-- or
		fs <= "01010";
		wait for 4 ns;

		-- xor
		fs <= "01100";
		wait for 4 ns;

		-- not
		fs <= "01110";
		wait for 4 ns;


		-- shifting
		-- transfer b
		fs <= "10000";
		wait for 4 ns;

		-- shift right
		fs <= "10100";
		wait for 4 ns;

		-- shift left
		fs <= "11000";
		wait for 4 ns;

		wait;
	end process;
end;
