// accumulator
module accumulator(
    output wire [7:0] accout,
    input wire [7:0] aluin,
    input wire [7:0] regin,
    input wire [3:0] imm,
    input wire [1:0] selacc,
    input wire clk,
    input wire clb,
    input wire loadacc
);

reg [7:0] acc;
assign accout = acc;

always @(posedge clk or negedge clb) begin
    if(clb == 1'b0)
        acc <= 8'b0;
    else if (loadacc == 1'b1) begin
        case(selacc)
            2'b00: acc <= aluin;
            2'b11: acc <= {4'b0, imm};
            2'b10: acc <= regin;
        endcase
    end
end

endmodule