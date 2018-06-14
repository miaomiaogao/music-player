--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:03:17 06/13/2018
-- Design Name:   
-- Module Name:   C:/work/freelancer/emp2/test1-ISE/tb_debounce.vhd
-- Project Name:  test1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: debounce
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_debounce IS
END tb_debounce;
 
ARCHITECTURE behavior OF tb_debounce IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT debounce IS
    GENERIC(CNT_NUM: integer := 100);       
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         key_i : IN  std_logic;
         key_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal key_i : std_logic := '0';

 	--Outputs
   signal key_o : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: debounce 
   GENERIC MAP(CNT_NUM => 100)
    PORT MAP (
          clk => clk,
          rst => rst,
          key_i => key_i,
          key_o => key_o
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
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		rst <= '0';
		while(True) loop
            key_i <= '0';
            wait for 1 us;	
            key_i <= '1';
            wait for 1 us;	
            key_i <= '0';
            wait for 1 us;	
            key_i <= '1';
            wait for 10 us;	
            key_i <= '0';
            wait for 10 us;	
            key_i <= '1';
            wait for 100 us;	
            key_i <= '0';
            wait for 1000 us;	
            key_i <= '1';
            wait for 100 ms;	
            key_i <= '0';
            wait for 100 ms;
		end loop;
      wait;
   end process;

END;
