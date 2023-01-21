LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY main_tb IS
END main_tb;
 
ARCHITECTURE behavior OF main_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         i_a : IN  std_logic_vector(1 downto 0);
         i_b : IN  std_logic_vector(1 downto 0);
         i_op : IN  std_logic_vector(1 downto 0);
         o_c : INOUT  std_logic_vector(3 downto 0);
         seven_seg : OUT  std_logic_vector(6 downto 0);
         main_clock : IN  std_logic;
         main_reset : IN  std_logic;
         z : OUT  std_logic;
         n : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_a : std_logic_vector(1 downto 0) := (others => '0');
   signal i_b : std_logic_vector(1 downto 0) := (others => '0');
   signal i_op : std_logic_vector(1 downto 0) := (others => '0');
   signal main_clock : std_logic := '0';
   signal main_reset : std_logic := '0';

	--BiDirs
   signal o_c : std_logic_vector(3 downto 0);

 	--Outputs
   signal seven_seg : std_logic_vector(6 downto 0);
   signal z : std_logic;
   signal n : std_logic;

   -- Clock period definitions
   constant main_clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          i_a => i_a,
          i_b => i_b,
          i_op => i_op,
          o_c => o_c,
          seven_seg => seven_seg,
          main_clock => main_clock,
          main_reset => main_reset,
          z => z,
          n => n
        );

   -- Clock process definitions
   main_clock_process :process
   begin
		main_clock <= '0';
		wait for main_clock_period/2;
		main_clock <= '1';
		wait for main_clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for main_clock_period*10;

      -- insert stimulus here 
		i_a <= "10";
		i_b <= "11";
		i_op <= "00";
		wait for 50 ns;
		i_a <= "11";
		i_b <= "01";
		i_op <= "01";
		wait for 50 ns;
		i_a <= "11";
		i_b <= "11";
		i_op <= "10";
		wait for 50 ns;
		i_a <= "11";
		i_b <= "11";
		i_op <= "11";
		wait for 50 ns;
		
      wait;
   end process;

END;
