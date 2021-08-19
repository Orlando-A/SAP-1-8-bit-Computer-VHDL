----------------------------------------------------------------------------------
-- Company: 
-- Student: Orlando Arriaga
-- 
-- Create Date: 01/15/2021 08:29:25 PM
-- Design Name: SAP-1 
-- Module Name: SAP-1 - Structural
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
    Anode_Activate_out : out std_logic_vector(3 downto 0);-- used to drive each of the four anodes of the number displays 
    LED_out_x : out std_logic_vector(6 downto 0);--Used to drive LED's on each number display
    RAM_LED: out std_logic_vector(7 downto 0);-- shows you the RAM contents you so you can see what you wrote in is correct
    ce_RAM: in std_logic;--When writting data into RAM, Chip Enable RAM needs to be LOW, HIGH when you are ready to run the program
    read_write: in std_logic;-- When trying to manually write data into RAM you must make a LOW to HIGH transition to actually write data into RAM
    data_in : in std_logic_vector(7 downto 0);-- input a byte of data into the RAM
    adress_switch : in std_logic_vector (3 downto 0);-- 4 bits of address data when Switch 2 is On
    Switch2 : in std_logic; -- 1= you can manually input data with data_switches and adress_switch, 0: reads adress from MAR
    binary_out : out std_logic_vector(7 downto 0):=(others => '0'); -- display output in binary
    basys3_clk  : in std_logic;  -- 100MHz clock from Basys 3 
    Start_Clear : in std_logic;  --push button to clear
    Single_Step : in std_logic;  --push button to manually step through the program, Manual_Auto has to be On
    Manual_Auto : in std_logic   -- 1 = Manual 0 = Auto 
    ); 
     
end SAP_1;


architecture structural of SAP_1 is
        
        
    signal w_bus : STD_LOGIC_VECTOR (7 downto 0);
    signal divider8 : std_logic;
    signal sap1_invclk, sap1_clk, notCLR: std_logic;
    signal program_counter_a : std_logic_vector (3 downto 0);
    signal ram_out : std_logic_vector(7 downto 0);
    signal Li,Ei,La,Ea,Eu,Su,Lb,Lm,Cp,Ep,run_prog,Lo   : std_logic;
    signal instruction_register_a : std_logic_vector(3 downto 0):=(others => '0');
    signal instruction_register_b : std_logic_vector(3 downto 0):=(others => '0');
    signal CLR,ring_count_clr,preset_clr_in : std_logic;
    signal accumulator_a : std_logic_vector(7 downto 0):=(others => '0');
    signal Cout0,Cout1,Cout2,Cout3,Cout4,Cout5,Cout6,Cout7 : std_logic;
    signal ringcount : std_logic_vector(6 downto 0):=(others => '0');
    signal not_instruction_register_b : std_logic_vector(3 downto 0):=(others => '0');
    signal LDA,ADD,SUB,HLT,nop : std_logic; 
    signal output_register : std_logic_vector(7 downto 0);
    signal addr_rom_presetcount : std_logic_vector(3 downto 0);
    signal preset_to_ctrom : std_logic_vector(3 downto 0):=(others => '0');
    signal con_word : std_logic_vector(12 downto 0);
    signal mar_out_a : std_logic_vector(3 downto 0);
    signal bcd0_out,bcd1_out,bcd2_out : std_logic_vector(3 downto 0);
    signal xor_out_a : std_logic_vector(7 downto 0);
    signal c_out : std_logic_vector(7 downto 0);
    signal s_out : std_logic_vector(7 downto 0);
    signal carry_register : std_logic_vector(3 downto 0);

    
        
component Address_Rom is 
     
    port(   
    address_out : out std_logic_vector ( 3 downto 0);
    addr_in : in std_logic_vector( 3 downto 0)
    );
    
end component;   
    
    
component Presettable_Counter_V2 is 
    
    port(
    clk : in std_logic;
    clear : in std_logic;
    word_in  : in std_logic_vector(3 downto 0);
    load : in std_logic;
    word_out : out std_logic_vector(3 downto 0)
    ); 
           
end component;

     
component Control_Rom is 

     port(
     addr_out : out std_logic_vector ( 12 downto 0);
     addr_in: in std_logic_vector( 3 downto 0)
     );
    
end component; 
     
     
component Binary_BCD is 

    generic(N: positive := 8);
    port(
    clk, reset: in std_logic;
    binary_in: in std_logic_vector(N-1 downto 0);
    bcd0, bcd1, bcd2, bcd3, bcd4: out std_logic_vector(3 downto 0)
    );
    
end component;
        
        
component Seven_Segment_Display_VHDL is
   
    Port (  
    clock_100Mhz : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
    reset : in STD_LOGIC; -- reset
    bcd0_in, bcd1_in, bcd2_in : in std_logic_vector(3 downto 0);
    Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
    LED_out : out STD_LOGIC_VECTOR (6 downto 0)
    );
  
end component;  


