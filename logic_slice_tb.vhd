library ieee;
use ieee.std_logic_1164.all;

entity logic_slice_tb is
end logic_slice_tb;

architecture behavior of logic_slice_tb is
	component logic_slice
	port(
		s :		in	std_logic_vector(1 downto 0);
		a, b :	in	std_logic;
		z :		out	std_logic
	);
	end component;

	signal s :		std_logic_vector(1 downto 0);
	signal a, b :	std_logic;
	signal z :		std_logic;
begin
	uut: logic_slice port map (
		s => s,
		a => a,
		b => b,
		z => z
	);

	sim_proc: process
	begin
		a <= '1';
		b <= '1';

		s <= "00";
		wait for 5 ns;

		s <= "01";
		wait for 5 ns;

		b <= '0';
		s <= "10";
		wait for 5 ns;

		s <= "11";
		wait for 5 ns;

		wait;
	end process;
end;
