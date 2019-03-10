library ieee;
use ieee.std_logic_1164.all;

entity shifter_tb is
end shifter_tb;

architecture behavior of shifter_tb is
	component shifter
		port(
			s :			in	std_logic_vector(1 downto 0);
			ir, il :	in	std_logic;
			b :			in	std_logic_vector(15 downto 0);
			h :			out	std_logic_vector(15 downto 0)
		);
	end component;

	signal s :		std_logic_vector(1 downto 0);
	signal b, h :	std_logic_vector(15 downto 0);
	signal ir, il :	std_logic;
begin
	uut: shifter port map (
		s => s,
		ir => ir,
		il => il,
		b => b,
		h => h
	);

	sim_proc: process
	begin
		b <= x"0fe0";
		ir <= '0';
		il <= '0';
		s <= "00";
		wait for 4 ns;

		s <= "10";
		wait for 4 ns;

		s <= "01";
		wait for 4 ns;

		wait;
	end process;
end;
