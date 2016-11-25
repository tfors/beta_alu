// alu_cmp.v
//
// tom@fors.net, November 25, 2016
//
// Purpose:
//   Comparison logic for ALU


module alu_cmp (
    input             z,
    input             v,
    input             n,
    input       [1:0] cfn,

    output     [31:0] y
);

function mux4;
    input [3:0] a;
    input [1:0] sel;
    begin
        if (sel == 2'b00) mux4 = a[0];
        else if (sel == 2'b01) mux4 = a[1];
        else if (sel == 2'b10) mux4 = a[2];
        else if (sel == 2'b11) mux4 = a[3];
    end
endfunction

wire [3:0] cmp;
assign cmp[0] = 1'b0;
assign cmp[1] = z;
assign cmp[2] = n ^ v;
assign cmp[3] = z | (n ^ v);

assign y = {31'd0, mux4(cmp, cfn)};

endmodule
