library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end alu_tb;

architecture behavior of alu_tb is
	component alu
		port(
			s :			in	std_logic_vector(2 downto 0);
			a, b :		in	std_logic_vector(15 downto 0);
			g :			out	std_logic_vector(15 downto 0);
			c_in :		in	std_logic;
			c_out, v :	out	std_logic
		);
	end component;

	signal s :				std_logic_vector(2 downto 0);
	signal a, b, g :		std_logic_vector(15 downto 0);
	signal c_in, c_out, v :	std_logic;
begin
	uut: alu port map (
		s => s,
		a => a,
		b => b,
		c_in => c_in,
		g => g,
		c_out => c_out,
		v => v
	);

	sim_proc: process
	begin
		a <= x"00ff";
		b <= x"0001";
		c_in <= '0';

		s <= "010";
		wait for 40 ns;

		c_in <= '1';
		wait for 40 ns;

		b <= x"fffe";
		s <= "001";
		wait for 40 ns;

		a <= x"fffe";
		b <= x"0001";
		s <= "010";
		wait for 40 ns;

		c_in <= '0';
		wait for 40 ns;

		a <= x"ffff";
		b <= x"8000";
		wait for 40 ns;

		a <= x"dead";
		b <= x"beef";
		s <= "110";
		wait for 4 ns;

		wait;
	end process;
end;
