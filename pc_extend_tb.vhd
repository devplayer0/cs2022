library ieee;
use ieee.std_logic_1164.all;

entity pc_extend_tb is
end pc_extend_tb;

architecture behavior of pc_extend_tb is
	component pc_extend
	port(
		offset_6b :	in	std_logic_vector(5 downto 0);
		extended : 	out	std_logic_vector(15 downto 0)
	);
	end component;

	signal offset_6b :	std_logic_vector(5 downto 0);
	signal extended :	std_logic_vector(15 downto 0);
begin
	uut: pc_extend port map (
		offset_6b => offset_6b,
		extended => extended
	);

	sim_proc: process
	begin
		offset_6b <= "001010";
		wait for 5 ns;

		offset_6b <= "000011";
		wait for 5 ns;

		offset_6b <= "101011";
		wait for 5 ns;

		wait;
	end process;
end;
