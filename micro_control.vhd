library ieee;
use ieee.std_logic_1164.all;

entity micro_control is
	port(
		reset, clock :			in	std_logic;
		mem_data :				in	std_logic_vector(15 downto 0);
		flags :					in	std_logic_vector(3 downto 0);
		dp_cw :					out	std_logic_vector(19 downto 0);
		addr_select, mem_load :	out	std_logic;
		cur_pc :				out	std_logic_vector(15 downto 0)
	);
end micro_control;

architecture behavior of micro_control is
	component mux2_8bit is
		port(
			s :		in	std_logic;
			ln0 :	in	std_logic_vector(7 downto 0);
			ln1 :	in	std_logic_vector(7 downto 0);
			z :		out	std_logic_vector(7 downto 0)
		);
	end component;

	component reg16
		port(
			load :	in	std_logic;
			clock :	in	std_logic;
			data :	in	std_logic_vector(15 downto 0);
			q :		out	std_logic_vector(15 downto 0)
		);
	end component;

	component pc_extend is
		port(
			offset_6b :	in	std_logic_vector(5 downto 0);
			extended : 	out	std_logic_vector(15 downto 0)
		);
	end component;

	component pc is
		port(
			clock, reset, inc, load :	in	std_logic;
			offset :					in	std_logic_vector(15 downto 0);
			value : 					out	std_logic_vector(15 downto 0) := x"0000"
		);
	end component;

	component flag_mux is
		port(
			flags_in :	in	std_logic_vector(3 downto 0) := x"0";
			s :			in	std_logic_vector(2 downto 0) := "000";
			flag :		out	std_logic
		);
	end component;

	component car is
		port(
			reset, clock, load :	in	std_logic;
			to_load :				in	std_logic_vector(7 downto 0);
			address :				out	std_logic_vector(7 downto 0)
		);
	end component;

	component control_memory is
		port(
			address :	in	std_logic_vector(7 downto 0);
			cw :		out	std_logic_vector(27 downto 0)
		);
	end component;

	signal c_flag : std_logic;
	signal pc_offset : std_logic_vector(5 downto 0);
	signal ir_opcode_ext, car_mux_val, c_addr : std_logic_vector(7 downto 0);
	signal ir_val, extended_pc : std_logic_vector(15 downto 0);
	signal mem_cw : std_logic_vector(27 downto 0);
begin
	ir: reg16 port map (
		load => mem_cw(15),
		clock => clock,
		data => mem_data,
		q => ir_val
	);
	ir_opcode_ext(7) <= '0';
	ir_opcode_ext(6 downto 0) <= ir_val(15 downto 9);
	dp_cw(18 downto 16) <= ir_val(8 downto 6); -- dst reg
	dp_cw(14 downto 12) <= ir_val(5 downto 3); -- reg a
	dp_cw(10 downto 8) <= ir_val(2 downto 0); -- reg b

	fmux: flag_mux port map (
		flags_in => flags,
		s => mem_cw(19 downto 17),
		flag => c_flag
	);

	pc_offset(5 downto 3) <= ir_val(8 downto 6);
	pc_offset(2 downto 0) <= ir_val(2 downto 0);
	pc_extender: pc_extend port map (
		offset_6b => pc_offset,
		extended => extended_pc
	);
	prog_counter: pc port map (
		clock => clock,
		reset => reset,
		inc => mem_cw(14),
		load => mem_cw(13),
		offset => extended_pc,
		value => cur_pc
	);

	car_mux: mux2_8bit port map (
		s => mem_cw(16),
		ln0 => mem_cw(27 downto 20),
		ln1 => ir_opcode_ext,
		z => car_mux_val
	);
	c_ar: car port map (
		reset => reset,
		clock => clock,
		load => c_flag,
		to_load => car_mux_val,
		address => c_addr
	);
	c_mem: control_memory port map (
		address => c_addr,
		cw => mem_cw
	);

	dp_cw(19) <= mem_cw(12); -- temp reg
	dp_cw(15) <= mem_cw(11);
	dp_cw(11) <= mem_cw(10);
	dp_cw(7) <= mem_cw(9); -- b data from register or constant
	dp_cw(6 downto 2) <= mem_cw(8 downto 4); -- function select
	dp_cw(1) <= mem_cw(3); -- store arith result or from mem? (md)
	dp_cw(0) <= mem_cw(2); -- reg load

	addr_select <= mem_cw(1);
	mem_load <= mem_cw(0);
end;
