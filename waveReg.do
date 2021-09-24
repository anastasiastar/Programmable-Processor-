onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /regfile16x16a_tb/clk
add wave -noupdate /regfile16x16a_tb/RF_W_en
add wave -noupdate /regfile16x16a_tb/RF_W_addr
add wave -noupdate /regfile16x16a_tb/W_Data
add wave -noupdate /regfile16x16a_tb/RF_Ra_addr
add wave -noupdate /regfile16x16a_tb/Ra_data
add wave -noupdate /regfile16x16a_tb/RF_Rb_addr
add wave -noupdate /regfile16x16a_tb/Rb_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {1 ns}
