// alu_bool.v
//
// tom@fors.net, November 25, 2016
//
// Purpose:
//   Boolean function logic for ALU


module alu_bool (
    input      [31:0] a,
    input      [31:0] b,
    input       [3:0] bfn,

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

generate
    genvar i;
    for (i=0; i<32; i=i+1) begin: loop_gen_block
        assign y[i] = mux4(bfn, {b[i], a[i]});
    end
endgenerate

endmodule
