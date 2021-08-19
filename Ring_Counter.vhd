library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Ring_Counter is
  Port ( 
  
        clk : in std_logic;
        clear : in std_logic;
        count_out : out  std_logic_vector( 6 downto 0) 
        );
        
end Ring_Counter;


architecture Behavioral of Ring_Counter is

signal ringcount : std_logic_vector( 6 downto 0);


begin


    process(clk,clear)
    
        begin
    
        if (clear = '0')then
            ringcount<="0000001";
        
        elsif (falling_edge(clk))then
        ringcount(1)<=ringcount(0);
        ringcount(2)<=ringcount(1);
        ringcount(3)<=ringcount(2);
        ringcount(4)<=ringcount(3);
        ringcount(5)<=ringcount(4);
        ringcount(6)<=ringcount(5);
        ringcount(0)<=ringcount(6);
    
        end if;
    
    end process;
   
count_out<=ringcount; 


end Behavioral;