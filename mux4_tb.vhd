library ieee;
use ieee.std_logic_1164.all;

entity mux4_tb is
end mux4_tb;

architecture behavior of mux4_tb is
	component mux4
	port(
		s :		in	std_logic_vector(1 downto 0);
		ln0 :	in	std_logic;
		ln1 :	in	std_logic;
		ln2 :	in	std_logic;
		ln3 :	in	std_logic;
		z :		out	std_logic
	);
	end component;

	signal s :		std_logic_vector(1 downto 0);
	signal ln0 :	std_logic;
	signal ln1 :	std_logic;
	signal ln2 :	std_logic;
	signal ln3 :	std_logic;
	signal z :		std_logic;
begin
	uut: mux4 port map (
		s => s,
		ln0 => ln0,
		ln1 => ln1,
		ln2 => ln2,
		ln3 => ln3,
		z => z
	);

	sim_proc: process
	begin
		ln0 <= '1';
		ln1 <= '0';
		ln2 <= '0';
		ln3 <= '1';

		s <= "00";
		wait for 5 ns;

		s <= "01";
		wait for 5 ns;

		s <= "10";
		wait for 5 ns;

		wait;
	end process;
end;
