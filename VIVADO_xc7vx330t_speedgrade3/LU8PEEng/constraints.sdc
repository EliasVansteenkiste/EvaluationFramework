#*******************************
# set_time_format 
#*******************************
#set_time_format -unit ns -decimal_places 3

#*******************************
# create_clock 
#*******************************
create_clock -name clk -period 40.000 [get_ports clk]

#*******************************
# set_clock_uncertainty 
#*******************************
#set_clock_uncertainty -rise_from [all_clocks] -rise_to [all_clocks]  0.0
#set_clock_uncertainty -rise_from [all_clocks] -fall_to [all_clocks]  0.0

#*******************************
# set_input_delay 
#*******************************
#set_input_delay -clock virtual_io_clock -max 0.0 [get_ports *]

#*******************************
# set_output_delay 
#*******************************
#set_output_delay -clock virtual_io_clock -max 0.0 [get_ports *]

#*******************************
# set_clock_groups 
#*******************************
#set_clock_groups -exclusive -group { clock } 
