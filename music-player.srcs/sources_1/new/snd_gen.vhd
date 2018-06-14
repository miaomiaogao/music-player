

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.pack.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity snd_gen is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start_i : in STD_LOGIC;
           clk4_i : in STD_LOGIC;		--5/2.5/1.25Hz
           clk1_i : in STD_LOGIC;		--1MHz
           snd_div_o : out STD_LOGIC_VECTOR(15 downto 0);
           buzzer_o : out STD_LOGIC);
end snd_gen;

architecture Behavioral of snd_gen is
    signal clk1_reg1, clk1_reg          : std_logic;
    signal clk4_reg1, clk4_reg          : std_logic;
    signal start_reg1, start_reg        : std_logic;
    signal enable                       : std_logic;
    signal soundcnt                     : std_logic_vector(15 downto 0);
    signal cnt                          : std_logic_vector(7 downto 0);
    signal snd_div_reg                  : std_logic_vector(15 downto 0);
    signal buzzer_reg                   : std_logic;

begin

process(clk,rst)
begin
    if rst = '1' then
        clk1_reg1  <= '0';  clk1_reg   <= '0';
        start_reg <= '0'; start_reg1 <= '0'; enable <= '0';
    elsif rising_edge(clk) then
        clk1_reg1 <= clk1_i;
        clk1_reg  <= clk1_reg1;
        start_reg1 <= start_i;
        start_reg <= start_reg1;
        if start_reg1 = '1' and start_reg = '0' then
            enable <= '0';
        end if;
        if start_reg1 = '0' and start_reg = '1' then
            enable <= '1';
        end if;
    end if;
end process;

process(clk1_reg,rst)
begin
    if rst = '1' then
        clk4_reg1  <= '0';  clk4_reg   <= '0'; 
        cnt <= (others => '0');  soundcnt   <= (others => '0');
        buzzer_reg <= '0'; snd_div_reg <= (others => '0');
    elsif rising_edge(clk1_reg) then
        clk4_reg1 <= clk4_i;
        clk4_reg  <= clk4_reg1;
        if enable = '1' then
            if (clk4_reg1 = '1' and clk4_reg = '0') then
                cnt <= cnt + 1;
                soundcnt <= (others => '0');
                if cnt = LEN_M then
                    cnt <= (others => '0');
                end if;
            end if;
            snd_div_reg <= MUSIC_SEQ(conv_integer(cnt));
            soundcnt <= soundcnt + 1;
            if soundcnt = snd_div_reg then
                soundcnt <= (others => '0');
                buzzer_reg <= not buzzer_reg;
            end if;
        else
            soundcnt <= (others => '0');
            cnt <= (others => '0');
        end if;
    end if;
end process;
buzzer_o <= buzzer_reg;
snd_div_o <= snd_div_reg;

end Behavioral;
