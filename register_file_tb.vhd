library ieee;
use ieee.std_logic_1164.all;

entity register_file_tb is
end register_file_tb;

architecture behavior of register_file_tb is
	component register_file
	port(
		reset, load, clock :	in	std_logic;
		dst_reg:				in	std_logic_vector(3 downto 0);
		data :					in	std_logic_vector(15 downto 0);
		a_select :				in	std_logic_vector(3 downto 0);
		b_select :				in	std_logic_vector(3 downto 0);
		a : 					out	std_logic_vector(15 downto 0);
		b : 					out	std_logic_vector(15 downto 0)
	);
	end component;

	signal reset, load, clock :		std_logic := '0';
	signal dst_reg:					std_logic_vector(3 downto 0);
	signal data :					std_logic_vector(15 downto 0);
	signal a_select:				std_logic_vector(3 downto 0);
	signal b_select:				std_logic_vector(3 downto 0);
	signal a :						std_logic_vector(15 downto 0);
	signal b :						std_logic_vector(15 downto 0);
begin
	uut: register_file port map (
		dst_reg => dst_reg,
		reset => reset,
		clock => clock,
		data => data,
		load => load,
		a_select => a_select,
		b_select => b_select,
		a => a,
		b => b
	);

	clock_proc: process
	begin
		wait for 10 ns;
		clock <= not clock;
	end process;
	sim_proc: process
	begin
		reset <= '1';
		wait for 2 ns;
		reset <= '0';
		wait for 2 ns;

		dst_reg <= "0010";
		data <= x"dead";
		load <= '1';
		a_select <= "0010";
		wait for 20 ns;

		data <= x"0000";
		dst_reg <= "0110";
		load <= '0';
		a_select <= "0110";
		wait for 20 ns;

		dst_reg <= "0111";
		data <= x"beef";
		load <= '1';
		b_select <= "0111";
		wait for 20 ns;

		dst_reg <= "1000";
		data <= x"f00d";
		load <= '1';
		b_select <= "1000";
		wait for 20 ns;

		wait for 20 ns;
		std.env.stop;
		wait;
	end process;
end;
