----------------------------------------------------------------------------------
-- Company: 
-- Student: Orlando Arriaga
-- 
-- Create Date: 01/15/2021 08:29:25 PM
-- Design Name: SAP-1 
-- Module Name: SAP-1 - architecture
-- Project Name: SAP-1 as taught in Digital Computer Electronics by Albert Paul Malvino, Ph.D. Jerald A. Brown
-- Target Devices: Basys 3
-- Tool Versions: Vivado 2020.2
--
-- Description: The SAP (Simple-As-Posible) computer is designed for the beginer.
--              It intruduces the crucial ideas behind computer operation.
-- 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Inspired by Ben Eater 8-bit computer
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.numeric_std.ALL;


entity SAP_1 is

    port( 
     
    t1_clr_pr : out std_logic; 
    clr_in : in std_logic;
    Anode_Activate_out : out std_logic_vector(3 downto 0);
    LED_out_x : out std_logic_vector(6 downto 0);
    RAM_LED: out std_logic_vector(7 downto 0);
    ce_RAM: in std_logic;
    read_write: in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    adress_switch : in std_logic_vector (3 downto 0);
    Switch2 : in std_logic;
    binary_out : out std_logic_vector(7 downto 0);
    basys3_clk  : in std_logic;
    Start_Clear : in std_logic;  --pushbutton
    Single_Step : in std_logic;  --pushbutton
    Manual_Auto : in std_logic
    ); 
     
end SAP_1;


architecture SAP_1 of SAP_1 is
        
        
    signal w : STD_LOGIC_VECTOR (7 downto 0);
    signal divider8 : std_logic;
    signal sap1_invclk, sap1_clk, notCLR: std_logic;
    signal program_counter_a : std_logic_vector (3 downto 0);
    signal ram_out : std_logic_vector(7 downto 0);
    signal Li,Ei,La,Ea,Eu,Su,Lb,Lm,Cp,Ep,run_prog,Lo   : std_logic;
    signal instruction_register_a : std_logic_vector(3 downto 0):=(others => '0');
    signal instruction_register_b : std_logic_vector(3 downto 0):=(others => '0');
    signal CLR : std_logic;
    signal accumulator_a : std_logic_vector(7 downto 0):=(others => '0');
    signal Cout0,Cout1,Cout2,Cout3,Cout4,Cout5,Cout6,Cout7 : std_logic;
    signal ringcount : std_logic_vector(5 downto 0):=(others => '0');
    signal not_instruction_register_b : std_logic_vector(3 downto 0):=(others => '0');
    signal LDA : std_logic; 
    signal ADD : std_logic;
    signal SUB: std_logic;
    signal output,HLT : std_logic;
    signal output_register : std_logic_vector(7 downto 0);
    signal myram: std_logic_vector(7 downto 0);
    signal addr_rom_presetcount : std_logic_vector(3 downto 0);
    signal preset_to_ctrom : std_logic_vector(3 downto 0):=(others => '0');
    signal con_word : std_logic_vector(12 downto 0);
    signal nop : std_logic;
    signal mar_out_a : std_logic_vector(3 downto 0);
    signal ring_count_clr : std_logic;
    signal bcd0_out,bcd1_out,bcd2_out : std_logic_vector(3 downto 0);
    signal  xor_out_a : std_logic_vector(7 downto 0);
    signal  c_out : std_logic_vector(7 downto 0);
    signal s_out : std_logic_vector(7 downto 0);
    signal carry_register : std_logic_vector(3 downto 0);

        
component address_rom is 
     
    port(   
    address_out : out std_logic_vector ( 3 downto 0);
    addr : in std_logic_vector( 3 downto 0)
    );
    
end component;   
    
    
component presetable_counter_V2 is 
    
    port(
    clk : in std_logic;
    clear : in std_logic;
    word  : in std_logic_vector(3 downto 0);
    load : in std_logic;
    word_out : out std_logic_vector(3 downto 0)
    ); 
           
end component;

     
component control_rom is 

     port(
     address_out_a : out std_logic_vector ( 12 downto 0);
     addr_a : in std_logic_vector( 3 downto 0)
     );
    
end component; 
     
     
component binary_bcd is 

    generic(N: positive := 8);
    port(
    clk, reset: in std_logic;
    binary_in: in std_logic_vector(N-1 downto 0);
    bcd0, bcd1, bcd2, bcd3, bcd4: out std_logic_vector(3 downto 0)
    );
    
end component;
        
        
component seven_segment_display_VHDL is
   
    Port (  
    clock_100Mhz : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
    reset : in STD_LOGIC; -- reset
    bcd0_in, bcd1_in, bcd2_in : in std_logic_vector(3 downto 0);
    Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
    LED_out : out STD_LOGIC_VECTOR (6 downto 0)
    );
  
end component;  


component program_counter is

    port(
    clr : in std_logic;
    clk : in std_logic;
    control_signal_Cp : in std_logic;
    program_counter_out : out std_logic_vector(3 downto 0)
    );
        
end component; 


