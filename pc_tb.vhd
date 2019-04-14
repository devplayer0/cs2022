library ieee;
use ieee.std_logic_1164.all;

entity pc_tb is
end pc_tb;

architecture behavior of pc_tb is
	component pc
	port(
		clock, reset, inc, load :	in	std_logic;
		offset :					in	std_logic_vector(15 downto 0);
		value : 					out	std_logic_vector(15 downto 0)
	);
	end component;

	signal clock, reset, inc, load :	std_logic := '0';
	signal offset, value :				std_logic_vector(15 downto 0);
begin
	uut: pc port map (
		clock => clock,
		reset => reset,
		inc => inc,
		load => load,
		offset => offset,
		value => value
	);

	clock_proc: process
	begin
		wait for 32 ns;
		clock <= not clock;
	end process;

	sim_proc: process
	begin
		reset <= '1';
		wait for 64 ns;

		reset <= '0';
		wait for 64 ns;

		inc <= '1';
		wait for 100 ns;

		inc <= '0';
		load <= '1';
		offset <= x"0005";
		wait for 64 ns;

		load <= '0';
		inc <= '1';
		wait for 100 ns;

		std.env.stop;
		wait;
	end process;
end;
