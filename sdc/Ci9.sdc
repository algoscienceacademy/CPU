# ================================================================
# Intel Core i9 CPU Clone - Synopsys Design Constraints (SDC)
# Timing and Optimization Constraints
# File: Ci9.sdc
# ================================================================

# Design Information
set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA

# Operating Conditions
set_operating_conditions -max ss_1p08v_125c -min ff_1p32v_m40c

# Design Rule Constraints
set_max_transition 0.15 [current_design]
set_max_capacitance 0.5 [current_design]
set_max_fanout 16 [current_design]

# ================================================================
# Clock Definitions - High Performance CPU Clocking
# ================================================================

# Primary System Clock - 3.5GHz Base Frequency (Core i9 class)
create_clock -name sys_clk -period 0.286 -waveform {0 0.143} [get_ports clk]
set_clock_uncertainty 0.020 [get_clocks sys_clk]
set_clock_transition 0.050 [get_clocks sys_clk]

# Clock Latency (including PLL and distribution)
set_clock_latency -source -max 0.200 [get_clocks sys_clk]
set_clock_latency -source -min 0.150 [get_clocks sys_clk]
set_clock_latency -max 0.100 [get_clocks sys_clk]
set_clock_latency -min 0.080 [get_clocks sys_clk]

# Virtual clocks for I/O timing
create_clock -name vclk_input -period 0.286
create_clock -name vclk_output -period 0.286

# ================================================================
# Reset Constraints
# ================================================================

set_false_path -from [get_ports rst_n]
set_input_delay 0.0 -clock sys_clk [get_ports rst_n]

# ================================================================
# Input Delay Constraints - Memory and Cache Interfaces
# ================================================================

# Memory Interface Timing (DDR4-3200 Compatible)
set mem_input_delay_max 0.125
set mem_input_delay_min 0.075

set_input_delay -clock vclk_input -max $mem_input_delay_max [get_ports mem_data_in*]
set_input_delay -clock vclk_input -min $mem_input_delay_min [get_ports mem_data_in*]
set_input_delay -clock vclk_input -max $mem_input_delay_max [get_ports mem_ready]
set_input_delay -clock vclk_input -min $mem_input_delay_min [get_ports mem_ready]

# L1 Instruction Cache Interface
set_input_delay -clock vclk_input -max 0.100 [get_ports icache_data_in*]
set_input_delay -clock vclk_input -min 0.050 [get_ports icache_data_in*]
set_input_delay -clock vclk_input -max 0.080 [get_ports icache_hit]
set_input_delay -clock vclk_input -min 0.040 [get_ports icache_hit]
set_input_delay -clock vclk_input -max 0.080 [get_ports icache_miss]
set_input_delay -clock vclk_input -min 0.040 [get_ports icache_miss]

# L1 Data Cache Interface
set_input_delay -clock vclk_input -max 0.100 [get_ports dcache_data_in*]
set_input_delay -clock vclk_input -min 0.050 [get_ports dcache_data_in*]
set_input_delay -clock vclk_input -max 0.080 [get_ports dcache_hit]
set_input_delay -clock vclk_input -min 0.040 [get_ports dcache_hit]
set_input_delay -clock vclk_input -max 0.080 [get_ports dcache_miss]
set_input_delay -clock vclk_input -min 0.040 [get_ports dcache_miss]

# L2 Cache Interface
set_input_delay -clock vclk_input -max 0.120 [get_ports l2cache_data_in*]
set_input_delay -clock vclk_input -min 0.060 [get_ports l2cache_data_in*]
set_input_delay -clock vclk_input -max 0.100 [get_ports l2cache_hit]
set_input_delay -clock vclk_input -min 0.050 [get_ports l2cache_hit]

# L3 Cache Interface
set_input_delay -clock vclk_input -max 0.150 [get_ports l3cache_data_in*]
set_input_delay -clock vclk_input -min 0.075 [get_ports l3cache_data_in*]
set_input_delay -clock vclk_input -max 0.120 [get_ports l3cache_hit]
set_input_delay -clock vclk_input -min 0.060 [get_ports l3cache_hit]

