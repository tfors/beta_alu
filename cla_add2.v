// cla_add2.v
//
// tom@fors.net, November 19, 2016
//
// Purpose:
//   Two-bit Carry-Lookahead Adder (CLA)


module cla_add2 (
    input       [1:0] a,
    input       [1:0] b,
    input             ci,

    output            g,
    output            p,
    output      [1:0] s
);

wire ch, cl;
wire gh, gl;
wire ph, pl;

cla_fa addh (
    .a(a[1]),   // in
    .b(b[1]),   // in
    .ci(ch),    // in
    .g(gh),     // out
    .p(ph),     // out
    .s(s[1])    // out
);

cla_fa addl (
    .a(a[0]),   // in
    .b(b[0]),   // in
    .ci(cl),    // in
    .g(gl),     // out
    .p(pl),     // out
    .s(s[0])    // out
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
