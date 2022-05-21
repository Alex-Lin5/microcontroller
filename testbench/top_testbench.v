`timescale 1ns/1ps
module MCU_testbench(
);
parameter ADDRESSLEN = 64;
reg clk, clb, clkdut;
reg [7:0] inst_mem [ADDRESSLEN-1:0];
reg [7:0] out_mem [ADDRESSLEN-1:0];
reg [7:0] memaddress;
reg [7:0] expected;
wire [7:0] instru;
wire [7:0] pcaddr;
wire [7:0] result;
initial begin
    $readmemh("im_hex.txt", inst_mem);
    $readmemh("output_hex.txt", out_mem);
    {clk, clkdut} = 0;
    clb = 0;
    #5 memaddress[ADDRESSLEN-1:0] = 0-1;
    #28 clb = 1;
    #1100 clb = 0;
    #20 clb = 1;
end
assign instru = inst_mem [pcaddr][7:0];
assign expected = out_mem[memaddress][7:0];
always begin
	#5 clk = ~clk;
end
always @(posedge clk) begin
    clkdut = ~clkdut;
end

always @(posedge clkdut) begin
    if (clb)
        memaddress <= memaddress + 1;
    else 
        memaddress <= 0 - 1;
    if(result !== expected || result === 8'bx)
        $error("Memaddr=8d%d, PCaddr=8d%d, InHex=8h%h, result=%h, expected=%h\n", memaddress, pcaddr, inst_mem[pcaddr], result, expected);
    else
        $display($time, " correct results: Memaddr=8d%d, InMem=8h%h, result=%h\n", memaddress, inst_mem[pcaddr], result);
end

processor dut(
    .clk(clk),
    .clb(clb),
    .instruction(instru),
    .pc(pcaddr),
    .acc(result)
);
endmodule