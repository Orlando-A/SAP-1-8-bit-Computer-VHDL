----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2021 12:25:45 PM
-- Design Name: 
-- Module Name: Ring_Counter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ring_Counter is
  Port ( 
  
        clk : in std_logic;
        clear : in std_logic;
        reg : out  std_logic_vector( 5 downto 0) 
  );
end Ring_Counter;

architecture Behavioral of Ring_Counter is
  signal ringcount : std_logic_vector( 5 downto 0);
begin

  
    process(clk,clear)--ring_count_clr if using microprogramming
    begin
    if (clear = '0')then
    ringcount<="000001";
    elsif (falling_edge(clk))then
    ringcount(1)<=ringcount(0);
    ringcount(2)<=ringcount(1);
    ringcount(3)<=ringcount(2);
    ringcount(4)<=ringcount(3);
    ringcount(5)<=ringcount(4);
    ringcount(0)<=ringcount(5);
    end if;
    
 end process;
   reg<=ringcount; 
end Behavioral;
