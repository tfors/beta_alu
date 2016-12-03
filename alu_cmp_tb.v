`timescale 1ns/100ps

module alu_cmp_tb;

reg clock = 0;
integer dut_error = 0;

reg   [1:0] cfn;
reg         z;
reg         v;
reg         n;
wire [31:0] y;

// -------------------------------------------------------
// CLOCK GENERATION
// -------------------------------------------------------

always begin
	clock=0; #4;  // 125 MHz
	clock=1; #4;
end

// -------------------------------------------------------
// INITIALIZATION
// -------------------------------------------------------

initial begin
	if ($test$plusargs("vcd")) begin
		$dumpfile ("alu_cmp_tb.vcd");
		$dumpvars (5, alu_cmp_tb, dut);
	end
end

// -------------------------------------------------------
// TEST CASES
// -------------------------------------------------------

task test_case;
    input [4:0] inputs;
    input [31:0] expected_output;
	input integer line;
    begin
        {cfn, z, v, n} <= inputs;
        @(posedge clock)
        if (y == expected_output) begin
            $display("pass:  cfn=%01x, z=%d, v=%d, n=%d => y=%08x",
                     inputs[4:3], inputs[2], inputs[1], inputs[0],
                     y);
        end else begin
            $display("FAIL:  cfn=%01x, z=%d, v=%d, n=%d => y=%08x (expected %08x)",
                     inputs[4:3], inputs[2], inputs[1], inputs[0],
                     y,
                     expected_output);
			$error("");
			$display("       test_case at line %d", line);
			dut_error = dut_error + 1;
        end
    end
endtask

initial begin
    @(posedge clock);
    $display("");
	test_case({2'b01, 3'b000}, 32'b00000000000000000000000000000000, `__LINE__); //  1: cfn=CMPEQ, z=0, v=0, n=0, y=0
	test_case({2'b10, 3'b000}, 32'b00000000000000000000000000000000, `__LINE__); //  2: cfn=CMPLT, z=0, v=0, n=0, y=0
	test_case({2'b11, 3'b000}, 32'b00000000000000000000000000000000, `__LINE__); //  3: cfn=CMPLE, z=0, v=0, n=0, y=0
	test_case({2'b01, 3'b001}, 32'b00000000000000000000000000000000, `__LINE__); //  4: cfn=CMPEQ, z=0, v=0, n=1, y=0
	test_case({2'b10, 3'b001}, 32'b00000000000000000000000000000001, `__LINE__); //  5: cfn=CMPLT, z=0, v=0, n=1, y=1
	test_case({2'b11, 3'b001}, 32'b00000000000000000000000000000001, `__LINE__); //  6: cfn=CMPLE, z=0, v=0, n=1, y=1
	test_case({2'b01, 3'b010}, 32'b00000000000000000000000000000000, `__LINE__); //  7: cfn=CMPEQ, z=0, v=1, n=0, y=0
	test_case({2'b10, 3'b010}, 32'b00000000000000000000000000000001, `__LINE__); //  8: cfn=CMPLT, z=0, v=1, n=0, y=1
	test_case({2'b11, 3'b010}, 32'b00000000000000000000000000000001, `__LINE__); //  9: cfn=CMPLE, z=0, v=1, n=0, y=1
	test_case({2'b01, 3'b011}, 32'b00000000000000000000000000000000, `__LINE__); // 10: cfn=CMPEQ, z=0, v=1, n=1, y=0
	test_case({2'b10, 3'b011}, 32'b00000000000000000000000000000000, `__LINE__); // 11: cfn=CMPLT, z=0, v=1, n=1, y=0
	test_case({2'b11, 3'b011}, 32'b00000000000000000000000000000000, `__LINE__); // 12: cfn=CMPLE, z=0, v=1, n=1, y=0
	test_case({2'b01, 3'b100}, 32'b00000000000000000000000000000001, `__LINE__); // 13: cfn=CMPEQ, z=1, v=0, n=0, y=1
	test_case({2'b10, 3'b100}, 32'b00000000000000000000000000000000, `__LINE__); // 14: cfn=CMPLT, z=1, v=0, n=0, y=0
	test_case({2'b11, 3'b100}, 32'b00000000000000000000000000000001, `__LINE__); // 15: cfn=CMPLE, z=1, v=0, n=0, y=1
	test_case({2'b01, 3'b101}, 32'b00000000000000000000000000000001, `__LINE__); // 16: cfn=CMPEQ, z=1, v=0, n=1, y=1
	test_case({2'b10, 3'b101}, 32'b00000000000000000000000000000001, `__LINE__); // 17: fn=CMPLT, z=1, v=0, n=1, y=1
	test_case({2'b11, 3'b101}, 32'b00000000000000000000000000000001, `__LINE__); // 18: fn=CMPLE, z=1, v=0, n=1, y=1
	test_case({2'b01, 3'b110}, 32'b00000000000000000000000000000001, `__LINE__); // 19: fn=CMPEQ, z=1, v=1, n=0, y=1
	test_case({2'b10, 3'b110}, 32'b00000000000000000000000000000001, `__LINE__); // 20: fn=CMPLT, z=1, v=1, n=0, y=1
	test_case({2'b11, 3'b110}, 32'b00000000000000000000000000000001, `__LINE__); // 21: fn=CMPLE, z=1, v=1, n=0, y=1
	$display("");
	if (dut_error != 0) begin
		$display("ERROR: %d test cases failed", dut_error);
		$finish_and_return(1);
	end
	$display("PASS:  all test cases passed");
	$display("");
    $finish;
end

alu_cmp dut (
    .cfn(cfn),
    .z(z),
    .v(v),
    .n(n),
	.y(y)
);

endmodule
