// cla_add32.v
//
// tom@fors.net, November 19, 2016
//
// Purpose:
//   32-bit Carry-Lookahead Adder (CLA)


module cla_add32 (
    input      [31:0] a,
    input      [31:0] b,
    input             ci,

    output            g,
    output            p,
    output     [31:0] s
);

wire ch, cl;
wire gh, gl;
wire ph, pl;

cla_add16 addh (
    .a(a[31:16]),   // in
    .b(b[31:16]),   // in
    .ci(ch),        // in
    .g(gh),         // out
    .p(ph),         // out
    .s(s[31:16])    // out
);

cla_add16 addl (
    .a(a[15:0]),    // in
    .b(b[15:0]),    // in
    .ci(cl),        // in
    .g(gl),         // out
    .p(pl),         // out
    .s(s[15:0])     // out
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
