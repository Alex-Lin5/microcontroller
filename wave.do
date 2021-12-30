onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MCU_testbench/clk
add wave -noupdate /MCU_testbench/clkdut
add wave -noupdate /MCU_testbench/clb
add wave -noupdate /MCU_testbench/dut/controller_unit/current_state
add wave -noupdate /MCU_testbench/memaddress
add wave -noupdate /MCU_testbench/pcaddr
add wave -noupdate /MCU_testbench/instru
add wave -noupdate /MCU_testbench/result
add wave -noupdate /MCU_testbench/expected
add wave -noupdate /MCU_testbench/dut/aluout
add wave -noupdate /MCU_testbench/dut/selalu
add wave -noupdate /MCU_testbench/dut/selacc
add wave -noupdate /MCU_testbench/dut/zflag
add wave -noupdate /MCU_testbench/dut/cflag
add wave -noupdate /MCU_testbench/dut/controller_unit/opcode
add wave -noupdate /MCU_testbench/dut/pc_unit/imm
add wave -noupdate /MCU_testbench/dut/irout
add wave -noupdate /MCU_testbench/dut/regout
add wave -noupdate /MCU_testbench/dut/rf_unit/RegAddr
add wave -noupdate /MCU_testbench/dut/incrpc
add wave -noupdate /MCU_testbench/dut/selpc
add wave -noupdate /MCU_testbench/dut/loadpc
add wave -noupdate /MCU_testbench/dut/loadir
add wave -noupdate /MCU_testbench/dut/loadreg
add wave -noupdate /MCU_testbench/dut/loadacc
add wave -noupdate /MCU_testbench/dut/loadalu
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {222168 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 223
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
WaveRestoreZoom {78771 ps} {362272 ps}
