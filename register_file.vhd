library ieee;
use ieee.std_logic_1164.all;

entity register_file is
	port(
		dst_reg:	in	std_logic_vector(2 downto 0);
		clock :		in	std_logic;
		data :		in	std_logic_vector(15 downto 0);
		load :		in	std_logic;
		a_select :	in	std_logic_vector(2 downto 0) := "000";
		b_select :	in	std_logic_vector(2 downto 0) := "000";
		a : 		out	std_logic_vector(15 downto 0);
		b : 		out	std_logic_vector(15 downto 0)
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

	component reg16
		port(
			load :	in	std_logic;
			clock :	in	std_logic;
			data :	in	std_logic_vector(15 downto 0);
			q :		out	std_logic_vector(15 downto 0)
		);
	end component;

	signal dec_load_reg : std_logic_vector(0 to 7);
	signal l_r0, l_r1, l_r2, l_r3, l_r4, l_r5, l_r6, l_r7 : std_logic;
	signal r0_q, r1_q, r2_q, r3_q, r4_q, r5_q, r6_q, r7_q : std_logic_vector(15 downto 0);
begin
	dreg_decoder: decoder_3to8 port map (
		a => dst_reg,
		q => dec_load_reg
	);

	l_r0 <= load and dec_load_reg(0);
	l_r1 <= load and dec_load_reg(1);
	l_r2 <= load and dec_load_reg(2);
	l_r3 <= load and dec_load_reg(3);
	l_r4 <= load and dec_load_reg(4);
	l_r5 <= load and dec_load_reg(5);
	l_r6 <= load and dec_load_reg(6);
	l_r7 <= load and dec_load_reg(7);

	reg0: reg16 port map (
		load => l_r0,
		clock => clock,
		data => data,
		q => r0_q
	);
	reg1: reg16 port map (
		load => l_r1,
		clock => clock,
		data => data,
		q => r1_q
	);
	reg2: reg16 port map (
		load => l_r2,
		clock => clock,
		data => data,
		q => r2_q
	);
	reg3: reg16 port map (
		load => l_r3,
		clock => clock,
		data => data,
		q => r3_q
	);
	reg4: reg16 port map (
		load => l_r4,
		clock => clock,
		data => data,
		q => r4_q
	);
	reg5: reg16 port map (
		load => l_r5,
		clock => clock,
		data => data,
		q => r5_q
	);
	reg6: reg16 port map (
		load => l_r6,
		clock => clock,
		data => data,
		q => r6_q
	);
	reg7: reg16 port map (
		load => l_r7,
		clock => clock,
		data => data,
		q => r7_q
	);

	ra_mux: mux8_16bit port map (
		s => a_select,
		ln0 => r0_q,
		ln1 => r1_q,
		ln2 => r2_q,
		ln3 => r3_q,
		ln4 => r4_q,
		ln5 => r5_q,
		ln6 => r6_q,
		ln7 => r7_q,
		z => a
	);
	rb_mux: mux8_16bit port map (
		s => b_select,
		ln0 => r0_q,
		ln1 => r1_q,
		ln2 => r2_q,
		ln3 => r3_q,
		ln4 => r4_q,
		ln5 => r5_q,
		ln6 => r6_q,
		ln7 => r7_q,
		z => b
	);
end;
