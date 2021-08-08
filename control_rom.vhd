library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_rom is
   
  port(
    address_out_a : out std_logic_vector ( 12 downto 0);
    addr_a : in std_logic_vector( 3 downto 0));
end control_rom;

architecture Behavioral of control_rom is

type address_type is array(0 to 15) of std_logic_vector(12 downto 0);
constant address : address_type:=("0010111100011","0101111100011","0001001100011",    "0000110100011","0001011000011","0001111100011",    "0000110100011","0001011100001","1001111000111",       "0000110100011","0001011100001","0001111001111"
,"0001111110010","0001111100011","0001111100011","0000000000000");

begin

process(addr_a)
begin
address_out_a<= address(conv_integer(addr_a));
end process;


--behavioral model of control_rom

--process(not_instruction_register_b,instruction_register_b)
--begin
--    LDA<=(not_instruction_register_b(3) and not_instruction_register_b(2) and not_instruction_register_b(1) and not_instruction_register_b(0));
--    ADD<=(not_instruction_register_b(3) and not_instruction_register_b(2) and not_instruction_register_b(1) and instruction_register_b(0));
--    SUB<=(not_instruction_register_b(3) and not_instruction_register_b(2) and instruction_register_b(1) and not_instruction_register_b(0));
--    output<=(instruction_register_b(3) and instruction_register_b(2) and instruction_register_b(1) and not_instruction_register_b(0));
--  end process;
  
  
--   process(not_instruction_register_b,instruction_register_b,ringcount)
--   begin 
--    Cp<=ringcount(1);
--    Ep<=ringcount(0);
--    Lm<=not(ringcount(0)or (LDA and ringcount(3)) or (ADD and ringcount(3)) or (SUB and ringcount(3)));
--    run_prog<=not(ringcount(2)or(LDA and ringcount(4))or(ADD and ringcount(4))or(SUB and ringcount(4)));   
--    Li<= not(ringcount(2));
--    Ei<=not((LDA and ringcount(3))or (ADD and ringcount(3)) or (SUB and ringcount(3)));
--    La<=not((LDA and ringcount(4))or(ADD and ringcount(5))or(SUB and ringcount(5))); 
--    Ea<=(output and ringcount(3));
--    Su<=(SUB and ringcount(5));
--    Eu<=((ADD and ringcount(5)) or (SUB and ringcount(5)));
--    Lb<=not((ADD and ringcount(4)) or (SUB and ringcount(4)));
--    Lo<=not(output and ringcount(3));
    
--    end process;

end Behavioral;