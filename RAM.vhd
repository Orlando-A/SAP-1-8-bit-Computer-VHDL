library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.numeric_std.ALL;


entity RAM is
  Port (
  
        switch_in : in std_logic;
        address_switch_in : in std_logic_vector(3 downto 0);
        ce_RAM_in : std_logic;
        read_write_in : std_logic;
        ram_out_a : out std_logic_vector(7 downto 0);
        mar_out_b: in std_logic_vector(3 downto 0);
        run_prog_in : in std_logic;
        data_input : in std_logic_vector(7 downto 0)
        );
   
end RAM;


architecture Behavioral of RAM is

signal mux_out : std_logic_vector (3 downto 0);
type RW_type is array (0 to 15 ) of std_logic_vector(7 downto 0);
signal RW : RW_type;   
signal program_switch: std_logic;


begin
      
      
    process(switch_in)
        
        begin
	
	    case switch_in is
	    
	      when '0' => mux_out <= mar_out_b;
		  when '1' => mux_out <= address_switch_in;
		  when others => mux_out<=mar_out_b;	---might have to delete
        
        end case;

    end process;
      
         
    process(ce_RAM_in)
        
        begin      
         
        case ce_RAM_in is
	
		  when '0' => program_switch <= '0';
		  when '1' => program_switch <= run_prog_in ;	
		  when others => program_switch <= '0'; --might have to delete

        end case;

    end process;
    
            
    process(program_switch,read_write_in,mux_out)
        
        begin
            
        if (program_switch='1')then
            ram_out_a<="ZZZZZZZZ";
            
        else 
                
            if(read_write_in='0')then
                RW(TO_INTEGER(unsigned(mux_out)))<= data_input;
                ram_out_a<="ZZZZZZZZ";
            
         else
         
            ram_out_a<= RW(TO_INTEGER(unsigned(mux_out)));
            
            end if;
        
        end if;

    end process;


end Behavioral;
