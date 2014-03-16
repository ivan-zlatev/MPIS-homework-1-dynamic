library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity dynamic_counter is
	generic (N : integer := 3);
	port(
		clock : in std_logic;
		reset : in std_logic;
		q : out unsigned(4*N-1 downto 0);
		carry : out std_logic);
end dynamic_counter;

architecture Behavioral of dynamic_counter is
signal temp : unsigned (4*N-1 downto 0);
signal c : std_logic_vector(N-1 downto 0);
begin
F : for i in 1 to N generate
	begin
	F0 : if ( i = 1 ) generate
		begin U0 : entity work.bcd_counter port map    
			(clock => clock,
			reset => reset,
         q => temp(4*i-1 downto 4*i-4),
			carry => c(i-1));
	end generate F0;
	F1 : if ( i > 1 and i /= N ) generate
		begin U1 : entity work.bcd_counter port map   
			(clock => c(i-2),
			reset => reset,
         q => temp(4*i-1 downto 4*i-4),
			carry => c(i-1));
	end generate F1;
	F2 : if ( i = N ) generate
		begin U2 : entity work.bcd_counter port map     
			(clock => c(i-2),
			reset => reset,
			q => temp(4*i-1 downto 4*i-4),
			carry => c(i-1));
	end generate F2;
end generate F;
q <= temp;
carry <= c(2);
end Behavioral;