# Interrupt Interface
set_input_delay -clock vclk_input -max 0.200 [get_ports irq*]
set_input_delay -clock vclk_input -min 0.100 [get_ports irq*]
set_input_delay -clock vclk_input -max 0.150 [get_ports nmi]
set_input_delay -clock vclk_input -min 0.075 [get_ports nmi]

# System Control Inputs
set_input_delay -clock vclk_input -max 0.250 [get_ports debug_mode]
set_input_delay -clock vclk_input -min 0.125 [get_ports debug_mode]
set_input_delay -clock vclk_input -max 0.250 [get_ports single_step]
set_input_delay -clock vclk_input -min 0.125 [get_ports single_step]
set_input_delay -clock vclk_input -max 0.200 [get_ports breakpoint*]
set_input_delay -clock vclk_input -min 0.100 [get_ports breakpoint*]

# Power Management Inputs
set_input_delay -clock vclk_input -max 0.500 [get_ports pwr_good]
set_input_delay -clock vclk_input -min 0.250 [get_ports pwr_good]
set_input_delay -clock vclk_input -max 0.500 [get_ports voltage_ok]
set_input_delay -clock vclk_input -min 0.250 [get_ports voltage_ok]
set_input_delay -clock vclk_input -max 0.500 [get_ports temp_ok]
set_input_delay -clock vclk_input -min 0.250 [get_ports temp_ok]

# Test Interface
set_input_delay -clock vclk_input -max 1.000 [get_ports scan_enable]
set_input_delay -clock vclk_input -min 0.500 [get_ports scan_enable]
set_input_delay -clock vclk_input -max 1.000 [get_ports scan_in]
set_input_delay -clock vclk_input -min 0.500 [get_ports scan_in]
set_input_delay -clock vclk_input -max 1.000 [get_ports test_mode]
set_input_delay -clock vclk_input -min 0.500 [get_ports test_mode]

# JTAG Interface (typically slower)
set_input_delay -clock vclk_input -max 5.000 [get_ports jtag_tck]
set_input_delay -clock vclk_input -min 2.500 [get_ports jtag_tck]
set_input_delay -clock vclk_input -max 5.000 [get_ports jtag_tms]
set_input_delay -clock vclk_input -min 2.500 [get_ports jtag_tms]
set_input_delay -clock vclk_input -max 5.000 [get_ports jtag_tdi]
set_input_delay -clock vclk_input -min 2.500 [get_ports jtag_tdi]

# Feature Control Inputs
set_input_delay -clock vclk_input -max 0.500 [get_ports speculation_enable]
set_input_delay -clock vclk_input -min 0.250 [get_ports speculation_enable]
set_input_delay -clock vclk_input -max 0.500 [get_ports branch_prediction_enable]
set_input_delay -clock vclk_input -min 0.250 [get_ports branch_prediction_enable]
set_input_delay -clock vclk_input -max 0.500 [get_ports out_of_order_enable]
set_input_delay -clock vclk_input -min 0.250 [get_ports out_of_order_enable]
set_input_delay -clock vclk_input -max 0.500 [get_ports hyperthreading_enable]
set_input_delay -clock vclk_input -min 0.250 [get_ports hyperthreading_enable]

# Core Identification
set_input_delay -clock vclk_input -max 0.500 [get_ports core_id*]
set_input_delay -clock vclk_input -min 0.250 [get_ports core_id*]
set_input_delay -clock vclk_input -max 0.500 [get_ports thread_id*]
set_input_delay -clock vclk_input -min 0.250 [get_ports thread_id*]

# ================================================================
# Output Delay Constraints
# ================================================================

# Memory Interface Outputs
set mem_output_delay_max 0.150
set mem_output_delay_min 0.075

