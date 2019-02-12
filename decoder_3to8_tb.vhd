library ieee;
use ieee.std_logic_1164.all;

entity decoder_3to8_tb is
end decoder_3to8_tb;

architecture behavior of decoder_3to8_tb is
	component decoder_3to8
	port(
		a : in 	std_logic_vector(2 downto 0);
		q : out	std_logic_vector(0 to 7)
	);
	end component;

	signal a : std_logic_vector(2 downto 0) := (others => '0');
	signal q : std_logic_vector(0 to 7);
begin
	uut: decoder_3to8 port map (
		a => a,
		q => q
	);

	sim_proc: process
	begin
		a <= "000";
		wait for 10 ns;

		a <= "100";
		wait for 10 ns;

		a <= "110";
		wait for 10 ns;

		wait;
	end process;
END;
