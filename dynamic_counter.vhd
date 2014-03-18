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
Ix : for i in 1 to N generate -- generate first and last instance
	begin
	I0 : if ( i = 1 and i < N ) generate -- generate first instance if N > 1
		begin U0 : entity work.bcd_counter port map    
			(clock => clock,
			reset => reset,
         q => temp(3 downto 0),
			carry => c(0));
	end generate I0;
	IL : if ( i = N and i > 1 ) generate -- generate last instance if N > 1
		begin UL : entity work.bcd_counter port map     
			(clock => c(N-2),
			reset => reset,
			q => temp(4*N-1 downto 4*N-4),
			carry => c(N-1));
	end generate IL;
	instance : if ( i = 1 and i = N ) generate -- generate only one instance if N = 1
		begin U : entity work.bcd_counter port map
			(clock => clock,
			reset => reset,
			q => temp(3 downto 0),
			carry => c(0));
	end generate instance;
end generate Ix;

Iy: for j in 2 to N generate -- generate middle instances if N > 2
	begin
	I : if ( j > 1 and j < N ) generate
		begin
		Ux : entity work.bcd_counter port map   
			(clock => c(j-2),
			reset => reset,
         q => temp(4*j-1 downto 4*j-4),
			carry => c(j-1));
	end generate I;
end generate Iy;

q <= temp;
carry <= c(N-1);
end Behavioral;
