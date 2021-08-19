library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity B_Register is
  Port ( 
        
        clk : in std_logic;
        clear : in std_logic;
        control_signal_Lb : in std_logic;
        control_signal_Su : in std_logic;
        bus_signal : in std_logic_vector(7 downto 0);
        xor_out : out std_logic_vector(7 downto 0)
        );
   
end B_Register;


architecture Behavioral of B_Register is

signal b_register_a : std_logic_vector (7 downto 0):=(others => '0');
signal xor_out_a : std_logic_vector ( 7 downto 0);


begin


    process(clk,clear)
    
        begin
        
        if(clear='1')then
            b_register_a<="00000000";
        
        elsif(rising_edge(clk)) then     --this is B Register
    
            if(control_signal_Lb='0') then
                b_register_a(7 downto 0)<=bus_signal(7 downto 0) ; 
        
            end if;
        
        end if;
                    
    end process;  
   
    
    process(b_register_a)
        
        begin
    
        xor_out_a(0)<= b_register_a(0) xor control_signal_Su;
        xor_out_a(1)<= b_register_a(1) xor control_signal_Su;
        xor_out_a(2)<= b_register_a(2) xor control_signal_Su;
        xor_out_a(3)<= b_register_a(3) xor control_signal_Su;
        
        xor_out_a(4)<= b_register_a(4) xor control_signal_Su;
        xor_out_a(5)<= b_register_a(5) xor control_signal_Su;
        xor_out_a(6)<= b_register_a(6) xor control_signal_Su;      
        xor_out_a(7)<= b_register_a(7) xor control_signal_Su;       
    
    end process;         

xor_out<=xor_out_a;


end Behavioral;