component Program_Counter is

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
    bus_signal : in std_logic_vector( 7 downto 0);
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
    bus_signal : in std_logic_vector(7 downto 0);
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
    count_out : out  std_logic_vector(6 downto 0)
    );
    
end component;   


component Output_Reg is

    port(
    clk : in std_logic;
    clear : in std_logic;
    control_signal_Lo : in std_logic;
    bus_signal : in std_logic_vector(7 downto 0);
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


ADDR_ROM : Address_Rom port map(addr_in=>instruction_register_b,address_out=>addr_rom_presetcount); 
--Address Rom receives instruction from the instruction register a
--Outputs the desired routine to the presettable counter  

         
Preset_Counter : Presettable_Counter_V2 port map(word_in=>addr_rom_presetcount,load=>ringcount(3),word_out=>preset_to_ctrom ,
clk=>sap1_clk,clear=>preset_clr_in);  
--Presettable counter is in charge of stepping through the respective machine cycles of each instruction
--these outputs drive the control rom. Instead of using a control matrix I use a control rom    
   
preset_clr_in <= CLR or ringcount(0);
                      
    
Control_Word_ROM : Control_Rom port map(addr_in=>preset_to_ctrom,addr_out=>con_word); 


    Cp<=con_word(11);  
    Ep<=con_word(10);
    Lm<=con_word(9);
    run_prog<=con_word(8);  --These are the control signals 
    Li<=con_word(7); 
    Ei<=con_word(6); 
    La<=con_word(5); 
    Ea<=con_word(4); 
    Su<=con_word(3);
    Eu<=con_word(2); 
    Lb<=con_word(1); 
    Lo<=con_word(0);      
    
    
nop<= not((not Cp)and(not Ep)and Lm and run_prog and Li and Ei and La and (not Ea) and (not Su) and (not Eu) and Lb and Lo);
--no operation(nop) to reduce the machine cycle of LDA and OUT instructions
--if nop is detected the ringcounter is cleared

            
BCD : Binary_BCD port map(clk=>divider8,reset=>CLR,binary_in=>output_register,bcd0=>bcd0_out,bcd1=>bcd1_out, bcd2=>bcd2_out);
--converts our binary to binary coded decimal (bcd)     

     
Dispay_Control : Seven_Segment_Display_VHDL port map (clock_100Mhz=>basys3_clk,reset=>CLR,bcd0_in=>bcd0_out,bcd1_in=>bcd1_out,
bcd2_in=>bcd2_out,Anode_Activate=>Anode_Activate_out,LED_out=>LED_out_x);     
--takes our bcd and displays it on the basys 3 display


SAP1_CLK_Module : Clock_Module port map (divider_out_8=>divider8,clk=>basys3_clk,hlt_in=>hlt,
control_signal_start=>Start_Clear,notCLR_out=>notCLR,clr_out=>clr,control_signal_single=>Single_Step,
control_signal_manual=>Manual_Auto,sap1_clk_out=>sap1_clk,sap1_invclk_out=>sap1_invclk);
--takes the basys 3 clock and divides it down to a lower frequency
--also gives us the ability to use manual or auto control
 

    
  
Program_Count : Program_Counter port map(clk=>sap1_invclk,control_signal_Cp=>Cp,clr=>notCLR,program_counter_out=>program_counter_a); 
--counter points to each memory address in our ram       
            
    w_bus(0)<= program_counter_a(0) when Ep='1' else 'Z' when Ep ='0';
    w_bus(1)<= program_counter_a(1) when Ep='1' else 'Z' when Ep ='0';
    w_bus(2)<= program_counter_a(2) when Ep='1' else 'Z' when Ep ='0';     --three state buffers for the program counter
    w_bus(3)<= program_counter_a(3) when Ep='1' else 'Z' when Ep ='0';
            
                      
Mar_Module : MAR port map(clk=>sap1_clk, clr=>CLR, control_signal_Lm=>Lm,bus_line=>w_bus(3 downto 0),mar_out=>mar_out_a);      
--takes the count from the program_counter and feeds it to RAM            

 
RAM_module : RAM port map(switch_in=>Switch2,address_switch_in=>adress_switch,ce_RAM_in=>ce_RAM,read_write_in=>read_write,
ram_out_a=>ram_out,run_prog_in=>run_prog,data_input=>data_in,mar_out_b=>mar_out_a);
--Holds our program that we decide to input
  
    w_bus(0)<=ram_out(0) when run_prog ='0' else 'Z' when run_prog ='1'; 
    w_bus(1)<=ram_out(1) when run_prog ='0' else 'Z' when run_prog ='1';
    w_bus(2)<=ram_out(2) when run_prog ='0' else 'Z' when run_prog ='1';
    w_bus(3)<=ram_out(3) when run_prog ='0' else 'Z' when run_prog ='1';
    w_bus(4)<=ram_out(4) when run_prog ='0' else 'Z' when run_prog ='1';
    w_bus(5)<=ram_out(5) when run_prog ='0' else 'Z' when run_prog ='1';
    w_bus(6)<=ram_out(6) when run_prog ='0' else 'Z' when run_prog ='1';
    w_bus(7)<=ram_out(7) when run_prog ='0' else 'Z' when run_prog ='1';
 
   

RAM_LED(7 downto 0)<=ram_out(7 downto 0);--lights up leds, this shows us the contents of ram_out  
--this is so we can see what we input into the ram when we program the computer
--lights up lED's on basys 3    
 
   
SAP_Instruction_Registers : Instruction_Register port map(clk=>sap1_clk, clear=>CLR, bus_signal=>w_bus(7 downto 0),
control_signal_Li=>Li,register_a=>instruction_register_a, register_b=>instruction_register_b);
--splits up the ram word into 2 parts, the first word holds the instruction which goes to the address rom
--the second nibble holds the address location such as LDA 9A, 9A would be the address location 
--to load that value from

    w_bus(0)<=instruction_register_a(0) when Ei='0' else 'Z' when Ei ='1';    
    w_bus(1)<=instruction_register_a(1) when Ei='0' else 'Z' when Ei ='1';    
    w_bus(2)<=instruction_register_a(2) when Ei='0' else 'Z' when Ei ='1';    
    w_bus(3)<=instruction_register_a(3) when Ei='0' else 'Z' when Ei ='1';      

    
SAP_Accumulator : Accumulator port map(clk=>sap1_clk,clear=>CLR,bus_signal=>w_bus(7 downto 0),
control_signal_La=>La, accumulator_out => accumulator_a);
--Provides a way of storing a computation momentarly     

    w_bus(0)<= accumulator_a(0) when Ea = '1' else 'Z' when Ea ='0';
    w_bus(1)<= accumulator_a(1) when Ea = '1' else 'Z' when Ea ='0';
    w_bus(2)<= accumulator_a(2) when Ea = '1' else 'Z' when Ea ='0';
    w_bus(3)<= accumulator_a(3) when Ea = '1' else 'Z' when Ea ='0';
    w_bus(4)<= accumulator_a(4) when Ea = '1' else 'Z' when Ea ='0';
    w_bus(5)<= accumulator_a(5) when Ea = '1' else 'Z' when Ea ='0';
    w_bus(6)<= accumulator_a(6) when Ea = '1' else 'Z' when Ea ='0';            
    w_bus(7)<= accumulator_a(7) when Ea = '1' else 'Z' when Ea ='0';
    
       
SAP_B_Register : B_Register port map(clk=>sap1_clk,clear=>CLR,control_signal_Lb=>Lb,control_signal_Su=>Su,
bus_signal=>w_bus,xor_out=>xor_out_a);     
--loads the second number to be added/subtracted to the adder/subtractor

process(instruction_register_b)
    
    begin
    
    not_instruction_register_b(0)<= not instruction_register_b(0);
    not_instruction_register_b(1)<= not instruction_register_b(1);
    not_instruction_register_b(2)<= not instruction_register_b(2);
    not_instruction_register_b(3)<= not instruction_register_b(3);
    
end process; 
   
HLT<=not(instruction_register_b(3) and instruction_register_b(2) and instruction_register_b(1) and instruction_register_b(0));
--Halt signal goes to the clock module to stop the clock after the program ends


ALU : Adder_Subtractor port map(control_signal_Su=>Su,accumulator=>accumulator_a,xor_in=>xor_out_a,
sum_out=>s_out);
--adds/subtracts contents from Accumulator and B register
    
    w_bus(0)<= s_out(0) when Eu = '1' else 'Z' when Eu ='0';
    w_bus(1)<= s_out(1) when Eu = '1' else 'Z' when Eu ='0';
    w_bus(2)<= s_out(2) when Eu = '1' else 'Z' when Eu ='0';
    w_bus(3)<= s_out(3) when Eu = '1' else 'Z' when Eu ='0';
    w_bus(4)<= s_out(4) when Eu = '1' else 'Z' when Eu ='0';
    w_bus(5)<= s_out(5) when Eu = '1' else 'Z' when Eu ='0';
    w_bus(6)<= s_out(6) when Eu = '1' else 'Z' when Eu ='0';
    w_bus(7)<= s_out(7) when Eu = '1' else 'Z' when Eu ='0';

  
SAP_Ring_Counter : Ring_Counter port map (clk=>sap1_clk,clear=>ring_count_clr,count_out=>ringcount);
ring_count_clr <= nop and notCLR; 
--provides essential timing signals to the preset counter  


SAP_REG_OUT : Output_Reg port map (clk=>sap1_clk,clear=>CLR,control_signal_Lo=>Lo,bus_signal=>w_bus,output=>output_register);
--after executing the instruction OUT, the contents of the Accumulator are put into
--the output register, to be turned into BCD for the display
binary_out<=output_register;
--I also display the output in binary cause why not :)

            

end architecture;
