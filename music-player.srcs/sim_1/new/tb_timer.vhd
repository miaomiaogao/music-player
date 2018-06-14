library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_timer is
end tb_timer;
 
ARCHITECTURE behavior OF tb_timer IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT timer
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         clk2_i : IN  std_logic;
         clk3_i : IN  std_logic;
         start_i : IN  std_logic;
         an_o : OUT  std_logic_vector(1 downto 0);
         seg_o : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal clk2_i : std_logic := '0';
   signal clk3_i : std_logic := '0';
   signal start_i : std_logic := '0';

 	--Outputs
   signal an_o : std_logic_vector(1 downto 0);
   signal seg_o : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;         --100MHz
   constant clk2_i_period : time := 20 ms;      --50Hz
   constant clk3_i_period : time := 1000 ms;    --1Hz

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: timer PORT MAP (
          clk => clk,
          rst => rst,
          clk2_i => clk2_i,
          clk3_i => clk3_i,
          start_i => start_i,
          an_o => an_o,
          seg_o => seg_o
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   clk2_i_process :process
   begin
		clk2_i <= '0';
		wait for clk2_i_period/2;
		clk2_i <= '1';
		wait for clk2_i_period/2;
   end process;
 
   clk3_i_process :process
   begin
		clk3_i <= '0';
		wait for clk3_i_period/2;
		clk3_i <= '1';
		wait for clk3_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst <= '1';
      start_i <= '0';
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
      rst <= '0';
      wait for 100 ns;
      start_i <= '1';
      wait for 10 us;
      start_i <= '0';



      wait;
   end process;

end behavior;
