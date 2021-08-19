library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity Clock_Module is
    Port ( 
    divider_out_8 : out std_logic;
    clk : in std_logic;
    hlt_in : in std_logic;
    control_signal_start : in std_logic;
    notCLR_out : out std_logic;
    clr_out : out std_logic;
    control_signal_single : in std_logic;
    control_signal_manual : in std_logic;
    sap1_clk_out : out std_logic;
    sap1_invclk_out : out std_logic
    ); 

end Clock_Module;


architecture Behavioral of Clock_Module is

signal divider : std_logic_vector (22 downto 0);
signal clock_flip_flop : std_logic;
signal Q0,CLK_debounce :  STD_LOGIC;
signal delay1,delay2,delay3,debouncer_out,Single_Step_out,manual,auto : std_logic;
signal delay4,delay5,delay6,delay7,delay8,delay9 : std_logic;
signal sap1_invclk, sap1_clk,notCLR,CLR: std_logic;


begin


    process(clk)
        
        begin
                
        divider <="00000000000000000000000";   --|----------------------------
        if rising_edge(clk)then                --|comments:
            divider <= divider + '1';          --|Clock divider that is used in the clock circuit
                                               --|
        end if;                                --|
                                               --|
    end process;                               --|
                                               --|----------------------------
clock_flip_flop<= divider(5);
CLK_debounce<=divider(18); 
divider_out_8<=divider(8);                

                
    process(clock_flip_flop,hlt_in,notCLR)
                    
        begin
                
        if (notCLR = '0') then                              --|----------------------------
            Q0<= '0';                                       --|comments:
                                                            --|
        elsif (hlt_in <= '0') then                          --|clock circuit
            Q0<= Q0;                                        --|
                                                            --|
            elsif(falling_edge(clock_flip_flop))then        --|
                Q0 <= not Q0;                               --|
                                                            --|
        end if;                                             --|-----------------------------
                  
    end process;
                 
                 
    process(CLK_debounce)
    
        begin
                
        if rising_edge(CLK_debounce) then   --debouncer circuit for start clear switch
            delay1 <= control_signal_start;
            delay2 <= delay1;
            delay3 <= delay2;
    
        end if;
                
    end process;
    
debouncer_out <= delay1 and delay2 and delay3;   --signal assignment of deboumcer circuit to debouncer_out
clr<= debouncer_out;    --   this signal goes to the instruction register                
notCLR <= not debouncer_out; --this signal is used throughout as the inversion of CLR
clr_out<=clr;
notCLR_out<=notCLR;   
  
                
    process(CLK_debounce)
    
        begin
                
        if rising_edge(CLK_debounce) then        --debouncer circuit for single step push button when circuit is in single step mode
            delay4 <= control_signal_single;
            delay5 <= delay4;
            delay6 <= delay5;
    
        end if;
    
    end process;
    
Single_Step_out <= delay4 and delay5 and delay6;   -- signal assignment of debouncer circuit to Single_step_out signal 
    
                
    process(CLK_debounce)
   
        begin
                
        if rising_edge(CLK_debounce) then
            delay7 <= control_signal_manual;                  -- debouncer circuit for the manual or auto switch
            delay8 <= delay7;
            delay9 <= delay8;
        
        end if;
        
    end process;
    
manual<= delay7 and delay8 and delay9; --signal assignment from debouncer circuit to signal manual
auto<= not manual; -- if switch is down the manual signal inverts and the circuit is in auto mode
sap1_clk <= (manual and Single_Step_out and HLT_in)or(auto and Q0);   -- this dictates which clock goes to the computer, manual or auto
sap1_invclk<= not sap1_clk; 
sap1_clk_out<=sap1_clk;
sap1_invclk_out<=sap1_invclk;


end Behavioral;