set_output_delay -clock vclk_output -max $mem_output_delay_max [get_ports mem_addr*]
set_output_delay -clock vclk_output -min $mem_output_delay_min [get_ports mem_addr*]
set_output_delay -clock vclk_output -max $mem_output_delay_max [get_ports mem_data_out*]
set_output_delay -clock vclk_output -min $mem_output_delay_min [get_ports mem_data_out*]
set_output_delay -clock vclk_output -max $mem_output_delay_max [get_ports mem_data_oe]
set_output_delay -clock vclk_output -min $mem_output_delay_min [get_ports mem_data_oe]
set_output_delay -clock vclk_output -max $mem_output_delay_max [get_ports mem_we]
set_output_delay -clock vclk_output -min $mem_output_delay_min [get_ports mem_we]
set_output_delay -clock vclk_output -max $mem_output_delay_max [get_ports mem_re]
set_output_delay -clock vclk_output -min $mem_output_delay_min [get_ports mem_re]
set_output_delay -clock vclk_output -max $mem_output_delay_max [get_ports mem_be*]
set_output_delay -clock vclk_output -min $mem_output_delay_min [get_ports mem_be*]
set_output_delay -clock vclk_output -max $mem_output_delay_max [get_ports mem_valid]
set_output_delay -clock vclk_output -min $mem_output_delay_min [get_ports mem_valid]

# Cache Interface Outputs
set_output_delay -clock vclk_output -max 0.100 [get_ports icache_addr*]
set_output_delay -clock vclk_output -min 0.050 [get_ports icache_addr*]
set_output_delay -clock vclk_output -max 0.080 [get_ports icache_req]
set_output_delay -clock vclk_output -min 0.040 [get_ports icache_req]

set_output_delay -clock vclk_output -max 0.100 [get_ports dcache_addr*]
set_output_delay -clock vclk_output -min 0.050 [get_ports dcache_addr*]
set_output_delay -clock vclk_output -max 0.100 [get_ports dcache_data_out*]
set_output_delay -clock vclk_output -min 0.050 [get_ports dcache_data_out*]
set_output_delay -clock vclk_output -max 0.080 [get_ports dcache_data_oe]
set_output_delay -clock vclk_output -min 0.040 [get_ports dcache_data_oe]
set_output_delay -clock vclk_output -max 0.080 [get_ports dcache_we]
set_output_delay -clock vclk_output -min 0.040 [get_ports dcache_we]
set_output_delay -clock vclk_output -max 0.080 [get_ports dcache_re]
set_output_delay -clock vclk_output -min 0.040 [get_ports dcache_re]
set_output_delay -clock vclk_output -max 0.080 [get_ports dcache_req]
set_output_delay -clock vclk_output -min 0.040 [get_ports dcache_req]

# L2 Cache Outputs
set_output_delay -clock vclk_output -max 0.120 [get_ports l2cache_addr*]
set_output_delay -clock vclk_output -min 0.060 [get_ports l2cache_addr*]
set_output_delay -clock vclk_output -max 0.120 [get_ports l2cache_data_out*]
set_output_delay -clock vclk_output -min 0.060 [get_ports l2cache_data_out*]
set_output_delay -clock vclk_output -max 0.100 [get_ports l2cache_we]
set_output_delay -clock vclk_output -min 0.050 [get_ports l2cache_we]
set_output_delay -clock vclk_output -max 0.100 [get_ports l2cache_re]
set_output_delay -clock vclk_output -min 0.050 [get_ports l2cache_re]
set_output_delay -clock vclk_output -max 0.100 [get_ports l2cache_req]
set_output_delay -clock vclk_output -min 0.050 [get_ports l2cache_req]
set_output_delay -clock vclk_output -max 0.100 [get_ports l2cache_data_oe]
set_output_delay -clock vclk_output -min 0.050 [get_ports l2cache_data_oe]

