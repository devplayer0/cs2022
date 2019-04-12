library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
	port(
		address :	in	std_logic_vector(15 downto 0);
		data_in :	in	std_logic_vector(15 downto 0);
		load : 		in	std_logic;
		data_out :	out	std_logic_vector(15 downto 0)
	);
end memory;

architecture behavioral of memory is
	type mem_t is array(0 to 511) of std_logic_vector(15 downto 0);
begin
	mem_proc: process(address, data_in, load) is
		variable mem : mem_t := (
			1 => x"dead",
			2 => x"beef",
			others => x"0000"
		);
	begin
		if load = '1' then
			mem(to_integer(unsigned(address(8 downto 0)))) := data_in;
		end if;
		data_out <= mem(to_integer(unsigned(address(8 downto 0))));
	end process;

end behavioral;
