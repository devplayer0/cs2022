library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arith_b_fn is
	port(
		s :	in	std_logic_vector(1 downto 0);
		b :	in	std_logic;
		y :	out	std_logic
	);
end arith_b_fn;

architecture behavioral of arith_b_fn is
	component mux4
	port(
		s :		in	std_logic_vector(1 downto 0);
		ln0 :	in	std_logic;
		ln1 :	in	std_logic;
		ln2 :	in	std_logic;
		ln3 :	in	std_logic;
		z :		out	std_logic
	);
	end component;

	signal nb: std_logic;
begin
	mux: mux4 port map (
		s => s,
		ln0 => '0',
		ln1 => b,
		ln2 => nb,
		ln3 => '1',
		z => y
	);

	nb <= not b;
end behavioral;
