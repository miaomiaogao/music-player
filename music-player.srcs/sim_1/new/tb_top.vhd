
  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  use work.pack.all;
  
  ENTITY tb_top IS
  END tb_top;

  ARCHITECTURE behavior OF tb_top IS 

  -- Component Declaration
          COMPONENT top
          PORT(
                 clk                  : in  STD_LOGIC;
                 start_btnu_i         : in  STD_LOGIC;
                 stop_btnd_i          : in  STD_LOGIC;
                 tempo_sw_i           : in  STD_LOGIC_VECTOR (1 downto 0);
                 an_o                 : out STD_LOGIC_VECTOR (3 downto 0);
                 seg_o                : out STD_LOGIC_VECTOR (6 downto 0);
                 led_o                : out STD_LOGIC_VECTOR (10 downto 0);
                 buzzer_o             : out STD_LOGIC);
          END COMPONENT;

          signal       clk                  : STD_LOGIC := '0';
          signal       start_btnu_i         : STD_LOGIC := '0';
          signal       stop_btnd_i          : STD_LOGIC := '0';
          signal       tempo_sw_i           : STD_LOGIC_VECTOR (1 downto 0) := "10";
          signal        an_o                : STD_LOGIC_VECTOR (3 downto 0);
          signal        seg_o               : STD_LOGIC_VECTOR (6 downto 0);
          signal        led_o               : STD_LOGIC_VECTOR (10 downto 0);
          signal        buzzer_o            : STD_LOGIC;
          
           
           
             -- Clock period definitions
          constant clk_period : time := 10 ns;

  BEGIN

  -- Component Instantiation
          uut: top PORT MAP(
                 clk          => clk,
                 start_btnu_i => start_btnu_i,
                 stop_btnd_i  => stop_btnd_i,
                 tempo_sw_i   => tempo_sw_i,
                 an_o         => an_o,
                 seg_o        => seg_o,
                 led_o        => led_o,
                 buzzer_o     => buzzer_o    
          );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
   
  --  Test Bench Statements
     tb : PROCESS
     BEGIN

        wait for 100 ns; -- wait until global set/reset completes

        -- Add user defined stimulus here
        
        start_btnu_i <= '0';
        stop_btnd_i <= '0';
        tempo_sw_i <= "10";
           
        start_btnu_i <= '1';
        wait for 8 ms;    
        start_btnu_i <= '0';
        wait for 100 ms;
        
        
        
        
        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;