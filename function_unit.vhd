library ieee;
use ieee.std_logic_1164.all;

entity function_unit is
	port(
		a, b :			in	std_logic_vector(15 downto 0);
		fs :			in	std_logic_vector(4 downto 0);
		f :				out	std_logic_vector(15 downto 0);
		v, c, n, z :	out std_logic
	);
end function_unit;

architecture behavior of function_unit is
	component mux2_16bit
	port(
		s :		in	std_logic;
		ln0 :	in	std_logic_vector(15 downto 0);
		ln1 :	in	std_logic_vector(15 downto 0);
		z :		out	std_logic_vector(15 downto 0)
	);

	end component;
	component alu
		port(
			s :			in	std_logic_vector(2 downto 0);
			a, b :		in	std_logic_vector(15 downto 0);
			g :			out	std_logic_vector(15 downto 0);
			c_in :		in	std_logic;
			c_out, v :	out	std_logic
		);
	end component;

	component shifter
		port(
			s :			in	std_logic_vector(1 downto 0);
			ir, il :	in	std_logic;
			b :			in	std_logic_vector(15 downto 0);
			h :			out	std_logic_vector(15 downto 0)
		);
	end component;

	signal g_alu, g_shifter, f_mux_out : std_logic_vector(15 downto 0);
begin
	alu0: alu port map (
		s => fs(3 downto 1),
		a => a,
		b => b,
		g => g_alu,
		c_in => fs(0),
		c_out => c,
		v => v
	);

	shifter0: shifter port map (
		s => fs(3 downto 2),
		ir => '0',
		il => '0',
		b => b,
		h => g_shifter
	);

	f_mux: mux2_16bit port map (
		s => fs(4),
		ln0 => g_alu,
		ln1 => g_shifter,
		z => f_mux_out 
	);

	f <= f_mux_out;
	n <= f_mux_out(15);
	z <= '1' when f_mux_out = x"0000" else '0';
end;
