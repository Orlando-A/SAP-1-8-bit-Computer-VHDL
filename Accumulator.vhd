----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/26/2021 11:39:01 AM
-- Design Name: 
-- Module Name: Accumulator - Behavioral
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

entity Accumulator is
 Port ( 
        clk : in std_logic;
        clear : in std_logic;
        bus_line : in std_logic_vector( 7 downto 0);
        control_signal_La : in std_logic;
        accumulator_out : out std_logic_vector( 7 downto 0 )
    
 
 
 );
end Accumulator;

architecture Behavioral of Accumulator is

signal accumulator : std_logic_vector(7 downto 0);


begin

    process(clk,clear)
    
            begin
            if(clear='1')then
            accumulator<="00000000";
          
            elsif(rising_edge(clk)) then     --this is C10 Accumulator
            if(control_signal_La='0') then
            
            accumulator(7 downto 0)<=bus_line(7 downto 0) ; 
            end if;
        end if;            
    end process;           
 
 accumulator_out<=accumulator;           

end Behavioral;
