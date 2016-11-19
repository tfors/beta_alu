// cla_gpc.v
//
// tom@fors.net, November 19, 2016
//
// Purpose:
//   Basic Generate/Propagate and Carry logic for Carry-Lookahead Adder (CLA)


module cla_gpc (
    input             gh,
    input             ph,
    input             gl,
    input             pl,
    input             ci,

    output            ghl,
    output            phl,
    output            ch,
    output            cl
);

assign ghl = gh | ph & gl;
assign phl = ph & pl;
assign ch = gl | pl & cin;
assign cl = cin;

endmodule
