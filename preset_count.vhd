----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2021 02:53:57 PM
-- Design Name: 
-- Module Name: preset_count - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity preset_count is
 Port (
 clr_pr : in std_logic;
 clk_pr : in std_logic;
 Preset_count_out : out std_logic_vector(3 downto 0); 
 P : in std_logic_vector(3 downto 0);
 load : in std_logic
  );
end preset_count;

architecture Behavioral of preset_count is
  component jk_flop is 
      Port (
  
  JK_clr : in std_logic;
  PR : in std_logic;
  JK_CLK : in std_logic;
 QA: out std_logic;
 QA_not :out  std_logic;
  J : in std_logic;
  K : in std_logic
  
   );
end component;   

   
   signal  Q_out : std_logic_vector(3 downto 0);
   signal PR_0,PR_1,PR_2,PR_3,clr : std_logic;  
   signal CLR_0,CLR_1,CLR_2,CLR_3 : std_logic;  
 
begin
process(P,load,clr_pr)
begin
PR_0<=((P(0)nand load)); 
CLR_0<=((not P(0)) nand load)or not clr_pr;
PR_1<=((P(1)nand load)); 
CLR_1<=((not P(1)) nand load)or not clr_pr;
PR_2<=((P(2)nand load)); 
CLR_2<=((not P(2)) nand load)or not clr_pr;
PR_3<=((P(3)nand load)); 
CLR_3<=((not P(3)) nand load)or not clr_pr;
end process;
JK1 : jk_flop port map (QA=>Q_out(0),J=>'1',K=>'1',JK_CLK=>clk_pr,PR=>PR_0,JK_clr=>CLR_0 );
JK2 : jk_flop port map (QA=>Q_out(1),J=>'1',K=>'1',JK_CLK=>Q_out(0),PR=>PR_1,JK_clr=>CLR_1);
JK3 : jk_flop port map (QA=>Q_out(2),J=>'1',K=>'1',JK_CLK=>Q_out(1),PR=>PR_2,JK_clr=>CLR_2);
JK4 : jk_flop port map (QA=>Q_out(3),J=>'1',K=>'1',JK_CLk=>Q_out(2),PR=>PR_3,JK_clr=>CLR_3);

Preset_count_out(0)<=Q_out(0);
Preset_count_out(1)<=Q_out(1);
Preset_count_out(2)<=Q_out(2);
Preset_count_out(3)<=Q_out(3);




end Behavioral;
