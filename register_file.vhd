library ieee;
use ieee.std_logic_1164.all;

entity register_file is
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
end register_file;

architecture behavior of register_file is
	component decoder_3to8
		port(
			a :	in	std_logic_vector(2 downto 0);
			q :	out	std_logic_vector(0 to 7)
		);
	end component;

	component mux8_16bit
		port(
			s :		in	std_logic_vector(2 downto 0);
			ln0 :	in	std_logic_vector(15 downto 0);
			ln1 :	in	std_logic_vector(15 downto 0);
			ln2 :	in	std_logic_vector(15 downto 0);
			ln3 :	in	std_logic_vector(15 downto 0);
			ln4 :	in	std_logic_vector(15 downto 0);
			ln5 :	in	std_logic_vector(15 downto 0);
			ln6 :	in	std_logic_vector(15 downto 0);
			ln7 :	in	std_logic_vector(15 downto 0);
			z :		out	std_logic_vector(15 downto 0)
		);
	end component;

	component mux2_16bit
		port(
			s :		in	std_logic;
			ln0 :	in	std_logic_vector(15 downto 0);
			ln1 :	in	std_logic_vector(15 downto 0);
			z :		out	std_logic_vector(15 downto 0)
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

	signal dec_load_reg : std_logic_vector(0 to 7);
	signal load_data, reg_src_data : std_logic_vector(15 downto 0);
	signal r0_q, r1_q, r2_q, r3_q, r4_q, r5_q, r6_q, r7_q : std_logic_vector(15 downto 0);
begin
	reg0: reg16 port map (
		load => dec_load_reg(0),
		clock => clock,
		data => load_data,
		q => r0_q
	);
	reg1: reg16 port map (
		load => dec_load_reg(1),
		clock => clock,
		data => load_data,
		q => r1_q
	);
	reg2: reg16 port map (
		load => dec_load_reg(2),
		clock => clock,
		data => load_data,
		q => r2_q
	);
	reg3: reg16 port map (
		load => dec_load_reg(3),
		clock => clock,
		data => load_data,
		q => r3_q
	);
	reg4: reg16 port map (
		load => dec_load_reg(4),
		clock => clock,
		data => load_data,
		q => r4_q
	);
	reg5: reg16 port map (
		load => dec_load_reg(5),
		clock => clock,
		data => load_data,
		q => r5_q
	);
	reg6: reg16 port map (
		load => dec_load_reg(6),
		clock => clock,
		data => load_data,
		q => r6_q
	);
	reg7: reg16 port map (
		load => dec_load_reg(7),
		clock => clock,
		data => load_data,
		q => r7_q
	);

	dreg_decoder: decoder_3to8 port map (
		a => dst_reg,
		q => dec_load_reg
	);

	dsrc_mux: mux2_16bit port map (
		s => data_src,
		ln0 => data,
		ln1 => reg_src_data,
		z => load_data
	);

	reg_src_mux: mux8_16bit port map (
		s => reg_src,
		ln0 => r0_q,
		ln1 => r1_q,
		ln2 => r2_q,
		ln3 => r3_q,
		ln4 => r4_q,
		ln5 => r5_q,
		ln6 => r6_q,
		ln7 => r7_q,
		z => reg_src_data
	);

	r0 <= r0_q;
	r1 <= r1_q;
	r2 <= r2_q;
	r3 <= r3_q;
	r4 <= r4_q;
	r5 <= r5_q;
	r6 <= r6_q;
	r7 <= r7_q;
end;
