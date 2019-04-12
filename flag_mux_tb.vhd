library ieee;
use ieee.std_logic_1164.all;

entity flag_mux_tb is
end flag_mux_tb;

architecture behavior of flag_mux_tb is
	component flag_mux
	port(
		flags_in :	in	std_logic_vector(3 downto 0) := x"0";
		s :			in	std_logic_vector(2 downto 0) := "000";
		flag :		out	std_logic
	);
	end component;

	signal flags_in :	std_logic_vector(3 downto 0) := x"0";
	signal flag :		std_logic := '0';
	signal s :			std_logic_vector(2 downto 0) := "000";
begin
	uut: flag_mux port map (
		flags_in => flags_in,
		flag => flag,
		s => s
	);

	sim_proc: process
	begin
		s <= "101";
		wait for 10 ns;

		flags_in(3) <= '1';
		wait for 10 ns;

		s <= "001";
		wait for 10 ns;

		s <= "000";
		wait for 10 ns;

		s <= "111";
		wait for 10 ns;

		flags_in(2) <= '1';
		wait for 10 ns;

		s <= "100";
		wait for 10 ns;

		wait;
	end process;
end;
