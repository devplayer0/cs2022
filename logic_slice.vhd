library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logic_slice is
	port(
		s :		in	std_logic_vector(1 downto 0);
		a, b :	in	std_logic;
		z :		out	std_logic
	);
end logic_slice;

architecture behavioral of logic_slice is
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

	signal aand, oor, xxor, nnot : std_logic;
begin
	mux: mux4 port map (
		s => s,
		ln0 => aand,
		ln1 => oor,
		ln2 => xxor,
		ln3 => nnot,
		z => z
	);

	aand <= a and b after 1 ns;
	oor <= a or b after 1 ns;
	xxor <= a xor b after 1 ns;
	nnot <= not a after 1 ns;
end behavioral;
