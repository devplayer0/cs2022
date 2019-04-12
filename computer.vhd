library ieee;
use ieee.std_logic_1164.all;

entity computer is
	port(
		reset, clock :	in std_logic
	);
end computer;

architecture behavior of computer is
	component mux2_16bit is
		port(
			s :		in	std_logic;
			ln0 :	in	std_logic_vector(15 downto 0);
			ln1 :	in	std_logic_vector(15 downto 0);
			z :		out	std_logic_vector(15 downto 0)
		);
	end component;

	component memory is
		port(
			address :		in	std_logic_vector(15 downto 0);
			data_in :		in	std_logic_vector(15 downto 0);
			clock, load : 	in	std_logic;
			data_out :		out	std_logic_vector(15 downto 0)
		);
	end component;

	component datapath is
		port(
			clock :					in	std_logic;
			cw :					in	std_logic_vector(19 downto 0);
			const, data_in :		in	std_logic_vector(15 downto 0);
			address_out, data_out :	out	std_logic_vector(15 downto 0);
			v, c, n, z :			out std_logic
		);
	end component;

	component micro_control is
		port(
			reset, clock :			in	std_logic;
			mem_data :				in std_logic_vector(15 downto 0);
			flags :					in std_logic_vector(3 downto 0);
			dp_cw :					out	std_logic_vector(19 downto 0);
			addr_select, mem_load :	out std_logic;
			cur_pc :				out std_logic_vector(15 downto 0)
		);
	end component;

	signal addr_select, mem_load : std_logic;
	signal flags : std_logic_vector(3 downto 0);
	signal zfilled_breg, mem_data, reg_addr, mem_in, pc_addr, mmux_out : std_logic_vector(15 downto 0);
	signal mc_cw : std_logic_vector(19 downto 0);
begin
	dp: datapath port map (
		clock => clock,
		cw => mc_cw,
		const => zfilled_breg,
		data_in => mem_data,
		address_out => reg_addr,
		data_out => mem_in,
		v => flags(1),
		c => flags(0),
		n => flags(3),
		z => flags(2)
	);

	control: micro_control port map (
		reset => reset,
		clock => clock,
		mem_data => mem_data,
		flags => flags,
		dp_cw => mc_cw,
		addr_select => addr_select,
		mem_load => mem_load,
		cur_pc => pc_addr
	);
	zfilled_breg(15 downto 3) <= (others => '0');
	zfilled_breg(2 downto 0) <= mc_cw(10 downto 8);

	mmux: mux2_16bit port map (
		s => addr_select,
		ln0 => reg_addr,
		ln1 => pc_addr,
		z => mmux_out
	);
	mem: memory port map (
		clock => clock,
		address => mmux_out,
		data_in => mem_in,
		load => mem_load,
		data_out => mem_data
	);
end;
