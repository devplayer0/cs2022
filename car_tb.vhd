library ieee;
use ieee.std_logic_1164.all;

entity car_tb is
end car_tb;

architecture behavior of car_tb is
	component car
	port(
		reset, clock, load :	in	std_logic;
		to_load :				in	std_logic_vector(7 downto 0);
		address :				out	std_logic_vector(7 downto 0)
	);
	end component;

	signal reset, clock, load :	std_logic := '0';
	signal to_load, address :	std_logic_vector(7 downto 0);
begin
	uut: car port map (
		reset => reset,
		clock => clock,
		load => load,
		to_load => to_load,
		address => address
	);

	clock_proc: process
	begin
		wait for 32 ns;
		clock <= not clock;
	end process;
	sim_proc: process
	begin
		wait for 128 ns;

		to_load <= x"be";
		wait for 64 ns;

		load <= '1';
		wait for 64 ns;

		reset <= '1';
		wait for 64 ns;

		std.env.stop;
		wait;
	end process;
end;
