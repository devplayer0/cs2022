library ieee;
use ieee.std_logic_1164.all;

entity datapath_tb is
end datapath_tb;

architecture behavior of datapath_tb is
	component datapath
		port(
			clock :					in	std_logic;
			cw :					in	std_logic_vector(16 downto 0);
			const, data_in :		in	std_logic_vector(15 downto 0);
			address_out, data_out :	out	std_logic_vector(15 downto 0);
			v, c, n, z :			out std_logic
		);
	end component;

	signal clock :									std_logic := '0';
	signal v, c, n, z :								std_logic;
	signal const, data_in, address_out, data_out :	std_logic_vector(15 downto 0);
	signal cw :										std_logic_vector(16 downto 0);
begin
	uut: datapath port map (
		clock => clock,
		cw => cw,
		const => const,
		data_in => data_in,
		address_out => address_out,
		data_out => data_out,
		v => v,
		c => c,
		n => n,
		z => z
	);

	clock_proc: process
	begin
		wait for 64 ns;
		clock <= not clock;
	end process;
	sim_proc: process
	begin
		-- r5 <- data in
		data_in <= x"0007";
		cw <= "10100000000000011";
		wait for 128 ns;

		-- r7 <- data in
		data_in <= x"0009";
		cw <= "11100000000000011";
		wait for 128 ns;

		-- data out = r5
		cw <= "00000010100000000";
		wait for 128 ns;

		-- add r1, r5, r7
		cw <= "00110111100001001";
		wait for 128 ns;

		-- xor r5, r0, r0
		cw <= "10100000000110001";
		wait for 128 ns;

		-- data out = r1
		cw <= "00000000100000000";
		wait for 128 ns;

		std.env.stop;
		wait;
	end process;
end;
