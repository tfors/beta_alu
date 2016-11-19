// cla_add16.v
//
// tom@fors.net, November 19, 2016
//
// Purpose:
//   16-bit Carry-Lookahead Adder (CLA)


module cla_add16 (
    input      [15:0] a,
    input      [15:0] b,
    input             ci,

    output            g,
    output            p,
    output     [15:0] s
);

wire ch, cl;
wire gh, gl;
wire ph, pl;

cla_add8 addh (
    .a(a[15:8]),// in
    .b(b[15:8]),// in
    .ci(ch),    // in
    .g(gh),     // out
    .p(ph),     // out
    .s(s[15:8]) // out
);

cla_add8 addl (
    .a(a[7:0]), // in
    .b(b[7:0]), // in
    .ci(cl),    // in
    .g(gl),     // out
    .p(pl),     // out
    .s(s[7:0])  // out
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