component MAR is

    port(
    clr : in std_logic;
    mar_out: out std_logic_vector(3 downto 0);
    clk : in std_logic; 
    bus_line : in std_logic_vector(3 downto 0);
    control_signal_Lm : in std_logic  
    );
    
end component; 


component RAM is 

    port(
    switch_in : in std_logic;
    address_switch_in : in std_logic_vector(3 downto 0);
    ce_RAM_in : std_logic;
    read_write_in : std_logic;
    ram_out_a : out std_logic_vector(7 downto 0);
    mar_out_b : in std_logic_vector(3 downto 0);
    run_prog_in : in std_logic;
    data_input : in std_logic_vector(7 downto 0)
    );
    
end component;


component Instruction_Register is 

    port(
    register_b : out std_logic_vector(3 downto 0);
    register_a : out std_logic_vector(3 downto 0);
    control_signal_Li : in std_logic;
    bus_signal : in std_logic_vector(7 downto 0);
    clear : in std_logic;
    clk : in std_logic
    );
    
end component;
        
  
component Accumulator is 

    port(
    clk : in std_logic;
    clear : in std_logic;
    bus_line : in std_logic_vector( 7 downto 0);
    control_signal_La : in std_logic;
    accumulator_out : out std_logic_vector( 7 downto 0 )
     );
     
end component;
  
  
component B_Register is 

    port(
    clk : in std_logic;
    clear : in std_logic;
    control_signal_Lb : in std_logic;
    control_signal_Su : in std_logic;
    bus_line : in std_logic_vector(7 downto 0);
    xor_out : out std_logic_vector(7 downto 0)
    );
    
end component;
          
  
component Adder_Subtractor is 

    port(
    control_signal_Su : in std_logic;
    accumulator : in std_logic_vector(7 downto 0);
    xor_in : in std_logic_vector(7 downto 0);
    sum_out : out std_logic_vector( 7 downto 0)
    );
    
end component;  


component Ring_Counter is

    port(
    clk : in std_logic;
    clear : in std_logic;
    reg : out  std_logic_vector( 5 downto 0)
    );
    
end component;   


component Output_Reg is

    port(
    clk : in std_logic;
    clear : in std_logic;
    control_signal_Lo : in std_logic;
    bus_line : in std_logic_vector(7 downto 0);
    output : out std_logic_vector( 7 downto 0)
    );
    
end component;   


component Clock_Module is 

    port(
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
    ); --basys 3 clk in

end component;


begin 


ADDR_ROM : address_rom port map(addr=>instruction_register_b,address_out=>addr_rom_presetcount); 
    
         
preseset_count : presetable_counter_V2 port map(word=>addr_rom_presetcount,load=>ringcount(2),word_out=>preset_to_ctrom ,
clk=>sap1_clk,clear=>clr_in);  
   
   
t1_clr_pr <= CLR or ringcount(0);
                      
    
control_out : control_rom port map(addr_a=>preset_to_ctrom,address_out_a=>con_word); 


    Cp<=con_word(11);  
    Ep<=con_word(10);
    Lm<=con_word(9);
    run_prog<=con_word(8); 
    Li<=con_word(7); 
    Ei<=con_word(6); 
    La<=con_word(5); 
    Ea<=con_word(4); 
    Su<=con_word(3);
    Eu<=con_word(2); 
    Lb<=con_word(1); 
    Lo<=con_word(0);      
    
    
nop<= not((not Cp)and(not Ep)and Lm and run_prog and Li and Ei and La and (not Ea) and (not Su) and (not Eu) and Lb and Lo);

            
bcd : binary_bcd port map(clk=>divider8,reset=>CLR,binary_in=>output_register,bcd0=>bcd0_out,bcd1=>bcd1_out, bcd2=>bcd2_out);
     
     
dispay_control : seven_segment_display_VHDL port map (clock_100Mhz=>basys3_clk,reset=>CLR,bcd0_in=>bcd0_out,bcd1_in=>bcd1_out,
bcd2_in=>bcd2_out,Anode_Activate=>Anode_Activate_out,LED_out=>LED_out_x);     



SAP1_CLK_Module : Clock_Module port map (divider_out_8=>divider8,clk=>basys3_clk,hlt_in=>hlt,
control_signal_start=>Start_Clear,notCLR_out=>notCLR,clr_out=>clr,control_signal_single=>Single_Step,
control_signal_manual=>Manual_Auto,sap1_clk_out=>sap1_clk,sap1_invclk_out=>sap1_invclk);


    
  
program_counter_module : program_counter port map(clk=>sap1_invclk,control_signal_Cp=>Cp,clr=>notCLR,program_counter_out=>program_counter_a); 
       
            
    w(0)<= program_counter_a(0) when Ep='1' else 'Z' when Ep ='0';
    w(1)<= program_counter_a(1) when Ep='1' else 'Z' when Ep ='0';
    w(2)<= program_counter_a(2) when Ep='1' else 'Z' when Ep ='0';     --three state buffers for the program counter
    w(3)<= program_counter_a(3) when Ep='1' else 'Z' when Ep ='0';
            
                      
