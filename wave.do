onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench3/cpu1/reset
add wave -noupdate /testbench3/cpu1/clk
add wave -noupdate -radix hexadecimal {/testbench3/cpu1/regs[7]}
add wave -noupdate -radix hexadecimal {/testbench3/cpu1/regs[0]}
add wave -noupdate /testbench3/cpu1/op
add wave -noupdate /testbench3/cpu1/sss
add wave -noupdate /testbench3/cpu1/dout
add wave -noupdate /testbench3/adr
add wave -noupdate /testbench3/cpu1/c_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 188
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {46 ps} {103 ps}
