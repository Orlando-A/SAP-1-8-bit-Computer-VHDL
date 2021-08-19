## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports basys3_clk]
set_property IOSTANDARD LVCMOS33 [get_ports basys3_clk]
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Switches

set_property PACKAGE_PIN V17 [get_ports Manual_Auto]
set_property IOSTANDARD LVCMOS33 [get_ports Manual_Auto]








set_property PACKAGE_PIN W17 [get_ports Switch2]
set_property IOSTANDARD LVCMOS33 [get_ports Switch2]

set_property PACKAGE_PIN W15 [get_ports {adress_switch[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adress_switch[0]}]
set_property PACKAGE_PIN V15 [get_ports {adress_switch[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adress_switch[1]}]
set_property PACKAGE_PIN W14 [get_ports {adress_switch[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adress_switch[2]}]
set_property PACKAGE_PIN W13 [get_ports {adress_switch[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adress_switch[3]}]




set_property PACKAGE_PIN V2 [get_ports {data_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[0]}]
set_property PACKAGE_PIN T3 [get_ports {data_in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[1]}]
set_property PACKAGE_PIN T2 [get_ports {data_in[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[2]}]
set_property PACKAGE_PIN R3 [get_ports {data_in[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[3]}]
set_property PACKAGE_PIN W2 [get_ports {data_in[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[4]}]
set_property PACKAGE_PIN U1 [get_ports {data_in[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[5]}]
set_property PACKAGE_PIN T1 [get_ports {data_in[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[6]}]
set_property PACKAGE_PIN R2 [get_ports {data_in[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[7]}]


set_property PACKAGE_PIN V16 [get_ports ce_RAM]
set_property IOSTANDARD LVCMOS33 [get_ports ce_RAM]

set_property PACKAGE_PIN W16 [get_ports read_write]
set_property IOSTANDARD LVCMOS33 [get_ports read_write]



## LEDs






#set_property PACKAGE_PIN U16 [get_ports {w[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {w[0]}]
#set_property PACKAGE_PIN E19 [get_ports {w[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {w[1]}]
#set_property PACKAGE_PIN U19 [get_ports {w[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {w[2]}]
#set_property PACKAGE_PIN V19 [get_ports {w[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {w[3]}]
#set_property PACKAGE_PIN W18 [get_ports {w[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {w[4]}]
#set_property PACKAGE_PIN U15 [get_ports {w[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {w[5]}]
#set_property PACKAGE_PIN U14 [get_ports {w[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {w[6]}]
#set_property PACKAGE_PIN V14 [get_ports {w[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {w[7]}]



#set_property PACKAGE_PIN U16 [get_ports {con_worda[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {con_worda[0]}]
#set_property PACKAGE_PIN E19 [get_ports {con_worda[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {con_worda[1]}]
#set_property PACKAGE_PIN U19 [get_ports {con_worda[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {con_worda[2]}]
#set_property PACKAGE_PIN V19 [get_ports {con_worda[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {con_worda[3]}]
#set_property PACKAGE_PIN W18 [get_ports {con_worda[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {con_worda[4]}]
#set_property PACKAGE_PIN U15 [get_ports {con_worda[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {con_worda[5]}]
#set_property PACKAGE_PIN U14 [get_ports {con_worda[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {con_worda[6]}]
#set_property PACKAGE_PIN V14 [get_ports {con_worda[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {con_worda[7]}]
#set_property PACKAGE_PIN V13 [get_ports {con_worda[8]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {con_worda[8]}]
#set_property PACKAGE_PIN V3 [get_ports {con_worda[9]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {con_worda[9]}]
#set_property PACKAGE_PIN W3 [get_ports {con_worda[10]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {con_worda[10]}]
#set_property PACKAGE_PIN U3 [get_ports {con_worda[11]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {con_worda[11]}]




set_property PACKAGE_PIN U16 [get_ports {binary_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {binary_out[0]}]
set_property PACKAGE_PIN E19 [get_ports {binary_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {binary_out[1]}]
set_property PACKAGE_PIN U19 [get_ports {binary_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {binary_out[2]}]
set_property PACKAGE_PIN V19 [get_ports {binary_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {binary_out[3]}]
set_property PACKAGE_PIN W18 [get_ports {binary_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {binary_out[4]}]
set_property PACKAGE_PIN U15 [get_ports {binary_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {binary_out[5]}]
set_property PACKAGE_PIN U14 [get_ports {binary_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {binary_out[6]}]
set_property PACKAGE_PIN V14 [get_ports {binary_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {binary_out[7]}]


set_property PACKAGE_PIN V13 [get_ports {RAM_LED[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RAM_LED[0]}]
set_property PACKAGE_PIN V3 [get_ports {RAM_LED[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RAM_LED[1]}]
set_property PACKAGE_PIN W3 [get_ports {RAM_LED[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RAM_LED[2]}]
set_property PACKAGE_PIN U3 [get_ports {RAM_LED[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RAM_LED[3]}]
set_property PACKAGE_PIN P3 [get_ports {RAM_LED[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RAM_LED[4]}]
set_property PACKAGE_PIN N3 [get_ports {RAM_LED[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RAM_LED[5]}]
set_property PACKAGE_PIN P1 [get_ports {RAM_LED[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RAM_LED[6]}]
set_property PACKAGE_PIN L1 [get_ports {RAM_LED[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RAM_LED[7]}]








##Buttons
set_property PACKAGE_PIN U18 [get_ports Start_Clear]
set_property IOSTANDARD LVCMOS33 [get_ports Start_Clear]
set_property PACKAGE_PIN T18 [get_ports Single_Step]
set_property IOSTANDARD LVCMOS33 [get_ports Single_Step]



#set_property PACKAGE_PIN A14 [get_ports t1_clr_pr]
#set_property IOSTANDARD LVCMOS33 [get_ports t1_clr_pr]
##Sch name = JB2
#set_property PACKAGE_PIN A16 [get_ports clr_in]
#set_property IOSTANDARD LVCMOS33 [get_ports clr_in ]





set_property PACKAGE_PIN W7 [get_ports {LED_out_x[6]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {LED_out_x[6]}]
        set_property PACKAGE_PIN W6 [get_ports {LED_out_x[5]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {LED_out_x[5]}]
        set_property PACKAGE_PIN U8 [get_ports {LED_out_x[4]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {LED_out_x[4]}]
        set_property PACKAGE_PIN V8 [get_ports {LED_out_x[3]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {LED_out_x[3]}]
        set_property PACKAGE_PIN U5 [get_ports {LED_out_x[2]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {LED_out_x[2]}]
        set_property PACKAGE_PIN V5 [get_ports {LED_out_x[1]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {LED_out_x[1]}]
        set_property PACKAGE_PIN U7 [get_ports {LED_out_x[0]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {LED_out_x[0]}]
        set_property PACKAGE_PIN U2 [get_ports {Anode_Activate_out[0]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate_out[0]}]
        set_property PACKAGE_PIN U4 [get_ports {Anode_Activate_out[1]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate_out[1]}]
        set_property PACKAGE_PIN V4 [get_ports {Anode_Activate_out[2]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate_out[2]}]
        set_property PACKAGE_PIN W4 [get_ports {Anode_Activate_out[3]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate_out[3]}]








##might have to bring back
create_clock -period 10.000 -name basys3_clk -waveform {0.000 5.000} [get_ports basys3_clk]
##create_generated_clock -name CLK -source [get_ports basys3_clk] -divide_by 21 [get_pins {divider_reg[21]/Q}]
##create_generated_clock -name CLK_debounce -source [get_ports basys3_clk] -divide_by 18 [get_pins {divider_reg[18]/Q}]



