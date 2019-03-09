library ieee;
use ieee.std_logic_1164.all;

entity full_adder_tb is
end full_adder_tb;

architecture behavior of full_adder_tb is
	component full_adder
	port(
		x, y, c_in :	in std_logic;
		s, c_out :		out std_logic
	);
	end component;

	signal x, y, c_in :	std_logic;
	signal s, c_out :	std_logic;
begin
	uut: full_adder port map (
		x => x,
		y => y,
		c_in => c_in,
		s => s,
		c_out => c_out
	);

	sim_proc: process
	begin
		x <= '1';
		y <= '0';
		c_in <= '0';
		wait for 5 ns;

		c_in <= '1';
		wait for 5 ns;

		y <= '1';
		wait for 5 ns;

		x <= '0';
		y <= '0';
		wait for 5 ns;

		wait;
	end process;
end;
