library IEEE;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_1164.ALL;


entity Program_Counter is
  Port ( 
   
        clr : in std_logic;
        clk : in std_logic;
        control_signal_Cp : in std_logic;
        program_counter_out : out std_logic_vector(3 downto 0)
        );

end Program_Counter;


architecture Behavioral of Program_Counter is

signal program_counter : std_logic_vector(3 downto 0);


begin


    process(clk,clr)
    
        begin
                 
        if(clr = '0') then
            program_counter<="0000";
                   
        elsif(falling_edge(clk))then
                   
            if(control_signal_Cp='1') then --this is the program counter circuit
                program_counter<= program_counter + '1';
                    
            else
                    
            program_counter<= program_counter;
                   
            end if;
                   
        end if;
     
    end process; 
    
program_counter_out <= program_counter;
    

end Behavioral;
