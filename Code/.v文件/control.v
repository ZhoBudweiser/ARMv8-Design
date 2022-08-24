//////////////////////////////////////////////////////////////////////
// Module:          control
// Author:          Buwei Zhou
// Description:     ¿ØÖÆÆ÷
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module control(
    
    input   wire    [`InstBus]      inst,

    output  reg                    Reg2Loc,
    output  reg                    MemRead,
    output  reg                    MemtoReg,
    output  reg                    MemWrite,
    output  reg                    ALUSrc,
    output  reg                    RegWrite,
    output  reg    [`AluOpBus]     ALUOp,
    
    output reg isZeroBranch,
    output reg isUnconBranch,
    output reg isNZBranch 

    );
    
     wire   [`OpCodeBus]    opcode;
    assign opcode = inst[31:21];
    
    always @ (*) begin
        Reg2Loc           <=     1'b0;        
        MemRead           <=     1'b0;
        MemtoReg          <=     1'b0;
        MemWrite          <=     1'b0;
        ALUSrc            <=     1'b0;
        RegWrite          <=     1'b0;
        ALUOp             <=     `NOPALUop;
        isZeroBranch      <=     1'b0;
        isUnconBranch     <=     1'b0;
        isNZBranch        <=     1'b0;
        case (inst[31:21])
          11'b10001011000 : begin ALUOp <= 2'b10; RegWrite <= 1'b1;  end         // ADD
          11'b10101011000 : begin ALUOp <= 2'b10; RegWrite <= 1'b1;  end         // ADDS
          11'b11001011000 : begin ALUOp <= 2'b10; RegWrite <= 1'b1;  end         // SUB
          11'b11101011000 : begin ALUOp <= 2'b10; RegWrite <= 1'b1;  end         // SUBS
          11'b10001010000 : begin ALUOp <= 2'b10; RegWrite <= 1'b1;  end         // AND
          11'b11101010000 : begin ALUOp <= 2'b10; RegWrite <= 1'b1;  end         // ANDS
          11'b10101010000 : begin ALUOp <= 2'b10; RegWrite <= 1'b1;  end         // ORR
          11'b11001010000 : begin ALUOp <= 2'b10; RegWrite <= 1'b1;  end         // EOR
          11'b11010011010 : begin ALUOp <= 2'b10; RegWrite <= 1'b1;  end         // LSR
          11'b11010011011 : begin ALUOp <= 2'b10; RegWrite <= 1'b1;  end         // LSL
          
          11'b11111000010 : begin ALUSrc<= 1'b1;  MemtoReg <= 1'b1;  
                                  RegWrite <= 1'b1; MemRead <= 1'b1;
                                  ALUOp <= 2'b00;
                            end         // LDUR
          11'b11111000000 : begin Reg2Loc <= 1'b1; ALUSrc<= 1'b1; 
                                  MemWrite <= 1'b1; ALUOp <= 2'b00;
                            end         // STUR
        endcase
        case (inst[31:22])
          10'b1001000100 : begin ALUOp <= 2'b10;  ALUSrc   <= 1'b1;  RegWrite <= 1'b1;  end    // ADDI
          10'b1001001000 : begin ALUOp <= 2'b10;  ALUSrc   <= 1'b1;  RegWrite <= 1'b1;  end    // ANDI
          10'b1011001000 : begin ALUOp <= 2'b10;  ALUSrc   <= 1'b1;  RegWrite <= 1'b1;  end    // ORRI
          10'b1101000100 : begin ALUOp <= 2'b10;  ALUSrc   <= 1'b1;  RegWrite <= 1'b1;  end    // SUBI
          10'b1101001000 : begin ALUOp <= 2'b10;  ALUSrc   <= 1'b1;  RegWrite <= 1'b1;  end    // EORI
          10'b1011000100 : begin ALUOp <= 2'b10;  ALUSrc   <= 1'b1;  RegWrite <= 1'b1;  end    // ADDIS
          10'b1111000100 : begin ALUOp <= 2'b10;  ALUSrc   <= 1'b1;  RegWrite <= 1'b1;  end    // SUBIS
          10'b1111001000 : begin ALUOp <= 2'b10;  ALUSrc   <= 1'b1;  RegWrite <= 1'b1;  end    // ANDIS
        endcase
        
        if (opcode[10:5] == 6'b000101) begin
            // B
            MemtoReg <= 1'bx;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            ALUOp <= 2'b01;
            isZeroBranch <= 1'b0;
            isUnconBranch <= 1'b1;
            RegWrite <= 1'b0;
            isNZBranch <= 1'b0;
        end else if (opcode[10:3] == 8'b10110100) begin
            // CBZ
            MemtoReg <= 1'bx;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            ALUOp <= 2'b01;
            isZeroBranch <= 1'b1;
            isUnconBranch <= 1'b0;
            RegWrite <= 1'b0;
            isNZBranch <= 1'b0;
        end else if (opcode[10:3] == 8'b10110101) begin 
            // CBNZ
            MemtoReg <= 1'bx;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            ALUOp <= 2'b01;
            isZeroBranch <= 1'b0;
            isUnconBranch <= 1'b0;
            RegWrite <= 1'b0;
            isNZBranch <= 1'b1;
        end                                                     
    end                                                               
    
endmodule
