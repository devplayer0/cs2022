library ieee;
use ieee.std_logic_1164.all;

entity reg16_tb is
end reg16_tb;

architecture behavior of reg16_tb is
	component reg16
	port(
		reset, load, clock :	in	std_logic;
		data :					in	std_logic_vector(15 downto 0);
		q :						out	std_logic_vector(15 downto 0)
	);
	end component;

	signal reset, load, clock :	std_logic := '0';
	signal data :				std_logic_vector(15 downto 0);
	signal q :					std_logic_vector(15 downto 0);
begin
	uut: reg16 port map (
		reset => reset,
		load => load,
		clock => clock,
		data => data,
		q => q
	);

	clock_proc: process
	begin
		wait for 10 ns;
		clock <= not clock;
	end process;
	sim_proc: process
	begin
		reset <= '1';
		wait for 20 ns;
		reset <= '0';
		wait for 20 ns;

		data <= x"dead";
		load <= '1';
		wait for 20 ns;

		data <= x"d0d0";
		load <= '0';
		wait for 20 ns;

		data <= x"beef";
		load <= '1';
		wait for 20 ns;

		load <= '0';
		wait for 20 ns;

		reset <= '1';
		wait for 20 ns;

		std.env.stop;
		wait;
	end process;
end;