mar_module : MAR port map(clk=>sap1_clk, clr=>CLR, control_signal_Lm=>Lm,bus_line=>w(3 downto 0),mar_out=>mar_out_a);      
             
 
RAM_module : RAM port map(switch_in=>Switch2,address_switch_in=>adress_switch,ce_RAM_in=>ce_RAM,read_write_in=>read_write,
ram_out_a=>ram_out,run_prog_in=>run_prog,data_input=>data_in,mar_out_b=>mar_out_a);

  
    w(0)<=ram_out(0) when run_prog ='0' else 'Z' when run_prog ='1'; 
    w(1)<=ram_out(1) when run_prog ='0' else 'Z' when run_prog ='1';
    w(2)<=ram_out(2) when run_prog ='0' else 'Z' when run_prog ='1';
    w(3)<=ram_out(3) when run_prog ='0' else 'Z' when run_prog ='1';
    w(4)<=ram_out(4) when run_prog ='0' else 'Z' when run_prog ='1';
    w(5)<=ram_out(5) when run_prog ='0' else 'Z' when run_prog ='1';
    w(6)<=ram_out(6) when run_prog ='0' else 'Z' when run_prog ='1';
    w(7)<=ram_out(7) when run_prog ='0' else 'Z' when run_prog ='1';
 
   
myram <= ram_out;
RAM_LED(7 downto 0)<=myram(7 downto 0);--lights up leds, this shows us the contents of ram_out  
   
   
SAP_Instruction_Registers : Instruction_Register port map(clk=>sap1_clk, clear=>CLR, bus_signal=>w(7 downto 0),
control_signal_Li=>Li,register_a=>instruction_register_a, register_b=>instruction_register_b);


    w(0)<=instruction_register_a(0) when Ei='0' else 'Z' when Ei ='1';    
    w(1)<=instruction_register_a(1) when Ei='0' else 'Z' when Ei ='1';    
    w(2)<=instruction_register_a(2) when Ei='0' else 'Z' when Ei ='1';    
    w(3)<=instruction_register_a(3) when Ei='0' else 'Z' when Ei ='1';      

    
SAP_Accumulator : Accumulator port map(clk=>sap1_clk,clear=>CLR,bus_line=>w(7 downto 0),
control_signal_La=>La, accumulator_out => accumulator_a);
    

    --C12 three state buffer for accumulator output

    w(0)<= accumulator_a(0) when Ea = '1' else 'Z' when Ea ='0';
    w(1)<= accumulator_a(1) when Ea = '1' else 'Z' when Ea ='0';
    w(2)<= accumulator_a(2) when Ea = '1' else 'Z' when Ea ='0';
    w(3)<= accumulator_a(3) when Ea = '1' else 'Z' when Ea ='0';
    w(4)<= accumulator_a(4) when Ea = '1' else 'Z' when Ea ='0';
    w(5)<= accumulator_a(5) when Ea = '1' else 'Z' when Ea ='0';
    w(6)<= accumulator_a(6) when Ea = '1' else 'Z' when Ea ='0';            
    w(7)<= accumulator_a(7) when Ea = '1' else 'Z' when Ea ='0';
    
       
SAP_B_Register : B_Register port map(clk=>sap1_clk,clear=>CLR,control_signal_Lb=>Lb,control_signal_Su=>Su,
bus_line=>w,xor_out=>xor_out_a);     


process(instruction_register_b)
    
    begin
    
    not_instruction_register_b(0)<= not instruction_register_b(0);
    not_instruction_register_b(1)<= not instruction_register_b(1);
    not_instruction_register_b(2)<= not instruction_register_b(2);
    not_instruction_register_b(3)<= not instruction_register_b(3);
    
end process; 
   
HLT<=not(instruction_register_b(3) and instruction_register_b(2) and instruction_register_b(1) and instruction_register_b(0));


ALU : Adder_Subtractor port map(control_signal_Su=>Su,accumulator=>accumulator_a,xor_in=>xor_out_a,
sum_out=>s_out);

    
    w(0)<= s_out(0) when Eu = '1' else 'Z' when Eu ='0';
    w(1)<= s_out(1) when Eu = '1' else 'Z' when Eu ='0';
    w(2)<= s_out(2) when Eu = '1' else 'Z' when Eu ='0';
    w(3)<= s_out(3) when Eu = '1' else 'Z' when Eu ='0';
    w(4)<= s_out(4) when Eu = '1' else 'Z' when Eu ='0';
    w(5)<= s_out(5) when Eu = '1' else 'Z' when Eu ='0';
    w(6)<= s_out(6) when Eu = '1' else 'Z' when Eu ='0';
    w(7)<= s_out(7) when Eu = '1' else 'Z' when Eu ='0';

  
SAP_Ring_Counter : Ring_Counter port map (clk=>sap1_clk,clear=>ring_count_clr,reg=>ringcount);
ring_count_clr <= nop and notCLR; 


SAP_REG_OUT : Output_Reg port map (clk=>sap1_clk,clear=>CLR,control_signal_Lo=>Lo,bus_line=>w,output=>output_register);

    binary_out<=output_register;
            

end architecture;
