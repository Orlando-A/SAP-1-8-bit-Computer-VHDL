library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Output_Reg is
  Port ( 
        
        clk : in std_logic;
        clear : in std_logic;
        control_signal_Lo : in std_logic;
        bus_signal : in std_logic_vector(7 downto 0);
        output : out std_logic_vector( 7 downto 0):=(others => '0')
         );
         
end Output_Reg;

architecture Behavioral of Output_Reg is

signal reg : std_logic_vector( 7 downto 0):=(others => '0');

 
begin


    process(clk,clear)
    
        begin
            
        if(clear='1')then
            reg<="00000000";
            
        elsif(rising_edge(clk)) then --this is the output register
            
            if(control_signal_Lo='0') then
                reg<=bus_signal ; 
            
            end if;
        
        end if;            
    
    end process;    

output <= reg;


end Behavioral;
