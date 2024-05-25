module Adder(
    input logic [31:0] a, b,
    output logic [31:0] y
);
    assign y = a + b;
endmodule

module Alu(
    input logic [3:0] aluControl,
    input logic [31:0] op1, op2,
    output logic [31:0] aluOut,
    output logic isZero
);
    always_comb 
        case (aluControl)
            4'b0000: aluOut = op1 & op2;
            4'b0001: aluOut = op1 | op2;
            4'b0010: aluOut = op1 + op2;
            4'b0110: aluOut = op1 - op2;
            default: aluOut = 32'b0;
        endcase
    assign isZero = ~|aluOut;   
endmodule

module AluControl(
    input logic [3:0] in,
    input logic [1:0] ALUOp,
    output logic [3:0] aluControl
);  // Fig 4.13 from the book
    always_comb 
        casez({ALUOp,in})
            6'b00????: aluControl = 4'b0010;
            6'b?1????: aluControl = 4'b0110;
            6'b1?0000: aluControl = 4'b0010;
            6'b1?1000: aluControl = 4'b0110;
            6'b1?0111: aluControl = 4'b0000;
            6'b1?0110: aluControl = 4'b0001;
            default: aluControl = 4'b1111;
        endcase
endmodule

module Control(
    input logic [6:0] opcode,
    output logic [1:0] ALUOp,
    output logic RegWrite,ALUSrc,memToReg, Branch, MemRead, MemWrite
);  // Figure 4.22 from the book
    always_comb 
        case(opcode)
            7'b0110011: begin ALUOp = 2'b10; RegWrite = 1; ALUSrc = 0; memToReg = 0; Branch = 0; MemRead = 0; MemWrite = 0; end
            7'b0000011: begin ALUOp = 2'b00; RegWrite = 1; ALUSrc = 1; memToReg = 1; Branch = 0; MemRead = 1; MemWrite = 0; end
            7'b0100011: begin ALUOp = 2'b00; RegWrite = 0; ALUSrc = 1; memToReg = 1; Branch = 0; MemRead = 0; MemWrite = 1; end
            7'b1100011: begin ALUOp = 2'b01; RegWrite = 0; ALUSrc = 0; memToReg = 0; Branch = 1; MemRead = 0; MemWrite = 0; end
            default: begin ALUOp = 2'b00; RegWrite = 0; ALUSrc = 0; memToReg = 0; Branch = 0; MemRead = 0; MemWrite = 0; end
        endcase
endmodule

module DataMemory(
    input logic clk, 
    input logic MemRead,MemWrite,
    input logic [31:0] a, wd,
    output logic [31:0] rd
);
    logic [31:0] RAM[0:255];
    always_ff @(posedge clk) begin
        if(MemWrite) RAM[a[31:2]] <= wd;
    end
    assign rd = RAM[a[31:2]];  // it is word aligned
endmodule

module IMemory(
    input logic [31:0] a,
    output logic [31:0] rd
);
    logic [31:0] ROM[0:31];
    assign rd = ROM[a[31:2]];
endmodule

module ImmGen (
    input logic [31:0] i, // instruction
    output logic [31:0] imm
);
    logic [31:0] I_imm,SB_imm,S_imm;
    logic [6:0] opcode;
    assign opcode = i[6:0];
    assign I_imm = {{21{i[31]}},i[30:20]};
    assign SB_imm = {{20{i[31]}},i[7],i[30:25],i[11:8],1'b0};
    assign S_imm = {{21{i[31]}},i[30:25],i[11:7]};
    always_comb 
        case(opcode)
            7'b0000011: imm = I_imm;  // lw
            7'b1100011: imm = SB_imm; // beq
            7'b0100011: imm = S_imm;  // sw
            default: imm = 0;
        endcase
endmodule

module PC(
    input logic clk, 
    input logic [31:0] inPC,
    output logic [31:0] outPC);
    initial // in synthesizable implementation, would use reset
        outPC = 0;
    always_ff @(posedge clk)
        outPC <= inPC; 
endmodule

module RegisterFile(
    input logic clk, RegWrite,
    input logic [4:0] ra1, ra2, wa3,
    input logic [31:0] wd3,
    output logic [31:0] rd1, rd2
);
    logic [31:0] rf[31:0];
    initial begin // in synthesizable implementation, would use reset
        for (int v = 0;v < 32 ; v++ ) begin
            rf[v] = 0;
        end
    end
    always_ff @(posedge clk)
        if (RegWrite) rf[wa3] <= wd3;
    assign rd1 = (ra1 != 5'b0) ? rf[ra1] : 32'b0;
    assign rd2 = (ra2 != 5'b0) ? rf[ra2] : 32'b0;
endmodule

module CPU(
    input logic clk,
    output logic done);
    logic RegWrite, isZero,ALUSrc,memToReg, Branch, MemRead, MemWrite, PCSrc;
    logic [1:0] ALUOp;
    logic [3:0] aluCntrl;
    logic [4:0] ra1,ra2,wa3;
    logic [31:0] outPC,instruction, ALUout, memOut,rd1,rd2, imm, branchPC, normalPC, newPC, wd3, alu2;

    assign done = instruction == 'h00000033; // finish 

    // The Mux-es
    assign PCSrc = Branch & isZero;
    assign newPC = PCSrc ? branchPC : normalPC;
    assign wd3   = memToReg ? memOut : ALUout;
    assign alu2  = ALUSrc ? imm : rd2;

    // Some abbreviations
    assign ra1   = instruction[19:15];
    assign ra2   = instruction[24:20];
    assign wa3   = instruction[11:7];

    // All the components
    PC PC(clk, newPC, outPC);
    Adder Add4(4, outPC, normalPC);
    Adder PCAdd(imm, outPC, branchPC);
    IMemory IMemory(outPC, instruction);
    RegisterFile Registers(clk, RegWrite, ra1, ra2, wa3, wd3, rd1, rd2);
    AluControl AluControl({instruction[30],instruction[14:12]}, ALUOp, aluCntrl);
    Alu Alu(aluCntrl, rd1, alu2, ALUout, isZero);
    Control Control(instruction[6:0], ALUOp, RegWrite, ALUSrc, memToReg, Branch, MemRead, MemWrite);
    ImmGen ImmGen(instruction, imm);
    DataMemory DataMemory(clk, MemRead, MemWrite, ALUout, rd2, memOut);
endmodule