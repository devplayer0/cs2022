library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arithmetic_slice is
	port(
		s :		in	std_logic_vector(1 downto 0);
		a, b, c_in :	in	std_logic;
		z, c_out :		out	std_logic
	);
end arithmetic_slice;

architecture behavioral of arithmetic_slice is
	component arith_b_fn
		port(
			s :	in	std_logic_vector(1 downto 0);
			b :	in	std_logic;
			y :	out	std_logic
		);
	end component;

	component full_adder
		port(
			x, y, c_in :	in std_logic;
			s, c_out :		out std_logic
		);
	end component;

	signal fa_b : std_logic;
begin
	b_fn: arith_b_fn port map (
		b => b,
		s => s,
		y => fa_b
	);
	fa: full_adder port map (
		x => a,
		y => fa_b,
		c_in => c_in,
		c_out => c_out,
		s => z
	);
end behavioral;
