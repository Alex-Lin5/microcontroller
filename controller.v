// Controller FSM
module controller(
    input wire zflag,
    input wire cflag,
    input wire clk,
    input wire clb,
    input wire [3:0] opcode,
    output reg loadIR,
    output reg incPC,
    output reg selPC,
    output reg loadPC,
    output reg loadReg,
    output reg loadAcc,
    output reg loadAlu,
    output reg [1:0] selAcc,
    output reg [3:0] selAlu
);

parameter INITIAL=2'b00, FETCH=2'b01, EXECUTE=2'b11;

reg [1:0] current_state, next_state;
always @(negedge clb or posedge clk) begin
    if (clb==0)
        current_state <= INITIAL;
    else
        current_state <= next_state;
end

always @(*) begin
    case(current_state)
        INITIAL: begin
            {incPC, selPC, loadPC} <= 0;
            {loadReg, loadAcc, loadIR, loadAlu} <= 0;
            {selAcc, selAlu} <= 0;
            // loadIR <= 1;
            next_state <= FETCH;
        end
        FETCH: begin
            loadPC <= 0;
            incPC <= 0;
            {loadAcc, loadReg} <= 0;
            selAcc <= 2'b0;  
            loadAlu <= 0;
            loadIR <= 1;
            selAlu <= 4'b1000; // aluout stay still
            next_state <= EXECUTE;
        end
        EXECUTE: begin
            incPC <= 1;
            // loadPC <= 0;
            // {loadIR, loadAcc} <= 2'b01;
            loadIR <= 0;
            case(opcode)
                4'b0000: begin //NOP
                    loadPC <= 0;
                    incPC <= 1;
                end
                4'b1111: begin //HALT
                    loadPC <= 0;
                    incPC <= 0;
                end
                4'b0001: begin //ADD
                    selAlu <= 4'b1001; // 4'b10x1
                    selAcc <= 2'b00;  // 2'b0x
                    // selPC <= 1;  
                    loadPC <= 0;
                    loadAcc <= 1;
                    loadAlu <= 1;
                    // loadReg <= 1;
                end
                4'b0010: begin //SUB
                    selAlu <= 4'b1100; //4'b11xx
                    selAcc <= 2'b00; //2'b0x
                    // selPC <= 1;  
                    loadPC <= 0;
                    loadAcc <= 1;
                    loadAlu <= 1;
                end
                4'b0011: begin //NOR
                    selAlu <= 4'b0100; //4'b01xx
                    selAcc <= 2'b00; //2'b0x
                    selPC <= 1;           
                    loadPC <= 0;
                    loadAcc <= 1;
                    loadAlu <= 1;
                end
                4'b0100: begin //MOV REG2ACC
                    // selPC <= 1;              
                    loadPC <= 0;
                    selAcc <= 2'b10;
                    loadAcc <= 1;
                end
                4'b0101: begin //MOV ACC2REG
                    // selPC <= 1;              
                    loadPC <= 0;
                    loadReg <= 1;
                end
                4'b1011: begin //SHL
                    selAlu <= 4'b0001;
                    selAcc <= 2'b00; // 2'b0x       
                    loadPC <= 0;
                    loadAcc <= 1;
                    loadAlu <= 1;
                end
                4'b1100: begin //SHR
                    selAlu <= 4'b0011;
                    selAcc <= 2'b00; // 2'b0x
                    loadPC <= 0;   
                    loadAcc <= 1;    
                    loadAlu <= 1;    
                end
                4'b1101: begin //LDIMM
                    selAcc <= 2'b11;
                    loadAcc <= 1;
                    // selPC <= 0;  
                    // loadPC <= 0;
                end
                4'b0110: begin //JZ rs zflag
                    selPC <= 1;
                    if(zflag == 1)
                        loadPC <= 1;
                    else
                        loadPC <= 0;
                end
                4'b0111: begin //JZ imm zflag
                    selPC <= 0;
                    if(zflag == 1)
                        loadPC <= 1;
                    else
                        loadPC <= 0;
                end
                4'b1000: begin //JC rs cflag
                    if(cflag == 1)
                        loadPC <= 1;
                    else
                        loadPC <= 0;
                    selPC <= 1;
                end
                4'b1010: begin //JC imm cflag
                    if(cflag == 1)
                        loadPC <= 1;
                    else
                        loadPC <= 0;
                    selPC <= 0;
                end
            endcase
            next_state <= FETCH;
        end
    endcase
end
endmodule