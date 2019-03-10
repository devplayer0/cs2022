library ieee;
use ieee.std_logic_1164.all;

entity shifter is
	port(
		s :			in	std_logic_vector(1 downto 0);
		ir, il :	in std_logic;
		b :			in	std_logic_vector(15 downto 0);
		h :			out	std_logic_vector(15 downto 0)
	);
end shifter;

architecture behavior of shifter is
	component mux3
		port(
			s :		in	std_logic_vector(1 downto 0);
			ln0 :	in	std_logic;
			ln1 :	in	std_logic;
			ln2 :	in	std_logic;
			z :		out	std_logic
		);
	end component;
begin
	gen_shifter: for i in 0 to 15 generate
		lo: if i=0 generate
			lo: mux3 port map (
				s => s,
				ln0 => b(i),
				ln1 => b(i+1),
				ln2 => il,
				z => h(i)
			);
		end generate lo;

		other: if i /= 0 and i /= 15 generate
			bitn: mux3 port map (
				s => s,
				ln0 => b(i),
				ln1 => b(i+1),
				ln2 => b(i-1),
				z => h(i)
			);
		end generate other;

		hi: if i=15 generate
			hi: mux3 port map (
				s => s,
				ln0 => b(i),
				ln1 => ir,
				ln2 => b(i-1),
				z => h(i)
			);
		end generate hi;
	end generate gen_shifter;
end;
