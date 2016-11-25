// alu_arith.v
//
// tom@fors.net, November 25, 2016
//
// Purpose:
//   Adder/Subtractor logic for ALU


module alu_arith (
    input      [31:0] a,
    input      [31:0] b,
    input             afn,

    output     [31:0] s,
    output            z,
    output            v,
    output            n
);

wire [31:0] xa;
assign xa = a;

wire [31:0] xb;
assign xb = b ^ {32{afn}};

assign z = (s == 32'h00000000); // zero
assign v = (xa[31] & xb[31] & ~s[31]) | (~xa[31] & ~xb[31] & s[31]);    // overflow
assign n = (s[31] == 1);        // negative

cla_add32 add32 (
    .a(xa),
    .b(xb),
    .ci(afn),
    .g(),
    .p(),
    .s(s)
);

endmodule
