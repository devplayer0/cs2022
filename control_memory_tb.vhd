library ieee;
use ieee.std_logic_1164.all;

entity control_memory_tb is
end control_memory_tb;

architecture behavior of control_memory_tb is
	component control_memory
	port(
		address :	in	std_logic_vector(7 downto 0);
		cw :		out	std_logic_vector(27 downto 0)
	);
	end component;

	signal address :	std_logic_vector(7 downto 0);
	signal cw :			std_logic_vector(27 downto 0);
begin
	uut: control_memory port map (
		address => address,
		cw => cw
	);

	sim_proc: process
	begin
		address <= x"00";
		wait for 5 ns;

		address <= x"01";
		wait for 5 ns;

		address <= x"02";
		wait for 5 ns;

		wait;
	end process;
end;
