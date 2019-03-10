library ieee;
use ieee.std_logic_1164.all;

entity alu_slice is
	port(
		s :				in	std_logic_vector(2 downto 0);
		a, b, c_in :	in	std_logic;
		z, c_out :		out	std_logic
	);
end alu_slice;

architecture behavior of alu_slice is
	component mux2
		port(
			s :		in	std_logic;
			ln0 :	in	std_logic;
			ln1 :	in	std_logic;
			z :		out	std_logic
		);
	end component;

	component arithmetic_slice
		port(
			s :		in	std_logic_vector(1 downto 0);
			a, b, c_in :	in	std_logic;
			z, c_out :		out	std_logic
		);
	end component;

	component logic_slice
		port(
			s :		in	std_logic_vector(1 downto 0);
			a, b :	in	std_logic;
			z :		out	std_logic
		);
	end component;

	signal z_arith, z_logic : std_logic;
begin
	arith: arithmetic_slice port map (
		s => s(1 downto 0),
		a => a,
		b => b,
		c_in => c_in,
		z => z_arith,
		c_out => c_out
	);

	logic: logic_slice port map (
		s => s(1 downto 0),
		a => a,
		b => a,
		z => z_logic
	);

	alu_mux: mux2 port map (
		s => s(2),
		ln0 => z_arith,
		ln1 => z_logic,
		z => z
	);
end;
