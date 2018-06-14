library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.pack.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_div is
	generic( div1 : integer := 100;
        div2 : integer := 20000;
        div3 : integer := 50);
    Port ( clk        : in   STD_LOGIC;	                  --input 100Mhz
           rst        : in   STD_LOGIC;	                  --input reset '1' active
           tempo_i    : in   STD_LOGIC_VECTOR (1 downto 0);	--input sw to choose tempo
           start_i    : in   STD_LOGIC;
           stop_i     : in   STD_LOGIC;
           clk1_o     : out  STD_LOGIC;                     --output 1MHz when enable
           clk2_o     : out  STD_LOGIC;                     --output 50Hz always
           clk3_o     : out  STD_LOGIC;                     --output 1Hz when enable
           clk4_o     : out  STD_LOGIC);                    --output 5/2.5/1.25Hz when enable according to tempo_i
end clk_div;

architecture Behavioral of clk_div is
signal cnt1,cnt2,cnt3,cnt4      : std_logic_vector(30 downto 0);
--clk temp reg
signal clk1_1M_reg              : std_logic;
signal clk2_50Hz_reg            : std_logic;
signal clk3_1Hz_reg             : std_logic;
signal clk4_sel_reg             : std_logic;
--inputs reg
signal start_reg, start_reg1    : std_logic;
signal stop_reg, stop_reg1      : std_logic;
signal tempo_reg, tempo_reg1    : std_logic_vector(1 downto 0);
signal enable                   : std_logic;
begin


--to generate clk1 clk2 clk3 clk4
process(clk,rst,enable,tempo_reg)
begin
    if rst = '1' then
        cnt1 <= (others => '0'); cnt2 <= (others => '0'); cnt3 <= (others => '0'); cnt4 <= (others => '0');
        clk1_1M_reg <= '0'; clk2_50Hz_reg <= '0'; clk3_1Hz_reg <= '0'; clk4_sel_reg <= '0';
    elsif(rising_edge(clk))then
        cnt1 <= cnt1 + 1;
        if cnt1 = (conv_std_logic_vector(div1,32)(31 downto 1) - 1) then
            --to generate clk1
            cnt1 <= (others => '0');
            clk1_1M_reg <= NOT clk1_1M_reg;                 
            cnt2 <= cnt2 + 1;
            if cnt2 = (conv_std_logic_vector(div2,31) - 1) then
                --to generate clk2
                cnt2 <= (others => '0');
                clk2_50Hz_reg <= NOT clk2_50Hz_reg;
                if enable = '0' then
                    cnt3 <= (others => '0'); cnt4 <= (others => '0');
                    clk3_1Hz_reg <= '0'; clk4_sel_reg <= '0';
                else
                 --to generate clk3
                    cnt3 <= cnt3 + 1;
                    if cnt3 = (conv_std_logic_vector(div3,31) - 1) then
                        cnt3 <= (others => '0');
                        clk3_1Hz_reg <= NOT clk3_1Hz_reg;
                    end if;        
                    --to generate clk4
                    cnt4 <= cnt4 + 1;
                    case (tempo_reg) is
                    when "00" => 
                        if cnt4 = 20 - 1 then   
                            clk4_sel_reg <= NOT clk4_sel_reg;  --20
                            cnt4 <= (others => '0');
                        end if;
                    when "01" => 
                        if cnt4 = 40 - 1 then  
                            clk4_sel_reg <= NOT clk4_sel_reg;  --40  
                            cnt4 <= (others => '0');
                        end if;
                    when "10" => 
                        if cnt4 = 10 -1 then   
                            clk4_sel_reg <= NOT clk4_sel_reg;  --10 
                            cnt4 <= (others => '0');
                        end if;
                    when others => clk4_sel_reg <= '0'; cnt4 <= (others => '0');
                    end case;
                end if;
            end if;
        end if;
    end if;
end process;

--synchronize all input signals
process(clk1_1M_reg, rst)
begin
    if rst = '1' then
        enable <= '0'; 
    elsif rising_edge(clk1_1M_reg) then
        --two reg to avoid metastability
        --debounce buttons inputs
        start_reg1 <= start_i;
        start_reg <= start_reg1;
        if start_reg1 = '1' and start_reg = '0' then
            enable <= '1';
        end if;
           
        stop_reg1 <= stop_i;
        stop_reg <= stop_reg1;
        if stop_reg1 = '1' and stop_reg = '0' then
            enable <= '0';
        end if;

        tempo_reg1 <= tempo_i;
        tempo_reg  <= tempo_reg1;
    end if;
end process;

clk1_o <= clk1_1M_reg when enable = '1' else '0';
clk2_o <= clk2_50Hz_reg;
clk3_o <= clk3_1Hz_reg;
clk4_o <= clk4_sel_reg;

end Behavioral;

