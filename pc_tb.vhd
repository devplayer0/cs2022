library ieee;
use ieee.std_logic_1164.all;

entity pc_tb is
end pc_tb;

architecture behavior of pc_tb is
	component pc
	port(
		reset, inc, load :	in	std_logic;
		offset :			in	std_logic_vector(15 downto 0);
		value : 			out	std_logic_vector(15 downto 0)
	);
	end component;

	signal reset, inc, load :	std_logic;
	signal offset, value :		std_logic_vector(15 downto 0);
begin
	uut: pc port map (
		reset => reset,
		inc => inc,
		load => load,
		offset => offset,
		value => value
	);

	sim_proc: process
	begin
		reset <= '1';
		wait for 5 ns;

		reset <= '0';
		wait for 5 ns;

		inc <= '1';
		wait for 5 ns;

		inc <= '0';
		load <= '1';
		offset <= x"0005";
		wait for 5 ns;

		wait;
	end process;
end;
