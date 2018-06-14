LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_clk_div IS
END tb_clk_div;
 
ARCHITECTURE behavior OF tb_clk_div IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clk_div
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         tempo_i : IN  std_logic_vector(1 downto 0);
         start_i : IN  std_logic;
         stop_i : IN  std_logic;
         clk1_o : OUT  std_logic;
         clk2_o : OUT  std_logic;
         clk3_o : OUT  std_logic;
         clk4_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk               : std_logic := '0';
   signal rst               : std_logic := '1';
   signal tempo_i           : std_logic_vector(1 downto 0) := (others => '0');
   signal start_i           : std_logic := '0';
   signal stop_i            : std_logic := '0';

   --Outputs
   signal clk1_o            : std_logic;
   signal clk2_o            : std_logic;
   signal clk3_o            : std_logic;
   signal clk4_o            : std_logic;

   -- Clock period definitions
   constant clk_period      : time := 10 ns;	--100MHz clock
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: clk_div PORT MAP (
          clk => clk,
          rst => rst,
          tempo_i => tempo_i,
          start_i => start_i,
          stop_i => stop_i,
          clk1_o => clk1_o,
          clk2_o => clk2_o,
          clk3_o => clk3_o,
          clk4_o => clk4_o
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
  
 

   -- Stimulus process
   stim_proc: process
   begin		
   -- hold reset state for 100 ns.
      rst <= '1';
      start_i <= '0';
      stop_i <= '0';
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
      rst <= '0';
      wait for 100 ns;
      start_i <= '1';
      wait for 10 us;
      start_i <= '0';
      
      
      tempo_i <= "00";
      wait for 2000 ms;

      tempo_i <= "11";
      wait for 2 ms;

      tempo_i <= "01";
      wait for 2000 ms;

      tempo_i <= "10";
      wait for 2000 ms;

      tempo_i <= "00";
      wait for 2000 ms;
      wait;
   end process;

END;
