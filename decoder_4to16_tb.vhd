library ieee;
use ieee.std_logic_1164.all;

entity decoder_4to16_tb is
end decoder_4to16_tb;

architecture behavior of decoder_4to16_tb is
	component decoder_4to16
	port(
		a : in 	std_logic_vector(3 downto 0);
		q : out	std_logic_vector(0 to 15)
	);
	end component;

	signal a : std_logic_vector(3 downto 0);
	signal q : std_logic_vector(0 to 15);
begin
	uut: decoder_4to16 port map (
		a => a,
		q => q
	);

	sim_proc: process
	begin
		a <= "0000";
		wait for 10 ns;

		a <= "0100";
		wait for 10 ns;

		a <= "0110";
		wait for 10 ns;

		a <= "1010";
		wait for 10 ns;

		wait;
	end process;
end;
