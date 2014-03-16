library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY bcd_counter_test IS
END bcd_counter_test;
 
ARCHITECTURE behavior OF bcd_counter_test IS 

	signal clock : std_logic := '0';
	signal reset : std_logic := '0';
	signal q : unsigned(3 downto 0);
	signal carry : std_logic;
	signal clock_run : boolean := true;
	constant clock_period : time := 10 ns;

BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut: entity work.bcd_counter PORT MAP (
		clock => clock,
		reset => reset,
		q => q,
		carry => carry);

	-- Clock process definitions
	clock_process :process
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

	-- Stimulus process
	stim_proc: process
	begin
		-- Err1 - testing for outputs when reset = 1
		reset <= '1';
		wait until falling_edge(clock);
		assert q = to_unsigned (0,4) report "Err1 Output is not zero when reset=1";
		assert carry = '0' report "Err1 Carry is not zero when reset=1";
		
		-- Err2 - testing for initial values after reset = 0
		reset <= '0';
		assert q = to_unsigned (0,4) report "Err2 output is not zero after reset=0";
		assert carry = '0' report "Err2 carry is not zero after reset=0";
		
		-- Err3 - testing for counting up 0 to 9
		for i in 1 to 9 loop
			wait until falling_edge(clock);
			assert q = to_unsigned (i,4) report "Err3 output is expected to be " & integer'image(i) & ", but is " &integer'image(to_integer(q));
			assert carry = '0' report "Err 3 carry is expected to be '0', but is '1'";
		end loop;
		
		-- Err4 - testing for carry signal after q overflow
		wait until falling_edge(clock);
		assert carry = '1' report "Err4 carry is expected to be '1' but is '0'";
		
		-- Err5 - testing for carry signal duration
		wait until falling_edge(clock);
		assert carry = '0' report "Err5 carry is longer than expected";
		
		-- Err6 - testing for values after reset signal
		wait until falling_edge(clock);
		wait until falling_edge(clock);
		wait until falling_edge(clock);
		reset <= '1';
		wait until falling_edge(clock);
		reset <= '0';
		assert q = to_unsigned(0,4) report "Err6 output is not zero after reset signal";
		assert carry = '0' report "Err6 carry is not zero after reset signal";
		
      clock_run <= false;
		wait;
   end process;
END;
