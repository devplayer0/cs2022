library ieee;
use ieee.std_logic_1164.all;

entity mux2_16bit_tb is
end mux2_16bit_tb;

architecture behavior of mux2_16bit_tb is
	component mux2_16bit
	port(
		s :		in	std_logic;
		ln0 :	in	std_logic_vector(15 downto 0);
		ln1 :	in	std_logic_vector(15 downto 0);
		z :		out	std_logic_vector(15 downto 0)
	);
	end component;

	signal s :		std_logic;
	signal ln0 :	std_logic_vector(15 downto 0);
	signal ln1 :	std_logic_vector(15 downto 0);
	signal z :		std_logic_vector(15 downto 0);
begin
	uut: mux2_16bit port map (
		s => s,
		ln0 => ln0,
		ln1 => ln1,
		z => z
	);

	sim_proc: process
	begin
		ln0 <= x"dead";
		ln1 <= x"beef";

		s <= '1';
		wait for 10 ns;

		s <= '0';
		wait for 10 ns;

		wait;
	end process;
end;
