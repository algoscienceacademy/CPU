#================================================================================
# Ci9 CPU Synthesis Script - Clean Version
#================================================================================

puts "=============================================================================="
puts "Ci9 CPU Synthesis - Clean Version"
puts "=============================================================================="

# Read RTL design
puts "Reading RTL design..."
if {[catch {read_hdl -v2001 ../rtl/Ci9.v} result]} {
    puts "ERROR: Could not read RTL file: $result"
    exit
} else {
    puts "Successfully read RTL design"
}

# Set standard cell library
puts "Setting standard cell library..."
if {[catch {set_attribute library ../library/stdcells.lib /} result]} {
    puts "ERROR: Could not set library: $result"
    exit
} else {
    puts "Successfully set library"
}

# Elaborate design
puts "Elaborating design..."
if {[catch {elaborate Ci9} result]} {
    puts "ERROR: Could not elaborate design: $result"
    exit
} else {
    puts "Successfully elaborated design"
}

# Synthesize to generic
puts "Synthesizing to generic..."
if {[catch {synthesize -to_generic} result]} {
    puts "ERROR: Generic synthesis failed: $result"
    exit
} else {
    puts "Successfully completed generic synthesis"
}

# Synthesize to mapped
puts "Synthesizing to mapped..."
if {[catch {synthesize -to_mapped} result]} {
    puts "ERROR: Technology mapping failed: $result"
    exit
} else {
    puts "Successfully completed technology mapping"
}

# Write outputs
puts "Writing output files..."
exec mkdir -p ../netlist

if {[catch {write_hdl > ../netlist/Ci9_netlist.v} result]} {
    puts "WARNING: Could not write netlist: $result"
} else {
    puts "Successfully wrote netlist"
}

if {[catch {write_sdf > ../netlist/Ci9_netlist.sdf} result]} {
    puts "WARNING: Could not write SDF: $result"
} else {
    puts "Successfully wrote SDF"
}

puts "=============================================================================="
puts "Ci9 CPU synthesis completed successfully!"
puts "=============================================================================="