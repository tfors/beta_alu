// cla_add4.v
//
// tom@fors.net, November 19, 2016
//
// Purpose:
//   Four-bit Carry-Lookahead Adder (CLA)


module cla_add4 (
    input       [3:0] a,
    input       [3:0] b,
    input             ci,

    output            g,
    output            p,
    output      [3:0] s
);

wire ch, cl;
wire gh, gl;
wire ph, pl;

cla_add2 addh (
    .a(a[3:2]), // in
    .b(b[3:2]), // in
    .ci(ch),    // in
    .g(gh),     // out
    .p(ph),     // out
    .s(s[3:2])  // out
);

cla_add2 addl (
    .a(a[1:0]), // in
    .b(b[1:0]), // in
    .ci(cl),    // in
    .g(gl),     // out
    .p(pl),     // out
    .s(s[1:0])  // out
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
