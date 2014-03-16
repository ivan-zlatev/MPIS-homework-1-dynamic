library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_counter is
	port(
		clock : in std_logic;
		reset : in std_logic;
		q : out unsigned (3 downto 0);
		carry : out std_logic);
end bcd_counter;

architecture Behavioral of bcd_counter is
	signal temp : unsigned (3 downto 0);
	constant INITIAL_STATE : unsigned (3 downto 0) := (others=>'0');
begin
	counting: process( clock, reset )
	begin
		if ( reset = '1' ) then
			temp <= INITIAL_STATE;
			carry <= '0';
		else
			if rising_edge(clock) then
				if ( temp = 9 ) then
					temp <= INITIAL_STATE;
					carry <= '1';
				else
					temp <= temp + 1;
					carry <= '0';
				end if;
			end if;
		end if;
	end process;
	q <= temp;
end Behavioral;

