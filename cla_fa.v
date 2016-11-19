// cla_fa.v
//
// tom@fors.net, November 19, 2016
//
// Purpose:
//   Full Adder logic for Carry-Lookahead Adder (CLA)


module cla_fa (
    input             a,
    input             b,
    input             ci,

    output            g,
    output            p,
    output            s
);

assign g = a & b;
assign p = a ^ b;
assign s = p ^ ci;

endmodule
