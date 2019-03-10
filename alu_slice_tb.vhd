library ieee;
use ieee.std_logic_1164.all;

entity alu_slice_tb is
end alu_slice_tb;

architecture behavior of alu_slice_tb is
	component alu_slice
	port(
		s :				in	std_logic_vector(2 downto 0);
		a, b, c_in :	in	std_logic;
		z, c_out :		out	std_logic
	);
	end component;

	signal s :			std_logic_vector(2 downto 0);
	signal a, b, c_in :	std_logic;
	signal z, c_out :	std_logic;
begin
	uut: alu_slice port map (
		s => s,
		a => a,
		b => b,
		c_in => c_in,
		z => z,
		c_out => c_out
	);

	sim_proc: process
	begin
		a <= '1';
		b <= '1';
		c_in <= '0';

		s <= "000";
		wait for 5 ns;

		s <= "001";
		wait for 5 ns;

		s <= "010";
		wait for 5 ns;

		b <= '0';
		s <= "011";
		wait for 5 ns;

		a <= '0';
		wait for 5 ns;

		a <= '1';
		b <= '1';
		s <= "100";
		wait for 5 ns;

		s <= "110";
		wait for 5 ns;

		s <= "111";
		wait for 5 ns;

		wait;
	end process;
end;
