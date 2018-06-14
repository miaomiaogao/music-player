library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_leds IS
END tb_leds;
 
ARCHITECTURE behavior OF tb_leds IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT leds
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         snd_div_i : IN  std_logic_vector(15 downto 0);
         leds_o : OUT  std_logic_vector(10 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal snd_div_i : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal leds_o : std_logic_vector(10 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: leds PORT MAP (
          clk => clk,
          rst => rst,
          snd_div_i => snd_div_i,
          leds_o => leds_o
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
      snd_div_i <= (others => '0');
      rst <= '0';
      while(TRUE) loop
          snd_div_i <= snd_div_i + 10;
          if snd_div_i = 15700 then
              snd_div_i <= (others => '0');
          end if;
          wait for 100 ns;
      end loop;
      wait;
   end process;

END;
