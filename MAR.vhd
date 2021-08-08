----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/18/2021 06:40:15 PM
-- Design Name: 
-- Module Name: MAR - Behavioral
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

entity MAR is
 Port ( 
 clr : in std_logic;
 mar_out: out std_logic_vector(3 downto 0);
 clk : in std_logic; 
 bus_line : in std_logic_vector(3 downto 0);
 control_signal_Lm : in std_logic  
 );
end MAR;

architecture Behavioral of MAR is
signal mar_in : std_logic_vector (3 downto 0) := (others => '0');

begin

    process(clk,clr)
    
            begin
            if(CLR='1')then
            mar_in<="0000";
            elsif(rising_edge(clk)) then     --this is the mar circuit, it is a nibble buffer latch 
            if(control_signal_Lm='0') then
            mar_in(3 downto 0)<=bus_line(3 downto 0) ; 
                
           
            end if;
        end if;            
    end process;
            
mar_out<=mar_in;

end Behavioral;
