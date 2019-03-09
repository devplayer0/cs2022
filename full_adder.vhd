library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
	port(
		x, y, c_in :	in std_logic;
		s, c_out :		out std_logic
	);
end full_adder;

architecture behavior of full_adder is
	signal hs, hs_c, c_in_s_c : std_logic;
begin
	hs <= x xor y after 1 ns;
	hs_c <= x and y after 1 ns;
	s <= hs xor c_in after 1 ns;
	c_in_s_c <= c_in and hs after 1 ns;
	c_out <= hs_c or c_in_s_c after 1 ns;
end behavior;
