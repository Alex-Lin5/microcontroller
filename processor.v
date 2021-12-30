module processor (
    input wire clk,
    input wire clb,
    input wire [7:0] instruction,
    output wire [7:0] pc,
    output wire [7:0] acc
);

wire [7:0] aluout;
wire [3:0] selalu;
wire zflag, cflag;
wire [7:0] irout;
wire [7:0] regout;
// wire [3:0] imm;
wire [1:0] selacc;
wire loadir, incrpc, selpc, loadpc, loadreg, loadacc, loadalu;

// reg [7:0] raluout;
// reg clk2=0;
// always @(posedge clk) begin
//     clk2 <= ~clk2;
// end
// always @(negedge clk2) begin
//     raluout = aluout;
// end

// assign (clk2)? raluout = aluout: ;
ALU ALU_unit(
    .a(acc),
    .b(regout),
    .ALU_sel(selalu[3:2]),
    .load_shift(selalu[1:0]),
    .loadAlu(loadalu),
    .result(aluout),
    .cout(cflag),
    .zout(zflag)
);

// wire loadacc;
accumulator ac_unit(
    .accout(acc),
    .aluin(aluout),
    .regin(regout),
    .imm(irout[3:0]),
    .selacc(selacc),
    .clk(clk),
    .clb(clb),
    .loadacc(loadacc)
);

// reg [3:0] opcode;
controller controller_unit(
    .zflag(zflag),
    .cflag(cflag),
    .clk(clk),
    .clb(clb),
    .opcode(irout[7:4]),
    .loadIR(loadir),
    .incPC(incrpc),
    .selPC(selpc),
    .loadPC(loadpc),
    .loadReg(loadreg),
    .loadAcc(loadacc),
    .loadAlu(loadalu),
    .selAcc(selacc),
    .selAlu(selalu)
);

program_counter pc_unit(
    .address(pc),
    .regIn(regout),
    .imm(irout[3:0]),
    .CLB(clb),
    .clk(clk),
    .IncPC(incrpc),
    .LoadPC(loadpc),
    .selPC(selpc)
); 

reg_file rf_unit(
    .reg_out(regout),
    .reg_in(acc),
    .RegAddr(irout[3:0]),
    .clk(clk),
    .CLB(clb),
    .LoadReg(loadreg)
);

IR ir_unit(
    .I(irout),
    .clk(clk),
    .CLB(clb),
    .LoadIR(loadir),
    .Instruction(instruction)
);

endmodule