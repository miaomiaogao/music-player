library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pack.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk                  : in  STD_LOGIC;
           start_btnu_i         : in  STD_LOGIC;
           stop_btnd_i          : in  STD_LOGIC;
           tempo_sw_i           : in  STD_LOGIC_VECTOR (1 downto 0);
           an_o                 : out STD_LOGIC_VECTOR (3 downto 0);
           seg_o                : out STD_LOGIC_VECTOR (6 downto 0);
           led_o                : out STD_LOGIC_VECTOR (10 downto 0);
           buzzer_o             : out STD_LOGIC);
end top;

architecture Behavioral of top is
    signal sys_clk,sys_rst             : std_logic;     -- 100 MHz
    signal sys_rst1, locked            : std_logic;
    signal clk1_reg                    : std_logic;     -- 1 MHz
    signal clk2_reg                    : std_logic;     -- 50 Hz
    signal clk3_reg                    : std_logic;     -- 1 Hz
    signal clk4_reg                    : std_logic;     -- 5/2.5/1.25 Hz

    signal snd_div_reg                 : std_logic_vector(15 downto 0);            
    signal an_reg                      : std_logic_vector(1 downto 0);            
    signal seg_reg                     : std_logic_vector(6 downto 0);      
    
    signal start_reg_i, stop_reg_i     : std_logic;
    
begin
an_o <= "11" & an_reg;
seg_o <= seg_reg;

start_ctrl: debounce 
    GENERIC MAP(CNT_NUM => 100)
    PORT MAP (clk => sys_clk,rst => sys_rst,key_i => start_btnu_i,key_o => start_reg_i);
stop_ctrl: debounce 
    GENERIC MAP(CNT_NUM => 100) 
    PORT MAP (clk => sys_clk, rst => sys_rst,key_i => stop_btnd_i,key_o => stop_reg_i);

clk_syn_ctrl: clk_syn port map(clk_in1 => clk, reset => '0', clk_out1 => sys_clk, locked => locked);

process(sys_clk)
begin
    sys_rst1 <= not locked;
    sys_rst <= sys_rst1;
end process;
                
clk_ctl : clk_div 
    port map(   clk => sys_clk, rst => sys_rst, tempo_i => tempo_sw_i,start_i => start_reg_i,stop_i => stop_reg_i,
                clk1_o => clk1_reg,clk2_o => clk2_reg,clk3_o => clk3_reg,clk4_o => clk4_reg);
                
tmr_ctrl : timer
    port map(   clk => sys_clk,
                rst => sys_rst,
                clk2_i => clk2_reg,
                clk3_i => clk3_reg,
                start_i => start_reg_i,
                an_o => an_reg,
                seg_o => seg_reg);

leds_ctl : leds
    port map(   clk => sys_clk,
                rst => sys_rst,
                snd_div_i => snd_div_reg,
                leds_o => led_o);

snd_ctl : snd_gen
    port map(   clk => sys_clk,
                rst => sys_rst,
                start_i  => start_reg_i,
                clk4_i  => clk4_reg,
                clk1_i  => clk1_reg,
                snd_div_o => snd_div_reg,
                buzzer_o  => buzzer_o);
end Behavioral;
