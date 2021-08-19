library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Instruction_Register is
  Port (
  
        register_b : out std_logic_vector(3 downto 0);
        register_a : out std_logic_vector(3 downto 0);
        control_signal_Li : in std_logic;
        bus_signal : in std_logic_vector(7 downto 0);
        clear : in std_logic;
        clk : in std_logic
        );
  
   
end Instruction_Register;


architecture Behavioral of Instruction_Register is

signal instruction_register_a : std_logic_vector( 3 downto 0);
signal  instruction_register_b : std_logic_vector( 3 downto 0);


begin


    process(clk,clear)
    
        begin
        
        if(clear = '1')then
            instruction_register_a<= "0000";
        
        elsif(rising_edge(clk))then     --this is the instruction register circuit, it is a nibble buffer latch 
        
            if(control_signal_Li='0')then
                instruction_register_a<=bus_signal(3 downto 0) ; 
    
            end if;
        
        end if;
                 
    end process;
   
register_a <= instruction_register_a;  


    process(clk,clear)
    
        begin
            
        if(clear = '1')then
            instruction_register_b<= "0000";
        
        elsif(rising_edge(clk)) then     --this is the second instruction register circuit, it is a nibble buffer latch 
        
            if(control_signal_Li='0') then
                instruction_register_b<=bus_signal(7 downto 4) ; 
              
            end if;
        
        end if;
                    
    end process;
    
register_b <= instruction_register_b;


end Behavioral;
