----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/18/2021 05:57:02 PM
-- Design Name: 
-- Module Name: program_counter - Behavioral
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

use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity program_counter is
  Port ( 
   clr : in std_logic;
   clk : in std_logic;
   control_signal_Cp : in std_logic;
   program_counter_out : out std_logic_vector(3 downto 0)
   
  );
end program_counter;

architecture Behavioral of program_counter is
signal program_counter : std_logic_vector(3 downto 0);

begin

    process(clk,clr)
    
                 begin
                 
                   if(clr = '0') then
                   program_counter<="0000";
                   elsif(falling_edge(clk))then
                   if control_signal_Cp='1' then                                       --this is the program counter circuit
                   program_counter<= program_counter + '1';
                   else
                   program_counter<= program_counter;
                   end if;
                   end if;
     
    end process; 
    program_counter_out <= program_counter;
    
end Behavioral;
