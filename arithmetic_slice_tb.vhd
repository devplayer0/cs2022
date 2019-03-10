library ieee;
use ieee.std_logic_1164.all;

entity arithmetic_slice_tb is
end arithmetic_slice_tb;

architecture behavior of arithmetic_slice_tb is
	component arithmetic_slice
	port(
		s :				in	std_logic_vector(1 downto 0);
		a, b, c_in :	in	std_logic;
		z, c_out :		out	std_logic
	);
	end component;

	signal s :			std_logic_vector(1 downto 0);
	signal a, b, c_in :	std_logic;
	signal z, c_out :	std_logic;
begin
	uut: arithmetic_slice port map (
		s => s,
		a => a,
		b => b,
		c_in => c_in,
		z => z,
		c_out => c_out
	);

	sim_proc: process
	begin
		a <= '1';
		b <= '1';
		c_in <= '0';

		s <= "00";
		wait for 5 ns;

		s <= "10";
		wait for 5 ns;

		s <= "01";
		wait for 5 ns;

		b <= '0';
		s <= "11";
		wait for 5 ns;

		a <= '0';
		wait for 5 ns;

		wait;
	end process;
end;
