TESTBENCH = beta_alu_tb

SRC += $(TESTBENCH).v
SRC += beta_alu.v

.PHONY: test
test: $(SRC)
	iverilog -o $(TESTBENCH).vvp $^
	vvp -n $(TESTBENCH).vvp +vcd -lxt2
	gtkwave $(TESTBENCH).vcd $(TESTBENCH).sav

FA_TESTBENCH = cla_fa_tb
FA_SRC += $(FA_TESTBENCH).v
FA_SRC += cla_fa.v
.PHONY: fa
fa: $(FA_SRC)
	iverilog -o $(FA_TESTBENCH).vvp $^
	vvp -n $(FA_TESTBENCH).vvp +vcd -lxt2
	gtkwave $(FA_TESTBENCH).vcd $(FA_TESTBENCH).sav

ADD32_TESTBENCH = cla_add32_tb
ADD32_SRC += $(ADD32_TESTBENCH).v
ADD32_SRC += cla_add32.v cla_add16.v cla_add8.v cla_add4.v cla_add2.v
ADD32_SRC += cla_fa.v cla_gpc.v
.PHONY: add32
add32: $(ADD32_SRC)
	iverilog -o $(ADD32_TESTBENCH).vvp $^
	vvp -n $(ADD32_TESTBENCH).vvp +vcd -lxt2
	gtkwave $(ADD32_TESTBENCH).vcd $(ADD32_TESTBENCH).sav

SHIFT_TESTBENCH = alu_shift_tb
SHIFT_SRC += $(SHIFT_TESTBENCH).v
SHIFT_SRC += alu_shift.v
.PHONY: shift
shift: $(SHIFT_SRC)
	iverilog -o $(SHIFT_TESTBENCH).vvp $^
	vvp -n $(SHIFT_TESTBENCH).vvp +vcd -lxt2
	gtkwave $(SHIFT_TESTBENCH).vcd $(SHIFT_TESTBENCH).sav

.PHONY: clean
clean:
	rm -rf *.vvp *.vcd *~
