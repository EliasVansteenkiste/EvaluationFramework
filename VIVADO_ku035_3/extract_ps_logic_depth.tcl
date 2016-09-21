#######################################################################
if { [file exists postRoute.dcp] == 1} {

open_checkpoint postSynth.dcp

puts "Start Analysis:"
puts "Analyzing all endpoints..."

set worstList [get_timing_paths -delay_type max -max_paths 100000 -nworst 1 -no_report_unconstrained -sort_by group]

foreach path $worstList {
        set outPin  [get_property  ENDPOINT_PIN   $path]
        set logic_levels  [get_property  LOGIC_LEVELS   $path]
        set group  [get_property  GROUP   $path]
        set slack  [get_property  SLACK   $path]
        set class  [get_property  CLASS   $path]
        puts "--------------------------------------------------------------------------"    
        puts "EVDEBUG -> Path info: outPin $outPin | logic_levels $logic_levels | group $group | slack $slack | class $class "
        puts "--------------------------------------------------------------------------"
        set cells_path [get_cells -of_objects $path]
	puts -nonewline "EVDEBUG -> cellsinpath " 
        foreach cell $cells_path {
		puts -nonewline "$cell - "
	}
        puts ""
	puts -nonewline "EVDEBUG -> typesinpath "
        foreach cell $cells_path {
		set celltype [get_property TYPE $cell]
		puts -nonewline "$celltype - "
	}
        puts ""
        puts "-----------------------------------------------------------"
}
########################################################################################
}
quit