# L3 Cache Outputs
set_output_delay -clock vclk_output -max 0.150 [get_ports l3cache_addr*]
set_output_delay -clock vclk_output -min 0.075 [get_ports l3cache_addr*]
set_output_delay -clock vclk_output -max 0.150 [get_ports l3cache_data_out*]
set_output_delay -clock vclk_output -min 0.075 [get_ports l3cache_data_out*]
set_output_delay -clock vclk_output -max 0.120 [get_ports l3cache_we]
set_output_delay -clock vclk_output -min 0.060 [get_ports l3cache_we]
set_output_delay -clock vclk_output -max 0.120 [get_ports l3cache_re]
set_output_delay -clock vclk_output -min 0.060 [get_ports l3cache_re]
set_output_delay -clock vclk_output -max 0.120 [get_ports l3cache_req]
set_output_delay -clock vclk_output -min 0.060 [get_ports l3cache_req]
set_output_delay -clock vclk_output -max 0.120 [get_ports l3cache_data_oe]
set_output_delay -clock vclk_output -min 0.060 [get_ports l3cache_data_oe]

# Interrupt Outputs
set_output_delay -clock vclk_output -max 0.200 [get_ports irq_ack]
set_output_delay -clock vclk_output -min 0.100 [get_ports irq_ack]
set_output_delay -clock vclk_output -max 0.200 [get_ports irq_vector*]
set_output_delay -clock vclk_output -min 0.100 [get_ports irq_vector*]

# System Status Outputs
set_output_delay -clock vclk_output -max 0.300 [get_ports halt]
set_output_delay -clock vclk_output -min 0.150 [get_ports halt]

# Performance Counter Outputs
set_output_delay -clock vclk_output -max 0.400 [get_ports perf_counter_0*]
set_output_delay -clock vclk_output -min 0.200 [get_ports perf_counter_0*]
set_output_delay -clock vclk_output -max 0.400 [get_ports perf_counter_1*]
set_output_delay -clock vclk_output -min 0.200 [get_ports perf_counter_1*]
set_output_delay -clock vclk_output -max 0.400 [get_ports perf_counter_2*]
set_output_delay -clock vclk_output -min 0.200 [get_ports perf_counter_2*]
set_output_delay -clock vclk_output -max 0.400 [get_ports perf_counter_3*]
set_output_delay -clock vclk_output -min 0.200 [get_ports perf_counter_3*]

# Power Management Outputs
set_output_delay -clock vclk_output -max 1.000 [get_ports cpu_sleep]
set_output_delay -clock vclk_output -min 0.500 [get_ports cpu_sleep]
set_output_delay -clock vclk_output -max 1.000 [get_ports cpu_active]
set_output_delay -clock vclk_output -min 0.500 [get_ports cpu_active]

# Test Outputs
set_output_delay -clock vclk_output -max 2.000 [get_ports scan_out]
set_output_delay -clock vclk_output -min 1.000 [get_ports scan_out]
set_output_delay -clock vclk_output -max 10.000 [get_ports jtag_tdo]
set_output_delay -clock vclk_output -min 5.000 [get_ports jtag_tdo]

# Status Outputs
set_output_delay -clock vclk_output -max 0.300 [get_ports execution_state*]
set_output_delay -clock vclk_output -min 0.150 [get_ports execution_state*]
set_output_delay -clock vclk_output -max 0.200 [get_ports pipeline_stall]
set_output_delay -clock vclk_output -min 0.100 [get_ports pipeline_stall]
set_output_delay -clock vclk_output -max 0.200 [get_ports pipeline_flush]
set_output_delay -clock vclk_output -min 0.100 [get_ports pipeline_flush]

# ================================================================
# Load and Drive Constraints
# ================================================================

# Input loads (representing external driver capability)
set_load 0.1 [all_inputs]

# Output drives (representing internal driver capability)  
set_drive 0.1 [all_outputs]

