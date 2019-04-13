library ieee;
use ieee.std_logic_1164.all;

entity computer_tb is
end computer_tb;

architecture behavior of computer_tb is
	component computer is
		port(
			reset, clock :	in std_logic
		);
	end component;

	signal reset, clock :	std_logic := '0';
begin
	uut: computer port map (
		reset => reset,
		clock => clock
	);

	clock_proc: process
	begin
		wait for 32 ns;
		clock <= not clock;
	end process;
	sim_proc: process
	begin
		reset <= '1';
		wait for 5 ns;

		reset <= '0';
		wait for 2048 ns;

		std.env.stop;
		wait;
	end process;
end;
