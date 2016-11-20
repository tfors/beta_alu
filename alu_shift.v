// alu_shift.v
//
// tom@fors.net, November 19, 2016
//
// Purpose:
//   Shift logic for ALU


module alu_shift (
    input      [31:0] a,
    input       [4:0] b,
    input       [1:0] sfn,

    output     [31:0] y
);

function [31:0] bit_reverse;
    input [31:0] a;
    begin
        bit_reverse = {a[0],  a[1],  a[2],  a[3],  a[4],  a[5],  a[6],  a[7],
                       a[8],  a[9],  a[10], a[11], a[12], a[13], a[14], a[15],
                       a[16], a[17], a[18], a[19], a[20], a[21], a[22], a[23],
                       a[24], a[25], a[26], a[27], a[28], a[29], a[30], a[31]};
    end
endfunction

wire in;
assign in = (sfn[1] == 1 ? a[31] : 1'b0);

wire [31:0] ain;
assign ain = (sfn[0] == 1 ? bit_reverse(a[31:0]) : a[31:0]);


wire [31:0] q;
assign q = (b[4] == 1 ? {ain[15:0], {16{in}}} : ain[31:0]);

wire [31:0] r;
assign r = (b[3] == 1 ? {q[23:0], {8{in}}} : q[31:0]);

wire [31:0] s;
assign s = (b[2] == 1 ? {r[27:0], {4{in}}} : r[31:0]);

wire [31:0] t;
assign t = (b[1] == 1 ? {s[29:0], {2{in}}} : s[31:0]);

wire [31:0] sl;
assign sl = (b[0] == 1 ? {t[30:0], in} : t[31:0]);


assign y = (sfn[0] == 1 ? bit_reverse(sl[31:0]) : sl[31:0]);

endmodule
