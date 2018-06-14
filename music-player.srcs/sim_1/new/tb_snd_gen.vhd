--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:21:23 06/10/2018
-- Design Name:   
-- Module Name:   C:/work/freelancer/emp2/test1/tb_snd_gen.vhd
-- Project Name:  test1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: snd_gen
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
 
ENTITY tb_snd_gen IS
END tb_snd_gen;
 
ARCHITECTURE behavior OF tb_snd_gen IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT snd_gen
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         start_i : IN  std_logic;
         clk4_i : IN  std_logic;
         clk1_i : IN  std_logic;
         snd_div_o : OUT STD_LOGIC_VECTOR(15 downto 0);
         buzzer_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal start_i : std_logic := '0';
   signal clk4_i : std_logic := '0';
   signal clk1_i : std_logic := '0';

 	--Outputs
   signal buzzer_o : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;     --100MHz
   constant clk1_period : time := 1000 ns;   --1MHz
   constant clk4_period : time :=  200 ms;   --5Hz

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: snd_gen PORT MAP (
          clk => clk,
          rst => rst,
          start_i => start_i,
          clk4_i => clk4_i,
          clk1_i => clk1_i,
          buzzer_o => buzzer_o
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
   clk_process1 :process
   begin
        clk1_i <= '0';
        wait for clk1_period/2;
        clk1_i <= '1';
        wait for clk1_period/2;
   end process;
   clk_process4 :process
      begin
           clk4_i <= '0';
           wait for clk4_period/2;
           clk4_i <= '1';
           wait for clk4_period/2;
      end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
      rst <= '0';
      wait;
   end process;

END;
