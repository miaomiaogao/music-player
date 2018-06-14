

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package pack is
     --MUSIC INFORMATION --梁祝 化蝶
    constant LEN_M : integer := 138;
    type music_type is array(0 to LEN_M) of std_logic_vector(15 downto 0);
    constant MUSIC_SEQ : music_type := (
    x"0470", x"0470", x"0470", x"0470", x"03bb", x"03bb", x"03bb", x"0353", x"02cc", x"02cc", x"02cc", x"027e", x"0353", 
    x"02cc", x"03bb", x"03bb", x"01de", x"01de", x"01de", x"0166", x"01aa", x"01de", x"0238", x"01de", x"027e", x"027e", 
    x"027e", x"027e", x"027e", x"027e", x"027e", x"027e", x"027e", x"027e", x"027e", x"0238", x"02f6", x"02f6", x"0353", 
    x"0353", x"03bb", x"03bb", x"03bb", x"0353", x"02cc", x"02cc", x"027e", x"027e", x"0470", x"0470", x"02cc", x"02cc", 
    x"0353", x"03bb", x"0353", x"02cc", x"03bb", x"03bb", x"03bb", x"03bb", x"03bb", x"03bb", x"03bb", x"03bb", x"0238", 
    x"0238", x"0238", x"01de", x"02f6", x"02f6", x"027e", x"027e", x"0353", x"02cc", x"03bb", x"03bb", x"03bb", x"03bb", 
    x"03bb", x"03bb", x"0470", x"03bb", x"0470", x"0470", x"03bb", x"0353", x"02f6", x"027e", x"0353", x"0353", x"0353", 
    x"0353", x"0353", x"0353", x"03bb", x"0353", x"02cc", x"02cc", x"02cc", x"027e", x"01de", x"01de", x"01de", x"0238", 
    x"027e", x"027e", x"0238", x"027e", x"02cc", x"02cc", x"0353", x"03bb", x"0470", x"0470", x"0470", x"0470", x"02cc", 
    x"02cc", x"02cc", x"02cc", x"0353", x"02cc", x"0353", x"03bb", x"0470", x"03bb", x"0353", x"02cc", x"03bb", x"03bb", 
    x"03bb", x"03bb", x"03bb", x"03bb", x"03bb", x"03bb", x"0000", x"0000", x"0000");
    --  Compoents declaration
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
   
    COMPONENT timer
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         clk2_i : IN  std_logic;
         clk3_i : IN  std_logic;
         start_i : IN  std_logic;
         an_o : OUT  std_logic_vector(1 downto 0);
         seg_o : OUT  std_logic_vector(6 downto 0));
    END COMPONENT;

    COMPONENT leds
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         snd_div_i : IN  std_logic_vector(15 downto 0);
         leds_o : OUT  std_logic_vector(10 downto 0)
        );
    END COMPONENT;

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
    
    COMPONENT clk_syn port
    (   clk_in1 : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        clk_out1 : OUT STD_LOGIC;
        locked : OUT STD_LOGIC);
     END COMPONENT;
     
     COMPONENT debounce IS
         GENERIC(CNT_NUM: integer := 100);       
         PORT(
              clk : IN  std_logic;
              rst : IN  std_logic;
              key_i : IN  std_logic;
              key_o : OUT  std_logic
             );
    END COMPONENT;
     
     
end pack;

 
    
package body pack is



end pack;
