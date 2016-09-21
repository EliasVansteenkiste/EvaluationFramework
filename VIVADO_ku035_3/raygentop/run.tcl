set design vtr_raygentop

set Part xcku035-ffva1156-3-e
set part xcku035-ffva1156-3-e
set xst 0
set sd 0
set tclscr 0

set XDC "./constraints.sdc"
set xdc "./constraints.sdc"

device_enable -enable $part
set_param edifin.autoFunnelFilterName "NO_FILTER"
set_param edifin.supportNgd2Edif yes

create_project -force -part $part $design .


read_verilog -library  work  "raygentop.v"
read_verilog -library work -sv "LPM_xilinx_lib.sv"

set TopModule paj_raygentop_hierarchy_no_mem
set_property top $TopModule [current_fileset] 

set lutSize 6
set_property design_mode GateLvl [get_property srcset [current_run]]
if {$sd != 0} {
   add_files ${sd}
}
set_property part $part [get_runs impl_1]
set_property target_part $part [get_filesets constrs_1]
set_property name floorplan_1 [get_filesets constrs_1]
set_property part $part [get_runs]
set_property target_part $part [get_filesets floorplan_1]
read_xdc $xdc
set_param project.keepTmpDir true
set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]


#### TOPOLOGY EXTRACTION ####
# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ; rt::set_parameter writeInferredModules true; rt::set_parameter writeDot 1; set rt::writeStepNetlist 1"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]

# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ; rt::set_parameter requiredTimeOffset 8"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]

# To force uniquification before technology mapping, uncomment the following:
# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ; rt::set_parameter spdUseTA false"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]

# Do not extract genomes: work on the whole netlist
# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ;set rt::extractNetlistGenomes false"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]

# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ; rt::set_parameter collapseLuts false; rt::set_parameter declone false"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]
# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ;rt::set_parameter inferMuxPart false; rt::set_parameter inferRom false"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]

# To disable MUX7 and MUX8 mapping
# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ; rt::set_parameter enableMuxfMapping false"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]

# To Flatten the netlist before tech mapping
# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ; set rt::flattenBeforeLutMap 1"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]

# Dump verilog checkpoints before/after LUT mapping for formal verification
# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ; rt::set_parameter dumpNetlistDuringLutMap true"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]

# To enable Oasys timing engine in tech mapper
# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ; rt::set_parameter mapUseTimer true"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]

# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ; rt::set_parameter combineLutsPostRebuildHierarchy false"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]

# To disable XOR optimization
# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ;set rt::nl_opt_flow 8"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]

# To disable LUT->reg filtering during LUTNM creation
# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ; rt::set_parameter combineLutsLutRegisterCheck2 false"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]

# To disable synthesis fork() calls for area optimization
# set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ;set rt::doParallel false"
# set oldMoreOptions [get_param synth.elaboration.rodinMoreOptions]


set_param synth.elaboration.rodinMoreOptions "$oldMoreOptions ; rt::disable_message PARAM-100; rt::set_parameter setMaxThresholdToInfinity   true;set rt::writeDbgNetlist 1; rt::set_parameter maxClockBufferCount 32; rt::set_parameter optVerbose 1 ; catch {rt::set_parameter reportCommandRuntime true } ; catch { rt::set_parameter preserveInstanceWithDontTouch false } ; rt::enable_message PARAM-100 ; rt::set_parameter lutSize $lutSize ; "
set_param drc.showSeverity "Critical Warning"
set_param tcl.statsThreshold 0
set_param route.msgVerbose 1
catch { set_param netlist.allowChecksum 1 }
catch { set_param route.promoteErrors 1 }
catch { set_param write_ncd.noDrc true }
catch { set_param  power.useResetDefaultRate 1 }
catch { set_param cg.skipHiddenCheck true }
catch { set_param logicopt.upgradeWarningsToErrors 1 }
catch { set_param drc.ruleSeverityCfg /proj/fisdata/fisusr/sandboxes/ABE/ListFiles/bin/adjustSeverity.cfg }

#increase Slice density
# set_param arch.place.numLutUpScale 1.0
# set_param place.evalarch.lateCascadeClustering 0
# set_param place.evalarch.criticality 150
# set_param arch.place.skipPostOpt true
# set_param arch.place.finishAtEarlyDP true
# set_param place.maxThreads 1

# To activate the old placer
# set_param place.runNextGen 0

# Disable LUTNM shape creation
# set_param placedata.supportLUTNM false

#set_param place.lmDisableEarlyTermination true
#set_param place.lmMinBloatForFuji 1
#set_param place.LutFFBloatDisolve 1
#set_param place.enableLutPinSwapping false
#set_param place.exitAfterLM yes
#set_param place.debugShape shape.txt
#end of placer parameters for cascade of LUTs

####### end of router parameters for cascade of LUTs

if {$tclscr != 0} {
   source $tclscr
}

set_param place.oldMsgVerbose 1
set_param route.oldMsgVerbose 1
catch { set_param place.noDrc true }
catch { set_param route.promoteErrors 1 }
catch { set_param logicopt.deleteEmptyHierWithDontTouch 1 }
if {$xst != 0} {
   import_xst $xst
}

synth_design -part $Part -mode out_of_context
# synth_design -part $Part -flatten_hierarchy full
# write_edif design.edf
write_checkpoint -force postSynth.dcp
catch { report_timing -delay_type min -max_paths 10 -sort_by group -input_pins -file postlogopt_timing_min.rpt }
catch { report_timing -delay_type max -max_paths 10 -sort_by group -input_pins -file postlogopt_timing_max.rpt }

# dump the slice count, for v7, clbcount will get an empty string.
set util [report_utilization -return_string]
if [regexp {\| CLB                 \s+\|\s+(\d+)} $util -> clbcount] {
  puts "PMINFO-> #CLB usage $clbcount"
}

place_design -no_drc
write_checkpoint -force postPlace.dcp
report_timing -file postPlace.timing.rpt
catch { report_timing -delay_type min -max_paths 10 -sort_by group -input_pins -file postplace_timing_min.rpt }
catch { report_timing -delay_type max -max_paths 10 -sort_by group -input_pins -file postplace_timing_max.rpt }
# dump the slice count
# for v7, clbcount will get an empty string.
set util [report_utilization -return_string]
if [regexp {\| CLB                 \s+\|\s+(\d+)} $util -> clbcount] {
  puts "PMINFO-> #CLB usage $clbcount"
}

set_param -name route.flowDbg -value 1
set_param -name route.timingDbg -value 1
set_param route.msgVerbose 1
set_param route.promoteErrors 1
set_param route.oldMsgVerbose 1

route_design -rtfile "route.output.txt"
write_checkpoint -force postRoute.dcp
report_timing -file postRoute.timing.rpt
catch { report_timing -delay_type min -max_paths 10 -sort_by group -input_pins -file postroute_timing_min.rpt }
catch { report_timing -delay_type max -max_paths 10 -sort_by group -input_pins -file postroute_timing_max.rpt }

report_utilization -file postRoute.utilization.rpt

set ff [open done.log w]
puts $ff done
close $ff
#exec /group/zircon/zircon/bin/roanal > roanal.txt
quit
