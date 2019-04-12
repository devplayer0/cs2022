library ieee;
use ieee.std_logic_1164.all;

entity flag_mux_tb is
end flag_mux_tb;

architecture behavior of flag_mux_tb is
	component flag_mux
	port(
		n, z, v, c :	in	std_logic;
		s :				in	std_logic_vector(2 downto 0) := "000";
		flag :			out	std_logic
	);
	end component;

	signal n, z, v, c, flag : std_logic := '0';
	signal s : std_logic_vector(2 downto 0);
begin
	uut: flag_mux port map (
		n => n,
		z => z,
		v => v,
		c => c,
		s => s,
		flag => flag
	);

	sim_proc: process
	begin
		n <= '0';
		s <= "101";
		wait for 10 ns;

		n <= '1';
		wait for 10 ns;

		s <= "001";
		wait for 10 ns;

		s <= "000";
		wait for 10 ns;

		s <= "111";
		wait for 10 ns;

		z <= '1';
		wait for 10 ns;

		s <= "100";
		wait for 10 ns;

		wait;
	end process;
end;
