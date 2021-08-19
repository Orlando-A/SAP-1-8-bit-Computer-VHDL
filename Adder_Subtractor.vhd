library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.numeric_std.ALL;


entity Adder_Subtractor is
 Port ( 
        
        control_signal_Su : in std_logic;
        accumulator : in std_logic_vector(7 downto 0);
        xor_in : in std_logic_vector(7 downto 0);
        sum_out : out std_logic_vector( 7 downto 0)
        );
        
end Adder_Subtractor;


architecture Behavioral of Adder_Subtractor is

signal c_out : std_logic_vector( 7 downto 0);


begin

    --Adder/Subtractor  
        
    c_out(0) <= ( control_signal_Su and ( accumulator(0) xor xor_in(0))) or (accumulator(0) and xor_in(0));
    
    sum_out(0) <= accumulator(0) xor xor_in(0) xor control_signal_Su;
    
    c_out(1) <= ( c_out(0) and ( accumulator(1) xor xor_in(1))) or (accumulator(1) and xor_in(1));
    
    sum_out(1) <= accumulator(1) xor xor_in(1) xor c_out(0); 
    
    c_out(2) <= ( c_out(1) and ( accumulator(2) xor xor_in(2))) or (accumulator(2) and xor_in(2));
    
    sum_out(2) <= accumulator(2) xor xor_in(2) xor c_out(1);
    
    c_out(3) <= ( c_out(2) and ( accumulator(3) xor xor_in(3))) or (accumulator(3) and xor_in(3));
    
    sum_out(3) <= accumulator(3) xor xor_in(3) xor c_out(2);       
    
    c_out(4) <= ( c_out(3) and ( accumulator(4) xor xor_in(4))) or (accumulator(4) and xor_in(4));
    
    sum_out(4) <= accumulator(4) xor xor_in(4) xor c_out(3);    
    
    c_out(5) <= ( c_out(4) and ( accumulator(5) xor xor_in(5))) or (accumulator(5) and xor_in(5));
    
    sum_out(5) <= accumulator(5) xor xor_in(5) xor c_out(4);
    
    c_out(6) <= ( c_out(5) and ( accumulator(6) xor xor_in(6))) or (accumulator(6) and xor_in(6));
    
    sum_out(6) <= accumulator(6) xor xor_in(6) xor c_out(6);
    
    c_out(7) <= ( c_out(6) and ( accumulator(7) xor xor_in(7))) or (accumulator(7) and xor_in(7));
    
    sum_out(7) <= accumulator(7) xor xor_in(7) xor c_out(6);


--another model for ALU
--     process(Su,Eu)
--     begin       
--      --Full adder b_bit 1      
--    -----------------------------------------------        
--     w<= std_logic_vector(unsigned(accumulator_a) + unsigned(b_register_a))
--             when Eu='1' and Su = '0'
--             else 
--             std_logic_vector(unsigned(accumulator_a) - unsigned(b_register_a))
--             when Eu = '1' and Su ='1' else (others => 'Z');
--    end process;

end Behavioral;
