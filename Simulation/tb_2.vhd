--
--To make sure you see the whole operation of the computer, make sure that the simulation runs



--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_2 is

end tb_2;

    
architecture testbench of tb_2 is
  
    
signal Anode_Activate_out_tb : std_logic_vector(3 downto 0);
signal LED_out_x_tb : std_logic_vector(6 downto 0);
signal RAM_LED_tb : std_logic_vector(7 downto 0);
signal ce_RAM_tb : std_logic;
signal read_write_tb : std_logic;
signal data_in_tb : std_logic_vector(7 downto 0);
signal adress_switch_tb : std_logic_vector (3 downto 0);
signal Switch2_tb : std_logic;
signal binary_out_tb : std_logic_vector(7 downto 0):=(others => '0');
signal basys3_clk_tb  : std_logic :='0';
signal Start_Clear_tb : std_logic :='0'; --pushbutton
signal Single_Step_tb : std_logic;  --pushbutton
signal Manual_Auto_tb : std_logic;
constant clk_period: time := 10 ns;
    
    
    component SAP_1 is
    
        port( 
     
 
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
      
    end component;

        
begin

       UUT : SAP_1 port map (
     
                          Anode_Activate_out=>Anode_Activate_out_tb,
                          LED_out_x=>LED_out_x_tb,
                          RAM_LED=>RAM_LED_tb,
                          ce_RAM=>ce_RAM_tb,
                          read_write=>read_write_tb,
                          data_in=>data_in_tb,                    --connecting our test bench signals to our Unit Under Test SAP_1
                          adress_switch=>adress_switch_tb,                     
                          Switch2=>Switch2_tb,
                          binary_out=>binary_out_tb,
                          basys3_clk=>basys3_clk_tb,
                          Start_Clear=>Start_Clear_tb,
                          Single_Step=>Single_Step_tb,
                          Manual_Auto=>Manual_Auto_tb
                          );
     --simulation to add 16 + 20 in SAP_1

clock: process
    begin

     basys3_clk_tb <= '0';
     wait for clk_period/2;     --simulates clock
     basys3_clk_tb <= '1';
     wait for clk_period/2;
 
 end process; 






    STIM : process
    begin 
    Start_Clear_tb <= '1'; wait for 50 ns;
    Start_Clear_tb<= '0'; wait for 50 ns; 
    Manual_Auto_tb <= '1'; wait for 50 ns;
    Start_Clear_tb <= '1'; wait for 50 ns;     --Getting ready to start programming 
    Start_Clear_tb<= '0'; wait for 50 ns; 
    ce_RAM_tb<='0'; wait for 50 ns;
    Switch2_tb<='1';wait for 50 ns;
    read_write_tb<='1';wait for 50 ns; 
    
    adress_switch_tb<="0000";wait for 50 ns;
    data_in_tb<="00001001";wait for 50 ns;    -- LDA 9H
    read_write_tb<='0';wait for 50 ns;
    read_write_tb<='1';wait for 50 ns;
    
    adress_switch_tb<="0001";wait for 50 ns;
    data_in_tb<="00011010";wait for 50 ns;    -- ADD AH
    read_write_tb<='0';wait for 50 ns;
    read_write_tb<='1';wait for 50 ns;
    
    adress_switch_tb<="0010";wait for 50 ns;
    data_in_tb<="11100000";wait for 50 ns;
    read_write_tb<='0';wait for 50 ns;         -- OUT
    read_write_tb<='1';wait for 50 ns;
    
    adress_switch_tb<="0011";wait for 50 ns;
    data_in_tb<="11110000";wait for 50 ns;   -- HLT 
    read_write_tb<='0';wait for 50 ns;
    read_write_tb<='1';wait for 50 ns;
    
    adress_switch_tb<="1001";wait for 50 ns;
    data_in_tb<="00010000";wait for 50 ns;    --writting 16 decimal into adress 9H
    read_write_tb<='0';wait for 50 ns;
    read_write_tb<='1';wait for 50 ns;     
    
    adress_switch_tb<="1010";wait for 50 ns;
    data_in_tb<="00010100";wait for 50 ns;    -- programming 20 decimal into adress
    read_write_tb<='0';wait for 50 ns;
    read_write_tb<='1';wait for 50 ns;    
    
    Switch2_tb<='0';wait for 50 ns;
    ce_RAM_tb<='1'; wait for 50 ns;
    Start_Clear_tb <= '1'; wait for 50 ns; --getting ready 
    Start_Clear_tb <= '0'; wait for 50 ns;
    Manual_Auto_tb <= '0'; wait for 50 ns;
 
   
    
  
        
  
 wait;   
    end process;





end testbench;
