`timescale 1ns/100ps

module alu_arith_tb;

reg clock = 0;

reg         afn;
reg  [31:0] a;
reg  [31:0] b;
wire [31:0] s;
wire        z;
wire        v;
wire        n;

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
		$dumpfile ("alu_arith_tb.vcd");
		$dumpvars (5, alu_arith_tb, dut);
	end
end

// -------------------------------------------------------
// TEST CASES
// -------------------------------------------------------

task test_case;
    input [64:0] inputs;
    input [34:0] expected_output;
    begin
        {afn, a, b} <= inputs;
        @(posedge clock)
        if ({s,z,v,n} == expected_output) begin
            $display("pass: afn=%d, a=%08x, b=%08x => s=%08x, zvn=%01x",
                     inputs[64], inputs[63:32], inputs[31:0],
                     s, {z,v,n});
        end else begin
            $error("FAIL: afn=%d, a=%08x, b=%08x => s=%08x, zvn=%01x (expected %08x %01x)",
                   inputs[64], inputs[63:32], inputs[31:0],
                   s, {z,v,n},
                   expected_output[34:3], expected_output[2:0]);
        end
    end
endtask

initial begin
    @(posedge clock);
    $display("");
	test_case({1'b0, 32'b00000000000000000000000000000000, 32'b00000000000000000000000000000000}, {32'b00000000000000000000000000000000, 3'b100}); //  1: afn=0, a=0X00000000, b=0X00000000, s=0X00000000
	test_case({1'b0, 32'b00000000000000000000000000000000, 32'b00000000000000000000000000000001}, {32'b00000000000000000000000000000001, 3'b000}); //  2: afn=0, a=0X00000000, b=0X00000001, s=0X00000001
	test_case({1'b0, 32'b00000000000000000000000000000000, 32'b11111111111111111111111111111111}, {32'b11111111111111111111111111111111, 3'b001}); //  3: afn=0, a=0X00000000, b=0XFFFFFFFF, s=0XFFFFFFFF
	test_case({1'b0, 32'b00000000000000000000000000000000, 32'b10101010101010101010101010101010}, {32'b10101010101010101010101010101010, 3'b001}); //  4: afn=0, a=0X00000000, b=0XAAAAAAAA, s=0XAAAAAAAA
	test_case({1'b0, 32'b00000000000000000000000000000000, 32'b01010101010101010101010101010101}, {32'b01010101010101010101010101010101, 3'b000}); //  5: afn=0, a=0X00000000, b=0X55555555, s=0X55555555
	test_case({1'b0, 32'b00000000000000000000000000000001, 32'b00000000000000000000000000000000}, {32'b00000000000000000000000000000001, 3'b000}); //  6: afn=0, a=0X00000001, b=0X00000000, s=0X00000001
	test_case({1'b0, 32'b00000000000000000000000000000001, 32'b00000000000000000000000000000001}, {32'b00000000000000000000000000000010, 3'b000}); //  7: afn=0, a=0X00000001, b=0X00000001, s=0X00000002
	test_case({1'b0, 32'b00000000000000000000000000000001, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000000000000, 3'b100}); //  8: afn=0, a=0X00000001, b=0XFFFFFFFF, s=0X00000000
	test_case({1'b0, 32'b00000000000000000000000000000001, 32'b10101010101010101010101010101010}, {32'b10101010101010101010101010101011, 3'b001}); //  9: afn=0, a=0X00000001, b=0XAAAAAAAA, s=0XAAAAAAAB
	test_case({1'b0, 32'b00000000000000000000000000000001, 32'b01010101010101010101010101010101}, {32'b01010101010101010101010101010110, 3'b000}); // 10: afn=0, a=0X00000001, b=0X55555555, s=0X55555556
	test_case({1'b0, 32'b11111111111111111111111111111111, 32'b00000000000000000000000000000000}, {32'b11111111111111111111111111111111, 3'b001}); // 11: afn=0, a=0XFFFFFFFF, b=0X00000000, s=0XFFFFFFFF
	test_case({1'b0, 32'b11111111111111111111111111111111, 32'b00000000000000000000000000000001}, {32'b00000000000000000000000000000000, 3'b100}); // 12: afn=0, a=0XFFFFFFFF, b=0X00000001, s=0X00000000
	test_case({1'b0, 32'b11111111111111111111111111111111, 32'b11111111111111111111111111111111}, {32'b11111111111111111111111111111110, 3'b001}); // 13: afn=0, a=0XFFFFFFFF, b=0XFFFFFFFF, s=0XFFFFFFFE
	test_case({1'b0, 32'b11111111111111111111111111111111, 32'b10101010101010101010101010101010}, {32'b10101010101010101010101010101001, 3'b001}); // 14: afn=0, a=0XFFFFFFFF, b=0XAAAAAAAA, s=0XAAAAAAA9
	test_case({1'b0, 32'b11111111111111111111111111111111, 32'b01010101010101010101010101010101}, {32'b01010101010101010101010101010100, 3'b000}); // 15: afn=0, a=0XFFFFFFFF, b=0X55555555, s=0X55555554
	test_case({1'b0, 32'b10101010101010101010101010101010, 32'b00000000000000000000000000000000}, {32'b10101010101010101010101010101010, 3'b001}); // 16: afn=0, a=0XAAAAAAAA, b=0X00000000, s=0XAAAAAAAA
	test_case({1'b0, 32'b10101010101010101010101010101010, 32'b00000000000000000000000000000001}, {32'b10101010101010101010101010101011, 3'b001}); // 17: afn=0, a=0XAAAAAAAA, b=0X00000001, s=0XAAAAAAAB
	test_case({1'b0, 32'b10101010101010101010101010101010, 32'b11111111111111111111111111111111}, {32'b10101010101010101010101010101001, 3'b001}); // 18: afn=0, a=0XAAAAAAAA, b=0XFFFFFFFF, s=0XAAAAAAA9
	test_case({1'b0, 32'b10101010101010101010101010101010, 32'b10101010101010101010101010101010}, {32'b01010101010101010101010101010100, 3'b010}); // 19: afn=0, a=0XAAAAAAAA, b=0XAAAAAAAA, s=0X55555554
	test_case({1'b0, 32'b10101010101010101010101010101010, 32'b01010101010101010101010101010101}, {32'b11111111111111111111111111111111, 3'b001}); // 20: afn=0, a=0XAAAAAAAA, b=0X55555555, s=0XFFFFFFFF
	test_case({1'b0, 32'b01010101010101010101010101010101, 32'b00000000000000000000000000000000}, {32'b01010101010101010101010101010101, 3'b000}); // 21: afn=0, a=0X55555555, b=0X00000000, s=0X55555555
	test_case({1'b0, 32'b01010101010101010101010101010101, 32'b00000000000000000000000000000001}, {32'b01010101010101010101010101010110, 3'b000}); // 22: afn=0, a=0X55555555, b=0X00000001, s=0X55555556
	test_case({1'b0, 32'b01010101010101010101010101010101, 32'b11111111111111111111111111111111}, {32'b01010101010101010101010101010100, 3'b000}); // 23: afn=0, a=0X55555555, b=0XFFFFFFFF, s=0X55555554
	test_case({1'b0, 32'b01010101010101010101010101010101, 32'b10101010101010101010101010101010}, {32'b11111111111111111111111111111111, 3'b001}); // 24: afn=0, a=0X55555555, b=0XAAAAAAAA, s=0XFFFFFFFF
	test_case({1'b0, 32'b01010101010101010101010101010101, 32'b01010101010101010101010101010101}, {32'b10101010101010101010101010101010, 3'b011}); // 25: afn=0, a=0X55555555, b=0X55555555, s=0XAAAAAAAA
	test_case({1'b1, 32'b00000000000000000000000000000000, 32'b00000000000000000000000000000000}, {32'b00000000000000000000000000000000, 3'b100}); // 26: fn=1, a=0X00000000, b=0X00000000, s=0X00000000
	test_case({1'b1, 32'b00000000000000000000000000000000, 32'b00000000000000000000000000000001}, {32'b11111111111111111111111111111111, 3'b001}); // 27: fn=1, a=0X00000000, b=0X00000001, s=0XFFFFFFFF
	test_case({1'b1, 32'b00000000000000000000000000000000, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000000000001, 3'b000}); // 28: fn=1, a=0X00000000, b=0XFFFFFFFF, s=0X00000001
	test_case({1'b1, 32'b00000000000000000000000000000000, 32'b10101010101010101010101010101010}, {32'b01010101010101010101010101010110, 3'b000}); // 29: fn=1, a=0X00000000, b=0XAAAAAAAA, s=0X55555556
	test_case({1'b1, 32'b00000000000000000000000000000000, 32'b01010101010101010101010101010101}, {32'b10101010101010101010101010101011, 3'b001}); // 30: fn=1, a=0X00000000, b=0X55555555, s=0XAAAAAAAB
	test_case({1'b1, 32'b00000000000000000000000000000001, 32'b00000000000000000000000000000000}, {32'b00000000000000000000000000000001, 3'b000}); // 31: fn=1, a=0X00000001, b=0X00000000, s=0X00000001
	test_case({1'b1, 32'b00000000000000000000000000000001, 32'b00000000000000000000000000000001}, {32'b00000000000000000000000000000000, 3'b100}); // 32: fn=1, a=0X00000001, b=0X00000001, s=0X00000000
	test_case({1'b1, 32'b00000000000000000000000000000001, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000000000010, 3'b000}); // 33: fn=1, a=0X00000001, b=0XFFFFFFFF, s=0X00000002
	test_case({1'b1, 32'b00000000000000000000000000000001, 32'b10101010101010101010101010101010}, {32'b01010101010101010101010101010111, 3'b000}); // 34: fn=1, a=0X00000001, b=0XAAAAAAAA, s=0X55555557
	test_case({1'b1, 32'b00000000000000000000000000000001, 32'b01010101010101010101010101010101}, {32'b10101010101010101010101010101100, 3'b001}); // 35: fn=1, a=0X00000001, b=0X55555555, s=0XAAAAAAAC
	test_case({1'b1, 32'b11111111111111111111111111111111, 32'b00000000000000000000000000000000}, {32'b11111111111111111111111111111111, 3'b001}); // 36: fn=1, a=0XFFFFFFFF, b=0X00000000, s=0XFFFFFFFF
	test_case({1'b1, 32'b11111111111111111111111111111111, 32'b00000000000000000000000000000001}, {32'b11111111111111111111111111111110, 3'b001}); // 37: fn=1, a=0XFFFFFFFF, b=0X00000001, s=0XFFFFFFFE
	test_case({1'b1, 32'b11111111111111111111111111111111, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000000000000, 3'b100}); // 38: fn=1, a=0XFFFFFFFF, b=0XFFFFFFFF, s=0X00000000
	test_case({1'b1, 32'b11111111111111111111111111111111, 32'b10101010101010101010101010101010}, {32'b01010101010101010101010101010101, 3'b000}); // 39: fn=1, a=0XFFFFFFFF, b=0XAAAAAAAA, s=0X55555555
	test_case({1'b1, 32'b11111111111111111111111111111111, 32'b01010101010101010101010101010101}, {32'b10101010101010101010101010101010, 3'b001}); // 40: fn=1, a=0XFFFFFFFF, b=0X55555555, s=0XAAAAAAAA
	test_case({1'b1, 32'b10101010101010101010101010101010, 32'b00000000000000000000000000000000}, {32'b10101010101010101010101010101010, 3'b001}); // 41: fn=1, a=0XAAAAAAAA, b=0X00000000, s=0XAAAAAAAA
	test_case({1'b1, 32'b10101010101010101010101010101010, 32'b00000000000000000000000000000001}, {32'b10101010101010101010101010101001, 3'b001}); // 42: fn=1, a=0XAAAAAAAA, b=0X00000001, s=0XAAAAAAA9
	test_case({1'b1, 32'b10101010101010101010101010101010, 32'b11111111111111111111111111111111}, {32'b10101010101010101010101010101011, 3'b001}); // 43: fn=1, a=0XAAAAAAAA, b=0XFFFFFFFF, s=0XAAAAAAAB
	test_case({1'b1, 32'b10101010101010101010101010101010, 32'b10101010101010101010101010101010}, {32'b00000000000000000000000000000000, 3'b100}); // 44: fn=1, a=0XAAAAAAAA, b=0XAAAAAAAA, s=0X00000000
	test_case({1'b1, 32'b10101010101010101010101010101010, 32'b01010101010101010101010101010101}, {32'b01010101010101010101010101010101, 3'b010}); // 45: fn=1, a=0XAAAAAAAA, b=0X55555555, s=0X55555555
	test_case({1'b1, 32'b01010101010101010101010101010101, 32'b00000000000000000000000000000000}, {32'b01010101010101010101010101010101, 3'b000}); // 46: fn=1, a=0X55555555, b=0X00000000, s=0X55555555
	test_case({1'b1, 32'b01010101010101010101010101010101, 32'b00000000000000000000000000000001}, {32'b01010101010101010101010101010100, 3'b000}); // 47: fn=1, a=0X55555555, b=0X00000001, s=0X55555554
	test_case({1'b1, 32'b01010101010101010101010101010101, 32'b11111111111111111111111111111111}, {32'b01010101010101010101010101010110, 3'b000}); // 48: fn=1, a=0X55555555, b=0XFFFFFFFF, s=0X55555556
	test_case({1'b1, 32'b01010101010101010101010101010101, 32'b10101010101010101010101010101010}, {32'b10101010101010101010101010101011, 3'b011}); // 49: fn=1, a=0X55555555, b=0XAAAAAAAA, s=0XAAAAAAAB
	test_case({1'b1, 32'b01010101010101010101010101010101, 32'b01010101010101010101010101010101}, {32'b00000000000000000000000000000000, 3'b100}); // 50: fn=1, a=0X55555555, b=0X55555555, s=0X00000000
	test_case({1'b1, 32'b01111111111111111111111111111111, 32'b11111111111111111111111111111111}, {32'b10000000000000000000000000000000, 3'b011}); // 51: fn=1, a=0X7FFFFFFF, b=0XFFFFFFFF, s=0X80000000
	test_case({1'b1, 32'b00111111111111111111111111111111, 32'b11111111111111111111111111111111}, {32'b01000000000000000000000000000000, 3'b000}); // 52: fn=1, a=0X3FFFFFFF, b=0XFFFFFFFF, s=0X40000000
	test_case({1'b1, 32'b00011111111111111111111111111111, 32'b11111111111111111111111111111111}, {32'b00100000000000000000000000000000, 3'b000}); // 53: fn=1, a=0X1FFFFFFF, b=0XFFFFFFFF, s=0X20000000
	test_case({1'b1, 32'b00001111111111111111111111111111, 32'b11111111111111111111111111111111}, {32'b00010000000000000000000000000000, 3'b000}); // 54: fn=1, a=0X0FFFFFFF, b=0XFFFFFFFF, s=0X10000000
	test_case({1'b1, 32'b00000111111111111111111111111111, 32'b11111111111111111111111111111111}, {32'b00001000000000000000000000000000, 3'b000}); // 55: fn=1, a=0X07FFFFFF, b=0XFFFFFFFF, s=0X08000000
	test_case({1'b1, 32'b00000011111111111111111111111111, 32'b11111111111111111111111111111111}, {32'b00000100000000000000000000000000, 3'b000}); // 56: fn=1, a=0X03FFFFFF, b=0XFFFFFFFF, s=0X04000000
	test_case({1'b1, 32'b00000001111111111111111111111111, 32'b11111111111111111111111111111111}, {32'b00000010000000000000000000000000, 3'b000}); // 57: fn=1, a=0X01FFFFFF, b=0XFFFFFFFF, s=0X02000000
	test_case({1'b1, 32'b00000000111111111111111111111111, 32'b11111111111111111111111111111111}, {32'b00000001000000000000000000000000, 3'b000}); // 58: fn=1, a=0X00FFFFFF, b=0XFFFFFFFF, s=0X01000000
	test_case({1'b1, 32'b00000000011111111111111111111111, 32'b11111111111111111111111111111111}, {32'b00000000100000000000000000000000, 3'b000}); // 59: fn=1, a=0X007FFFFF, b=0XFFFFFFFF, s=0X00800000
	test_case({1'b1, 32'b00000000001111111111111111111111, 32'b11111111111111111111111111111111}, {32'b00000000010000000000000000000000, 3'b000}); // 60: fn=1, a=0X003FFFFF, b=0XFFFFFFFF, s=0X00400000
	test_case({1'b1, 32'b00000000000111111111111111111111, 32'b11111111111111111111111111111111}, {32'b00000000001000000000000000000000, 3'b000}); // 61: fn=1, a=0X001FFFFF, b=0XFFFFFFFF, s=0X00200000
	test_case({1'b1, 32'b00000000000011111111111111111111, 32'b11111111111111111111111111111111}, {32'b00000000000100000000000000000000, 3'b000}); // 62: fn=1, a=0X000FFFFF, b=0XFFFFFFFF, s=0X00100000
	test_case({1'b1, 32'b00000000000001111111111111111111, 32'b11111111111111111111111111111111}, {32'b00000000000010000000000000000000, 3'b000}); // 63: fn=1, a=0X0007FFFF, b=0XFFFFFFFF, s=0X00080000
	test_case({1'b1, 32'b00000000000000111111111111111111, 32'b11111111111111111111111111111111}, {32'b00000000000001000000000000000000, 3'b000}); // 64: fn=1, a=0X0003FFFF, b=0XFFFFFFFF, s=0X00040000
	test_case({1'b1, 32'b00000000000000011111111111111111, 32'b11111111111111111111111111111111}, {32'b00000000000000100000000000000000, 3'b000}); // 65: fn=1, a=0X0001FFFF, b=0XFFFFFFFF, s=0X00020000
	test_case({1'b1, 32'b00000000000000001111111111111111, 32'b11111111111111111111111111111111}, {32'b00000000000000010000000000000000, 3'b000}); // 66: fn=1, a=0X0000FFFF, b=0XFFFFFFFF, s=0X00010000
	test_case({1'b1, 32'b00000000000000000111111111111111, 32'b11111111111111111111111111111111}, {32'b00000000000000001000000000000000, 3'b000}); // 67: fn=1, a=0X00007FFF, b=0XFFFFFFFF, s=0X00008000
	test_case({1'b1, 32'b00000000000000000011111111111111, 32'b11111111111111111111111111111111}, {32'b00000000000000000100000000000000, 3'b000}); // 68: fn=1, a=0X00003FFF, b=0XFFFFFFFF, s=0X00004000
	test_case({1'b1, 32'b00000000000000000001111111111111, 32'b11111111111111111111111111111111}, {32'b00000000000000000010000000000000, 3'b000}); // 69: fn=1, a=0X00001FFF, b=0XFFFFFFFF, s=0X00002000
	test_case({1'b1, 32'b00000000000000000000111111111111, 32'b11111111111111111111111111111111}, {32'b00000000000000000001000000000000, 3'b000}); // 70: fn=1, a=0X00000FFF, b=0XFFFFFFFF, s=0X00001000
	test_case({1'b1, 32'b00000000000000000000011111111111, 32'b11111111111111111111111111111111}, {32'b00000000000000000000100000000000, 3'b000}); // 71: fn=1, a=0X000007FF, b=0XFFFFFFFF, s=0X00000800
	test_case({1'b1, 32'b00000000000000000000001111111111, 32'b11111111111111111111111111111111}, {32'b00000000000000000000010000000000, 3'b000}); // 72: fn=1, a=0X000003FF, b=0XFFFFFFFF, s=0X00000400
	test_case({1'b1, 32'b00000000000000000000000111111111, 32'b11111111111111111111111111111111}, {32'b00000000000000000000001000000000, 3'b000}); // 73: fn=1, a=0X700001FF, b=0XFFFFFFFF, s=0X00000200
	test_case({1'b1, 32'b00000000000000000000000011111111, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000100000000, 3'b000}); // 74: fn=1, a=0X000000FF, b=0XFFFFFFFF, s=0X00000100
	test_case({1'b1, 32'b00000000000000000000000001111111, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000010000000, 3'b000}); // 75: fn=1, a=0X0000007F, b=0XFFFFFFFF, s=0X00000080
	test_case({1'b1, 32'b00000000000000000000000000111111, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000001000000, 3'b000}); // 76: fn=1, a=0X0000003F, b=0XFFFFFFFF, s=0X00000040
	test_case({1'b1, 32'b00000000000000000000000000011111, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000000100000, 3'b000}); // 77: fn=1, a=0X0000001F, b=0XFFFFFFFF, s=0X00000020
	test_case({1'b1, 32'b00000000000000000000000000001111, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000000010000, 3'b000}); // 78: fn=1, a=0X0000000F, b=0XFFFFFFFF, s=0X00000010
	test_case({1'b1, 32'b00000000000000000000000000000111, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000000001000, 3'b000}); // 79: fn=1, a=0X00000007, b=0XFFFFFFFF, s=0X00000008
	test_case({1'b1, 32'b00000000000000000000000000000011, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000000000100, 3'b000}); // 80: fn=1, a=0X00000003, b=0XFFFFFFFF, s=0X00000004
	test_case({1'b1, 32'b00000000000000000000000000000001, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000000000010, 3'b000}); // 81: fn=1, a=0X00000001, b=0XFFFFFFFF, s=0X00000002
	test_case({1'b1, 32'b00000000000000000000000000000000, 32'b11111111111111111111111111111111}, {32'b00000000000000000000000000000001, 3'b000}); // 82: fn=1, a=0X00000000, b=0XFFFFFFFF, s=0X00000001
    $display("");
    $finish;
end

alu_arith dut (
    .afn(afn),
    .a(a),
    .b(b),
    .s(s),
	.z(z),
	.v(v),
	.n(n)
);

endmodule