# Specific high-performance interfaces
set_load 0.05 [get_ports mem_*]
set_load 0.05 [get_ports *cache_*]
set_drive 0.05 [get_ports mem_*]
set_drive 0.05 [get_ports *cache_*]

# ================================================================
# False Paths and Multicycle Paths
# ================================================================

# Asynchronous reset paths
set_false_path -from [get_ports rst_n] -to [all_registers]

# Test mode paths
set_false_path -from [get_ports test_mode]
set_false_path -from [get_ports scan_enable]
set_false_path -to [get_ports scan_out]

# JTAG paths (different clock domain)
set_false_path -from [get_ports jtag_*]
set_false_path -to [get_ports jtag_tdo]

# Power management paths (slow changing)
set_false_path -from [get_ports pwr_good]
set_false_path -from [get_ports voltage_ok] 
set_false_path -from [get_ports temp_ok]
set_false_path -to [get_ports cpu_sleep]

# Configuration paths (static during operation)
set_false_path -from [get_ports speculation_enable]
set_false_path -from [get_ports branch_prediction_enable]
set_false_path -from [get_ports out_of_order_enable]
set_false_path -from [get_ports hyperthreading_enable]
set_false_path -from [get_ports core_id*]
set_false_path -from [get_ports thread_id*]

# Debug paths
set_false_path -from [get_ports debug_mode]
set_false_path -from [get_ports single_step]
set_false_path -from [get_ports breakpoint*]

# Performance counters (updated less frequently)
set_multicycle_path -setup 2 -to [get_ports perf_counter_*]
set_multicycle_path -hold 1 -to [get_ports perf_counter_*]

# Memory interface multicycle paths (DDR4 timing)
set_multicycle_path -setup 2 -from [all_registers] -to [get_ports mem_data_out*]
set_multicycle_path -hold 1 -from [all_registers] -to [get_ports mem_data_out*]

# ================================================================
# Area and Power Optimization
# ================================================================

# Set area constraint (encourage smaller implementation)
set_max_area 0

# Power optimization
set_power_prediction true
set_dynamic_optimization true

# ================================================================
# Case Analysis for Different Operating Modes
# ================================================================

# Normal operation mode
set_case_analysis 0 [get_ports test_mode]
set_case_analysis 0 [get_ports scan_enable]
set_case_analysis 1 [get_ports pwr_good]
set_case_analysis 1 [get_ports voltage_ok]
set_case_analysis 1 [get_ports temp_ok]

# ================================================================
# High-Performance CPU Specific Constraints
# ================================================================

# Critical timing paths in pipeline stages
set_multicycle_path -setup 1 -hold 0 -through [get_pins -hierarchical *register_file*]

# Branch prediction paths (can be relaxed slightly)
set_multicycle_path -setup 2 -hold 1 -through [get_pins -hierarchical *branch_predictor*]

# Cache tag comparison paths (critical)
group_path -name cache_critical -through [get_pins -hierarchical *cache*tag*]
set_max_delay 0.200 -group cache_critical

# ALU critical paths
group_path -name alu_critical -through [get_pins -hierarchical *alu*]
set_max_delay 0.180 -group alu_critical

# Register file access paths
group_path -name regfile_critical -through [get_pins -hierarchical *register_file*]
set_max_delay 0.150 -group regfile_critical

# ================================================================
# Design for Test (DFT) Constraints
# ================================================================

# Scan chain constraints
set_scan_configuration -clock_mixing no_mix
set_dft_signal -view existing_dft -type ScanClock -port clk
set_dft_signal -view existing_dft -type Reset -port rst_n -active_state 0

# ================================================================
# Final Optimization Directives
# ================================================================

# Compile strategy for high performance
set_optimize_registers true
set_structure true
set_flatten true

# Enable advanced optimization
set_ultra_optimization true
set_boundary_optimization true

puts "SDC constraints loaded successfully for Intel Core i9 CPU Clone"
puts "Target frequency: [expr 1.0 / 0.286] GHz"
puts "Constraints optimized for high-performance operation"