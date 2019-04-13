library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
	port(
		address :		in	std_logic_vector(15 downto 0);
		data_in :		in	std_logic_vector(15 downto 0);
		clock, load : 	in	std_logic;
		data_out :		out	std_logic_vector(15 downto 0)
	);
end memory;

architecture behavioral of memory is
	type mem_t is array(0 to 511) of std_logic_vector(15 downto 0);
begin
	mem_proc: process(clock) is
		variable mem : mem_t := (
			0 =>		x"0203", -- adi r0, r0, #3
			1 =>		x"0242", -- adi r1, r0, #2
			2 =>		x"0000", -- halt

			others =>	x"0000"
		);
	begin
		if rising_edge(clock) and load = '1' then
			mem(to_integer(unsigned(address(8 downto 0)))) := data_in;
		end if;
		data_out <= mem(to_integer(unsigned(address(8 downto 0))));
	end process;
end behavioral;
