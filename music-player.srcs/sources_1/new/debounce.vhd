----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2018/06/13 14:46:30
-- Design Name: 
-- Module Name: debounce - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


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

entity debounce is
    generic( CNT_NUM : integer := 1);   --CNT_NUM MHz clock in
    Port ( clk : in STD_LOGIC;      
           rst : in STD_LOGIC;
           key_i : in STD_LOGIC; 
           key_o : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is
signal key_reg, key_reg1, key_reg2, key_o_reg: std_logic;
signal cnt,cnt1,cnt2 : integer;
begin

process(clk,rst)
begin
    if rst = '1' then
        cnt <= 0; cnt1 <= 0;
        key_reg1 <= '0'; key_reg2 <= '0'; key_reg <= '0';key_o_reg <= '0';
    elsif rising_edge(clk) then
        key_reg2 <= key_i;
        key_reg1 <= key_reg2;
        key_reg <= key_reg1;
        if key_reg /= key_reg1 then
            cnt <= 0;
            cnt1 <= 0;
        else
            cnt <= cnt + 1;
            if cnt = CNT_NUM - 1 then 									--1us
                cnt <= 0;
                cnt1 <= cnt1 + 1;
                if cnt1 = 4999 then										--5ms
                    cnt1 <= cnt1;
					key_o_reg <= key_reg;
                end if;
            end if;   
        end if;
    end if;
end process;
key_o <= key_o_reg;
end Behavioral;
