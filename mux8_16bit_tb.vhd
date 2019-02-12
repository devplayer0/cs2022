library ieee;
use ieee.std_logic_1164.all;

entity mux8_16bit_tb is
end mux8_16bit_tb;

architecture behavior of mux8_16bit_tb is
	component mux8_16bit
	port(
		s :		in	std_logic_vector(2 downto 0);
		ln0 :	in	std_logic_vector(15 downto 0);
		ln1 :	in	std_logic_vector(15 downto 0);
		ln2 :	in	std_logic_vector(15 downto 0);
		ln3 :	in	std_logic_vector(15 downto 0);
		ln4 :	in	std_logic_vector(15 downto 0);
		ln5 :	in	std_logic_vector(15 downto 0);
		ln6 :	in	std_logic_vector(15 downto 0);
		ln7 :	in	std_logic_vector(15 downto 0);
		z :		out	std_logic_vector(15 downto 0)
	);
	end component;

	signal s :		std_logic_vector(2 downto 0);
	signal ln0 :	std_logic_vector(15 downto 0);
	signal ln1 :	std_logic_vector(15 downto 0);
	signal ln2 :	std_logic_vector(15 downto 0);
	signal ln3 :	std_logic_vector(15 downto 0);
	signal ln4 :	std_logic_vector(15 downto 0);
	signal ln5 :	std_logic_vector(15 downto 0);
	signal ln6 :	std_logic_vector(15 downto 0);
	signal ln7 :	std_logic_vector(15 downto 0);
	signal z :		std_logic_vector(15 downto 0);
begin
	uut: mux8_16bit port map (
		s => s,
		ln0 => ln0,
		ln1 => ln1,
		ln2 => ln2,
		ln3 => ln3,
		ln4 => ln4,
		ln5 => ln5,
		ln6 => ln6,
		ln7 => ln7,
		z => z
	);

	sim_proc: process
	begin
		ln0 <= x"dead";
		ln4 <= x"beef";
		ln6 <= x"cafe";

		s <= "000";
		wait for 10 ns;

		s <= "100";
		wait for 10 ns;

		s <= "110";
		wait for 10 ns;

		wait;
	end process;
END;
