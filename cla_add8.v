// cla_add8.v
//
// tom@fors.net, November 19, 2016
//
// Purpose:
//   Eight-bit Carry-Lookahead Adder (CLA)


module cla_add8 (
    input       [7:0] a,
    input       [7:0] b,
    input             ci,

    output            g,
    output            p,
    output      [7:0] s
);

wire ch, cl;
wire gh, gl;
wire ph, pl;

cla_add4 addh (
    .a(a[7:4]), // in
    .b(b[7:4]), // in
    .ci(ch),    // in
    .g(gh),     // out
    .p(ph),     // out
    .s(s[7:4])  // out
);

cla_add4 addl (
    .a(a[3:0]), // in
    .b(b[3:0]), // in
    .ci(cl),    // in
    .g(gl),     // out
    .p(pl),     // out
    .s(s[3:0])  // out
);

cla_gpc gpc (
    .gh(gh),    // in
    .ph(ph),    // in
    .gl(gl),    // in
    .pl(pl),    // in
    .ci(ci),    // in
    .ghl(g),    // out
    .phl(p),    // out
    .ch(ch),    // out
    .cl(cl)     // out
);

endmodule
