.PHONY: default all clean

GHDLFLAGS = --std=08
MODULES = mux4 decoder_3to8 mux8_16bit mux2_16bit full_adder logic_slice reg16 register_file
BENCHES = mux4_tb decoder_3to8_tb mux8_16bit_tb mux2_16bit_tb logic_slice_tb full_adder_tb reg16_tb register_file_tb

default: all
all: $(BENCHES)

$(MODULES:=.o): %.o: %.vhd
	ghdl -a -o $@ $(GHDLFLAGS) $<
$(BENCHES:=.o): %.o: %.vhd
	ghdl -a -o $@ $(GHDLFLAGS) $<
$(BENCHES): %: %.o | $(MODULES:=.o)
	ghdl -e -o $@ $(GHDLFLAGS) $(<:.o=)

run_%: %
	ghdl -r $< --vcd=$<.vcd

clean:
	-rm -f *.o
	-rm -f $(BENCHES)
	-rm -f *.vcd
	-rm -f work-*.cf
