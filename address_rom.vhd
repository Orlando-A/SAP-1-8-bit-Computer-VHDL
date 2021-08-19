library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity Address_Rom is 
  port(
        address_out : out std_logic_vector ( 3 downto 0);
        addr_in : in std_logic_vector( 3 downto 0)
        );

end Address_Rom;


architecture Behavioral of Address_Rom is

type address_type is array(0 to 15) of std_logic_vector(3 downto 0);
constant address : address_type:=("0011",--LDA
                                  "0110",--ADD
                                  "1001",--SUB
                                  "0000",
                                  "0000",
                                  "0000",
                                  "0000",
                                  "0000",
                                  "0000",
                                  "0000",
                                  "0000",
                                  "0000",
                                  "0000",
                                  "0000",
                                  "1100",--OUT
                                  "0000");

begin


    process(addr_in)

        begin

        address_out<= address(conv_integer(addr_in));

    end process;


end Behavioral;
