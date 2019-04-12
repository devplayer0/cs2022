library ieee;
use ieee.std_logic_1164.all;

entity datapath is
	port(
		clock :					in	std_logic;
		cw :					in	std_logic_vector(19 downto 0);
		const, data_in :		in	std_logic_vector(15 downto 0);
		address_out, data_out :	out	std_logic_vector(15 downto 0);
		v, c, n, z :			out std_logic
	);
end datapath;

architecture behavior of datapath is
	component mux2_16bit
	port(
		s :		in	std_logic;
		ln0 :	in	std_logic_vector(15 downto 0);
		ln1 :	in	std_logic_vector(15 downto 0);
		z :		out	std_logic_vector(15 downto 0)
	);
	end component;

	component register_file
		port(
			dst_reg:	in	std_logic_vector(3 downto 0);
			clock :		in	std_logic;
			data :		in	std_logic_vector(15 downto 0);
			load :		in	std_logic;
			a_select :	in	std_logic_vector(3 downto 0) := "0000";
			b_select :	in	std_logic_vector(3 downto 0) := "0000";
			a : 		out	std_logic_vector(15 downto 0);
			b : 		out	std_logic_vector(15 downto 0)
		);
	end component;

	component function_unit
		port(
			a, b :			in	std_logic_vector(15 downto 0);
			fs :			in	std_logic_vector(4 downto 0);
			f :				out	std_logic_vector(15 downto 0);
			v, c, n, z :	out std_logic
		);
	end component;

	signal md_out, f_in_a, f_in_b, mb_in_reg, md_in_f : std_logic_vector(15 downto 0);
begin
	registers: register_file port map (
		dst_reg => cw(19 downto 16),
		clock => clock,
		data => md_out,
		load => cw(0),
		a_select => cw(15 downto 12),
		b_select => cw(11 downto 8),
		a => f_in_a,
		b => mb_in_reg
	);

	mb: mux2_16bit port map (
		s => cw(7),
		ln0 => mb_in_reg,
		ln1 => const,
		z => f_in_b
	);

	f: function_unit port map (
		a => f_in_a,
		b => f_in_b,
		fs => cw(6 downto 2),
		f => md_in_f,
		v => v,
		c => c,
		n => n,
		z => z
	);

	md: mux2_16bit port map (
		s => cw(1),
		ln0 => md_in_f,
		ln1 => data_in,
		z => md_out
	);

	address_out <= f_in_a;
	data_out <= f_in_b;
end;
