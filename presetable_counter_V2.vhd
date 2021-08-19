library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Presettable_Counter_V2 is
  Port ( 
  
        clk : in std_logic;
        clear : in std_logic;
        word_in  : in std_logic_vector(3 downto 0);
        load : in std_logic;
        word_out : out std_logic_vector(3 downto 0)
        );

end Presettable_Counter_V2;


architecture Behavioral of Presettable_Counter_V2 is

signal count : std_logic_vector(3 downto 0);


begin


    process(clk,clear)

        begin

        if(clear = '1')then
		  count<="0000";
		
        elsif (falling_edge(clk))then 
		
		  if(load = '1')then
		      count<=word_in;
		      
		   end if;
	
	           if (load = '0')then
		          count<=count + '1';
		
                end if;
        
        end if;
    
    
    end process;
    
word_out<=count;
    

end Behavioral;
