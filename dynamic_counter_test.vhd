library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
 
entity dynamic_counter_test is
end dynamic_counter_test;

architecture Behavioral of dynamic_counter_test is
	constant N: integer := 3;
	signal clock: std_logic;
	signal reset: std_logic;
	signal q: unsigned (N*4-1 downto 0);
	signal carry: std_logic;
	signal clock_run: boolean := true;
	constant clock_period: time := 10 ns;
	constant WIDTH: integer := N*4;
begin
	uut: entity work.dynamic_counter port map (
		clock => clock,
		reset => reset,
		q => q,
		carry => carry);
	
	clock_process: process
	begin
		if clock_run then
			clock <= '0';
			wait for clock_period/2;
			clock <= '1';
			wait for clock_period/2;
		else
			wait;
		end if;
	end process;
	
	stim_process: process
	begin
		-- Err1 - testing for outputs when reset = 1
		reset <= '1';
		wait until falling_edge(clock);
		assert q = to_unsigned (0, WIDTH) report "Err1 Output is not zero when reset=1";
		assert carry = '0' report "Err1 Carry is not zero when reset=1";
		
		-- Err2 - testing for initial values after reset = 0
		reset <= '0';
		assert q = to_unsigned (0, WIDTH) report "Err2 output is not zero after reset=0";
		assert carry = '0' report "Err2 carry is not zero after reset=0";
		
		-- Err3 - testing for counting up 0 to 999
		for i in 0 to 10**N-1 loop
			for j in 0 to N-1 loop
				
			end loop;
		end loop;
		-- Err4 - testing for carry signal after q overflow		
		-- Err5 - testing for carry signal duration
		-- Err6 - testing for values after reset signal
		
		clock_run <= false;
		wait;
	end process;
end Behavioral;