library ieee;
use ieee.std_logic_1164.all;

entity arith_b_fn_tb is
end arith_b_fn_tb;

architecture behavior of arith_b_fn_tb is
	component arith_b_fn
	port(
		s :	in	std_logic_vector(1 downto 0);
		b :	in	std_logic;
		y :	out	std_logic
	);
	end component;

	signal s :	std_logic_vector(1 downto 0);
	signal b :	std_logic;
	signal y :	std_logic;
begin
	uut: arith_b_fn port map (
		s => s,
		b => b,
		y => y
	);

	sim_proc: process
	begin
		b <= '0';

		s <= "00";
		wait for 5 ns;

		b <= '1';
		wait for 5 ns;

		s <= "01";
		wait for 5 ns;

		s <= "10";
		wait for 5 ns;

		s <= "11";
		wait for 5 ns;

		b <= '0';
		wait for 5 ns;

		wait;
	end process;
end;
