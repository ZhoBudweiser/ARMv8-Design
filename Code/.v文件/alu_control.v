//////////////////////////////////////////////////////////////////////
// Module:  alu_control
// Author:  Buwei Zhou
// Description: ‘ÀÀ„∆˜øÿ÷∆
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module alu_control(

  input    wire [`AluOpBus]     aluop,
  input    wire [`OpCodeBus]    opcode,
  output   reg  [`ALUCtlBus]    control,
  output   reg                  setflags
  
);

  always @(aluop or opcode) begin
    setflags = 1'b0;
    control = 4'b1111;
    case (aluop)
      2'b00 : control = 4'b0010;                    // ADD
      2'b01 : begin control = 4'b0111; setflags = 1'b1; end                    // PASS B
      2'b10 : begin
        case (opcode)
          11'b10001011000 : control = 4'b0010;      // ADD
          11'b10101011000 : begin control = 4'b0010; setflags = 1'b1; end     // ADDS
          11'b11001011000 : control = 4'b0110;      // SUB
          11'b11101011000 : begin control = 4'b0110; setflags = 1'b1; end     // SUBS
          11'b10001010000 : control = 4'b0000;      // AND
          11'b11101010000 : begin control = 4'b0000; setflags = 1'b1; end     // ANDS
          11'b10101010000 : control = 4'b0001;      // ORR
          11'b11001010000 : control = 4'b1000;      // EOR
          11'b11010011010 : control = 4'b1010;      // LSR
          11'b11010011011 : control = 4'b1011;      // LSL
          11'b11111000010 : control = 4'b0010;      // LDUR
          11'b11111000000 : control = 4'b0010;      // STUR 
        endcase
        case (opcode[10:1])
          10'b1001000100 : control = 4'b0010;      // ADDI
          10'b1001001000 : control = 4'b0000;      // ANDI
          10'b1011001000 : control = 4'b0001;      // ORRI
          10'b1101000100 : control = 4'b0110;      // SUBI
          10'b1101001000 : control = 4'b1000;      // EORI
          10'b1011000100 : begin control = 4'b0010; setflags = 1'b1; end     // ADDIS
          10'b1111000100 : begin control = 4'b0110; setflags = 1'b1; end     // SUBIS
          10'b1111001000 : begin control = 4'b0000; setflags = 1'b1; end     // ANDIS
        endcase
      end
    endcase
    
//    case (opcode)
//      11'b10101011000 : setflags = 1'b1;      // ADDS
//      11'b11101011000 : setflags = 1'b1;      // SUBS
//      11'b11101010000 : setflags = 1'b1;      // ANDS
//    endcase
//    case (opcode[10:1])
//      10'b1011000100 : setflags = 1'b1;      // ADDIS
//      10'b1111000100 : setflags = 1'b1;      // SUBIS
//      10'b1111001000 : setflags = 1'b1;      // ANDIS
//      default : setflags = 1'b0;
//    endcase 
  end
  
endmodule
