`timescale 1ns/100ps

module cla_fa_tb;

reg clock = 0;

reg a;
reg b;
reg ci;
wire g;
wire p;
wire s;

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
	#136 $finish;
end

// -------------------------------------------------------
// INITIALIZATION
// -------------------------------------------------------

initial begin
	if ($test$plusargs("vcd")) begin
		$dumpfile ("cla_fa_tb.vcd");
		$dumpvars (5, cla_fa_tb, dut);
	end
end

// -------------------------------------------------------
// TEST CASES
// -------------------------------------------------------

task test_case;
    input [2:0] inputs;
    input [2:0] expected_output;
    begin
        @(posedge clock)
        {a, b, ci} <= inputs;
        @(posedge clock)
        if ({s, g, p} == expected_output) begin
            $display("pass: ABCin=%d%d%d => SGP=%d%d%d",
                     inputs[2], inputs[1], inputs[0],
                     s, g, p);
        end else begin
            $error("FAIL: ABCin=%d%d%d => SGP=%d%d%d (expected %d%d%d)",
                   inputs[2], inputs[1], inputs[0],
                   s, g, p,
                   expected_output[2], expected_output[1], expected_output[0]);
        end
    end
endtask

initial begin
    $display("");
    test_case(3'b000, 3'b000);
    test_case(3'b001, 3'b100);
    test_case(3'b010, 3'b101);
    test_case(3'b011, 3'b001);
    test_case(3'b100, 3'b101);
    test_case(3'b101, 3'b001);
    test_case(3'b110, 3'b010);
    test_case(3'b111, 3'b110);
    $display("");
end


cla_fa dut (
    .a(a),
    .b(b),
    .ci(ci),
    .g(g),
    .p(p),
    .s(s)
);

endmodule
