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

entity leds is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           snd_div_i : in STD_LOGIC_VECTOR (15 downto 0);
           leds_o : out STD_LOGIC_VECTOR (10 downto 0));
end leds;

architecture Behavioral of leds is
signal leds_reg : std_logic_vector(10 downto 0);
signal snd_div_reg : std_logic_vector(15 downto 0);
begin

process(clk,rst)
begin
    if rst = '1' then
        leds_reg <= (others => '0');
        snd_div_reg <= (others => '0');
    elsif rising_edge(clk) then
        snd_div_reg <= snd_div_i;
        leds_reg <= (others => '0');
        if snd_div_reg <= 31 and snd_div_reg > 0 then
            leds_reg(0) <= '1';
        elsif snd_div_reg <= 63 then
            leds_reg(1) <= '1';
        elsif snd_div_reg <= 125 then
            leds_reg(2) <= '1';
        elsif snd_div_reg <= 250 then
            leds_reg(3) <= '1';
        elsif snd_div_reg <= 500 then
            leds_reg(4) <= '1';
        elsif snd_div_reg <= 1000 then
            leds_reg(5) <= '1'; 
        elsif snd_div_reg <= 2000 then
            leds_reg(7) <= '1';
        elsif snd_div_reg <= 4000 then
            leds_reg(8) <= '1';
        elsif snd_div_reg <= 7813 then
            leds_reg(9) <= '1';
        elsif snd_div_reg <= 15625 then
            leds_reg(10) <= '1';
        end if;
    end if;
end process;

leds_o <= leds_reg;
end Behavioral;
