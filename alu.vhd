library ieee;
use ieee.std_logic_1164.all;

entity alu is
	port(
		s :			in	std_logic_vector(2 downto 0);
		a, b :		in	std_logic_vector(15 downto 0);
		g :			out	std_logic_vector(15 downto 0);
		c_in :		in	std_logic;
		c_out, v :	out	std_logic
	);
end alu;

architecture behavior of alu is
	component alu_slice
		port(
			s :				in	std_logic_vector(2 downto 0);
			a, b, c_in :	in	std_logic;
			z, c_out :		out	std_logic
		);
	end component;

	signal c : std_logic_vector(15 downto 0);
begin
	gen_alu: for i in 0 to 15 generate
		lo: if i=0 generate
			slice0: alu_slice port map (
				s => s,
				a => a(i),
				b => b(i),
				c_in => c_in,
				z => g(i),
				c_out => c(i)
			);
		end generate lo;

		other: if i>0 generate
			slicen: alu_slice port map (
				s => s,
				a => a(i),
				b => b(i),
				c_in => c(i-1),
				z => g(i),
				c_out => c(i)
			);
		end generate other;
	end generate gen_alu;

	c_out <= c(15);
	v <= c(15) xor c(14);
end;
