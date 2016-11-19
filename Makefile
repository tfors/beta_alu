TESTBENCH = beta_alu_tb

SRC += $(TESTBENCH).v
SRC += beta_alu.v

FA_TESTBENCH = cla_fa_tb
FA_SRC += $(FA_TESTBENCH).v
FA_SRC += cla_fa.v


.PHONY: test
test: $(SRC)
	iverilog -o $(TESTBENCH).vvp $^
	vvp -n $(TESTBENCH).vvp +vcd -lxt2
	gtkwave $(TESTBENCH).vcd $(TESTBENCH).sav

.PHONY: fa
fa: $(FA_SRC)
	iverilog -o $(FA_TESTBENCH).vvp $^
	vvp -n $(FA_TESTBENCH).vvp +vcd -lxt2
	gtkwave $(FA_TESTBENCH).vcd $(FA_TESTBENCH).sav

.PHONY: clean
clean:
	rm -rf *.vvp *.vcd *~
