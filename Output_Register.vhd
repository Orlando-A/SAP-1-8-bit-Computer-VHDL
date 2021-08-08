----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2021 12:40:04 PM
-- Design Name: 
-- Module Name: Output_Register - Behavioral
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

entity Output_Reg is
  Port ( 
        
        clk : in std_logic;
        clear : in std_logic;
        control_signal_Lo : in std_logic;
        bus_line : in std_logic_vector(7 downto 0);
        output : out std_logic_vector( 7 downto 0)
  
  );
end Output_Reg;

architecture Behavioral of Output_Reg is

 signal reg : std_logic_vector( 7 downto 0);
 
begin

    process(clk,clear)
    
            begin
            if(clear='1')then
            reg<="00000000";
            elsif(rising_edge(clk)) then     --this is the output register
            if(control_signal_Lo='0') then
        
            reg<=bus_line ; 
            end if;
        end if;            
    end process;    


output <= reg;


end Behavioral;
