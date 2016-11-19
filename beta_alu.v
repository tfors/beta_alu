// beta_alu.v
//
// tom@fors.net, November 19, 2016
//
// Purpose:
//   32-bit ALU for Beta CPU


module beta_alu (
	input             clk,
	input             reset,

	output reg [31:0] counter
);

always @(posedge clk) begin
	if (reset == 1) begin
		counter <= 0;
	end else begin
		counter <= counter + 1;
	end
end

endmodule
