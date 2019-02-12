library ieee;
use ieee.std_logic_1164.all;

entity register_file_tb is
end register_file_tb;

architecture behavior of register_file_tb is
	component register_file
	port(
		reg_src:	in	std_logic_vector(2 downto 0);
		dst_reg:	in	std_logic_vector(2 downto 0);
		clock :		in	std_logic;
		data_src:	in std_logic;
		data :		in	std_logic_vector(15 downto 0);
		r0 :		out	std_logic_vector(15 downto 0);
		r1 :		out	std_logic_vector(15 downto 0);
		r2 :		out	std_logic_vector(15 downto 0);
		r3 :		out	std_logic_vector(15 downto 0);
		r4 :		out	std_logic_vector(15 downto 0);
		r5 :		out	std_logic_vector(15 downto 0);
		r6 :		out	std_logic_vector(15 downto 0);
		r7 :		out	std_logic_vector(15 downto 0)
	);
	end component;

	signal reg_src:		std_logic_vector(2 downto 0) := "000";
	signal dst_reg:		std_logic_vector(2 downto 0);
	signal clock :		std_logic := '0';
	signal data_src:	std_logic;
	signal data :		std_logic_vector(15 downto 0);
	signal r0 :			std_logic_vector(15 downto 0);
	signal r1 :			std_logic_vector(15 downto 0);
	signal r2 :			std_logic_vector(15 downto 0);
	signal r3 :			std_logic_vector(15 downto 0);
	signal r4 :			std_logic_vector(15 downto 0);
	signal r5 :			std_logic_vector(15 downto 0);
	signal r6 :			std_logic_vector(15 downto 0);
	signal r7 :			std_logic_vector(15 downto 0);
begin
	uut: register_file port map (
		reg_src => reg_src,
		dst_reg => dst_reg,
		clock => clock,
		data_src => data_src,
		data => data,
		r0 => r0,
		r1 => r1,
		r2 => r2,
		r3 => r3,
		r4 => r4,
		r5 => r5,
		r6 => r6,
		r7 => r7
	);

	clock_proc: process
	begin
		wait for 10 ns;
		clock <= not clock;
	end process;
	sim_proc: process
	begin
		data_src <= '0';
		dst_reg <= "010";
		data <= x"dead";
		wait for 20 ns;

		data <= x"0000";
		data_src <= '1';
		dst_reg <= "110";
		reg_src <= "010";
		wait for 20 ns;

		wait for 20 ns;
		std.env.stop;
		wait;
	end process;
end;
