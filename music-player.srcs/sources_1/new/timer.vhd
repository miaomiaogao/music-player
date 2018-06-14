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

entity timer is
Port ( clk          : in   STD_LOGIC;					--100MHz
           rst          : in   STD_LOGIC;
           clk2_i       : in   STD_LOGIC;                   --50Hz
           clk3_i       : in   STD_LOGIC;                   --1Hz
           start_i      : in   STD_LOGIC;				
           an_o         : out  STD_LOGIC_VECTOR (1 downto 0);
           seg_o        : out  STD_LOGIC_VECTOR (6 downto 0));
end timer;

architecture Behavioral of timer is
signal clk3_reg, clk3_reg1      : std_logic;
signal clk2_reg                 : std_logic;
signal start_reg1, start_reg    : std_logic;
signal enable                   : std_logic;
signal an_reg                   : std_logic_vector(1 downto 0);
signal seg_reg                  : std_logic_vector(6 downto 0);
signal cnt_ones                 : integer range 0 to 15;
signal cnt_tens                 : integer range 0 to 15;
signal bcd_reg                  : integer range 0 to 15;

type SEG_TruthTable_TYPE is array(0 to 9) of std_logic_vector(6 downto 0);
constant Seg_TruthTable : SEG_TruthTable_TYPE := (
    "0000001", "1001111", "0010010", "0000110", "1001100",  -- 0 1 2 3 4
    "0100100", "0100000", "0001111", "0000000", "0000100");  -- 5 6 7 8 9  
    
begin

process(clk,rst)
begin
    if rst = '1' then
        clk3_reg <= '0'; clk3_reg1 <= '0'; clk2_reg <= '0'; 
        cnt_tens <= 0; cnt_ones <= 0;
        bcd_reg <= 0; an_reg <= (others => '1'); seg_reg <= (others => '1');
        start_reg <= '0'; start_reg1 <= '0'; enable <= '0';
    elsif rising_edge(clk) then
        clk3_reg1 <= clk3_i;
        clk3_reg  <= clk3_reg1;
        start_reg1 <= start_i;
        start_reg <= start_reg1;
       
            
        if enable = '1' and (clk3_reg = '0' and clk3_reg1 = '1') then  --1Hz COUNTER INPUT
            cnt_ones <= cnt_ones + 1;
            if cnt_ones = 9 then
                cnt_ones <= 0;
                cnt_tens <= cnt_tens + 1;
                if cnt_tens = 9 then
                    cnt_tens <= 0;
                end if;
            end if;
        end if;
        
         if start_reg1 = '1' and start_reg = '0' then
            cnt_ones <= 0;
            cnt_tens <= 0;
            enable <= '0';
         end if;
         if start_reg1 = '1' and start_reg = '0' then
             enable <= '1';
          end if;
                  
        clk2_reg <= clk2_i;
        if clk2_reg = '0' then
            bcd_reg <= cnt_ones;
            an_reg <= "10";
        else
            bcd_reg <= cnt_tens;
            an_reg <= "01";
        end if;

        seg_reg <= SEG_TruthTable(bcd_reg);

    end if;

end process;

an_o <= an_reg;
seg_o <= seg_reg;

end Behavioral;
