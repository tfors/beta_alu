`timescale 1ns/100ps

module beta_alu_tb;

reg clock = 0;
reg reset = 0;

// -------------------------------------------------------
// CLOCK GENERATION
// -------------------------------------------------------

always begin
	clock=0; #4;  // 125 MHz
	clock=1; #4;
end

// -------------------------------------------------------
// TERMINATION
// -------------------------------------------------------

initial begin
	#100 $finish;
end

// -------------------------------------------------------
// INITIALIZATION
// -------------------------------------------------------

initial begin
	if ($test$plusargs("vcd")) begin
		$dumpfile ("beta_alu_tb.vcd");
		$dumpvars (5, beta_alu_tb, dut);
	end
end

// -------------------------------------------------------
// TEST CASES
// -------------------------------------------------------

initial begin
	// Provide dut stimulus here
	#8 reset = 1;
	#8 reset = 0;
end


beta_alu dut (
	.clk(clock),
	.reset(reset),

	.counter()
);

endmodule
