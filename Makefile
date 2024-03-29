.PHONY: default all clean

GHDLFLAGS = --std=08
MODULES = mux2 mux3 mux4 decoder_4to9 mux9_16bit mux2_16bit full_adder \
		  logic_slice arith_b_fn arithmetic_slice alu_slice reg16 \
		  shifter alu register_file function_unit memory pc pc_extend \
		  flag_mux control_memory mux2_8bit car datapath micro_control \
		  computer
BENCHES = mux4_tb decoder_4to9_tb mux9_16bit_tb mux2_16bit_tb full_adder_tb \
		  logic_slice_tb arith_b_fn_tb arithmetic_slice_tb alu_slice_tb \
		  reg16_tb shifter_tb alu_tb register_file_tb function_unit_tb memory_tb \
		  pc_tb pc_extend_tb flag_mux_tb control_memory_tb mux2_8bit_tb \
		  car_tb datapath_tb computer_tb

default: all
all: $(BENCHES)

$(MODULES:=.o): %.o: %.vhd
	ghdl -a -o $@ $(GHDLFLAGS) $<
$(BENCHES:=.o): %.o: %.vhd
	ghdl -a -o $@ $(GHDLFLAGS) $<
$(BENCHES): %: %.o | $(MODULES:=.o)
	ghdl -e -o $@ $(GHDLFLAGS) $(<:.o=)

run_%: %
	ghdl -r $< --wave=$<.ghw

clean:
	-rm -f *.o
	-rm -f $(BENCHES)
	-rm -f *.ghw
	-rm -f work-*.cf
