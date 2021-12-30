`timescale 1ns/1ps //ALU 
module ALU (
    input [7:0] a,
    input [7:0] b,
    input [1:0] ALU_sel,
    input [1:0] load_shift,
    input loadAlu,
    output [7:0] result,
    output cout,
    output zout
);
//Declare any necessary registers or wires
// wire [1:0] ALU_sel, load_shift;
// wire [7:0] result;
// wire cout, zout;
reg [7:0] alu_out, aluout2;
reg carryout, zeroflag, borrow;

//Complete this part to specify ALU behavior 
// always @(a or b or ALU_sel or load_shift) begin
always @(loadAlu == 1) begin
    if (ALU_sel == 2'b10 & load_shift == 2'b00) begin
        alu_out <= alu_out;
        // aluout2 <= aluout2;
        // a <= a;
        // b <= b;
    end
    else 
        {carryout, borrow} <= 2'b01;    
    if (ALU_sel == 2'b10 & load_shift !== 2'b00 ) begin
        {carryout, alu_out} <= a + b;  
    end
    else if (ALU_sel == 2'b11 ) begin
        {borrow, alu_out} <= {1'b1, a} - b;
    end
    else if (ALU_sel == 2'b01 )
        alu_out <= ~(a | b);
    else if (ALU_sel == 2'b00 ) begin
        if (load_shift == 2'b11 )
            alu_out <= a >> 1;
        else if (load_shift == 2'b01 )
            alu_out <= a << 1;
        else if (load_shift == 2'b10 )
            alu_out <= a;
        else if (load_shift == 2'b00 ) begin
            alu_out <= 8'b0;
        end
    end    
end

// always @(alu_out) begin
//     aluout2 <= alu_out;
// end


assign zout = (alu_out) ? 1'b0 : 1'b1;
assign result = alu_out;
assign cout = carryout | ~borrow;
endmodule

