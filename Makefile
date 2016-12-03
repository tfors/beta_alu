TESTBENCH = beta_alu_tb

SRC += $(TESTBENCH).v
SRC += beta_alu.v
SRC += alu_shift.v
SRC += alu_bool.v
SRC += alu_arith.v cla_add32.v cla_add16.v cla_add8.v cla_add4.v cla_add2.v cla_fa.v cla_gpc.v
SRC += alu_cmp.v

.PHONY: test
test: test-fa test-add32 test-shift test-bool test-arith test-cmp test-alu

.PHONY: test-alu view-alu
test-alu: $(SRC)
	iverilog -o $(TESTBENCH).vvp $^
	vvp -n $(TESTBENCH).vvp +vcd -lxt2
view-alu:
	-$(MAKE) test-alu
	gtkwave $(TESTBENCH).vcd $(TESTBENCH).sav

FA_TESTBENCH = cla_fa_tb
FA_SRC += $(FA_TESTBENCH).v
FA_SRC += cla_fa.v
.PHONY: test-fa view-fa
test-fa: $(FA_SRC)
	iverilog -o $(FA_TESTBENCH).vvp $^
	vvp -n $(FA_TESTBENCH).vvp +vcd -lxt2
view-fa:
	-$(MAKE) test-fa
	gtkwave $(FA_TESTBENCH).vcd $(FA_TESTBENCH).sav

ADD32_TESTBENCH = cla_add32_tb
ADD32_SRC += $(ADD32_TESTBENCH).v
ADD32_SRC += cla_add32.v cla_add16.v cla_add8.v cla_add4.v cla_add2.v
ADD32_SRC += cla_fa.v cla_gpc.v
.PHONY: test-add32 view-add32
test-add32: $(ADD32_SRC)
	iverilog -o $(ADD32_TESTBENCH).vvp $^
	vvp -n $(ADD32_TESTBENCH).vvp +vcd -lxt2
view-add32:
	-$(MAKE) test-add32
	gtkwave $(ADD32_TESTBENCH).vcd $(ADD32_TESTBENCH).sav

SHIFT_TESTBENCH = alu_shift_tb
SHIFT_SRC += $(SHIFT_TESTBENCH).v
SHIFT_SRC += alu_shift.v
.PHONY: test-shift view-shift
test-shift: $(SHIFT_SRC)
	iverilog -o $(SHIFT_TESTBENCH).vvp $^
	vvp -n $(SHIFT_TESTBENCH).vvp +vcd -lxt2
view-shift:
	-$(MAKE) test-shift
	gtkwave $(SHIFT_TESTBENCH).vcd $(SHIFT_TESTBENCH).sav

BOOL_TESTBENCH = alu_bool_tb
BOOL_SRC += $(BOOL_TESTBENCH).v
BOOL_SRC += alu_bool.v
.PHONY: test-bool view-bool
test-bool: $(BOOL_SRC)
	iverilog -o $(BOOL_TESTBENCH).vvp $^
	vvp -n $(BOOL_TESTBENCH).vvp +vcd -lxt2
view-bool:
	-$(MAKE) test-bool
	gtkwave $(BOOL_TESTBENCH).vcd $(BOOL_TESTBENCH).sav

ARITH_TESTBENCH = alu_arith_tb
ARITH_SRC += $(ARITH_TESTBENCH).v
ARITH_SRC += alu_arith.v
ARITH_SRC += cla_add32.v cla_add16.v cla_add8.v cla_add4.v cla_add2.v
ARITH_SRC += cla_fa.v cla_gpc.v
.PHONY: test-arith view-arith
test-arith: $(ARITH_SRC)
	iverilog -o $(ARITH_TESTBENCH).vvp $^
	vvp -n $(ARITH_TESTBENCH).vvp +vcd -lxt2
view-arith:
	-$(MAKE) test-arith
	gtkwave $(ARITH_TESTBENCH).vcd $(ARITH_TESTBENCH).sav

CMP_TESTBENCH = alu_cmp_tb
CMP_SRC += $(CMP_TESTBENCH).v
CMP_SRC += alu_cmp.v
.PHONY: test-cmp view-cmp
test-cmp: $(CMP_SRC)
	iverilog -o $(CMP_TESTBENCH).vvp $^
	vvp -n $(CMP_TESTBENCH).vvp +vcd -lxt2
view-cmp:
	-$(MAKE) test-cmp
	gtkwave $(CMP_TESTBENCH).vcd $(CMP_TESTBENCH).sav

.PHONY: clean
clean:
	rm -rf *.vvp *.vcd *~
