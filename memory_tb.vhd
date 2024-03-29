library ieee;
use ieee.std_logic_1164.all;

entity memory_tb is
end memory_tb;

architecture behavior of memory_tb is
	component memory
	port(
		address :	in	std_logic_vector(15 downto 0);
		data_in :	in	std_logic_vector(15 downto 0);
		load : 		in	std_logic;
		data_out :	out	std_logic_vector(15 downto 0)
	);
	end component;

	signal address, data_in, data_out :	std_logic_vector(15 downto 0) := x"0000";
	signal load : 						std_logic := '0';
begin
	uut: memory port map (
		address => address,
		data_in => data_in,
		load => load,
		data_out => data_out
	);

	sim_proc: process
	begin
		address <= x"0000";
		wait for 5 ns;

		address <= x"0001";
		wait for 5 ns;

		address <= x"0002";
		wait for 5 ns;

		data_in <= x"f00d";
		load <= '1';
		wait for 5 ns;

		load <= '0';
		wait for 5 ns;

		wait;
	end process;
end;
