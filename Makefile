.PHONY: default all clean

VCD = sim.vcd
GHDLFLAGS = --std=08
MODULES = decoder_3to8
BENCHES = decoder_3to8_tb

default: all
all: $(BENCHES)

$(MODULES:=.o): $(MODULES:=.vhd)
	ghdl -a -o $@ $(GHDLFLAGS) $<
$(BENCHES:=.o): $(BENCHES:=.vhd)
	ghdl -a -o $@ $(GHDLFLAGS) $<
$(BENCHES): $(BENCHES:=.o) | $(MODULES:=.o)
	ghdl -e -o $@ $(GHDLFLAGS) $(<:.o=)

run_%: %
	ghdl -r $< --vcd=$<.vcd

clean:
	-rm -f *.o
	-rm -f $(BENCHES)
	-rm -f *.vcd
	-rm -f work-*.cf
