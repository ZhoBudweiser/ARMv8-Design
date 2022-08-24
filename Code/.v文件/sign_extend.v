//////////////////////////////////////////////////////////////////////
// Module:  WB_Mux
// Author:      Zhe Xu
// Description: ·ûºÅÍØÕ¹
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module sign_extend(

    input wire[`InstBus] inst,
    output reg [`ImmBus] imm

    );
    
    always @ (*) begin
        imm[`ImmBus] = `ZeroWord;
        if (inst[31:26] == 6'b000101) begin                             // B
            imm[25:0] = inst[25:0];
            imm[63:26] = {64{imm[25]}};
        end else if (inst[31:24] == 8'b10110100) begin                  // CBZ
            imm[19:0] = inst[23:5];
            imm[63:20] = {64{imm[19]}};
        end else if (inst[31:24] == 8'b10110101) begin                  // CBNZ
            imm[19:0] = inst[23:5];
            imm[63:20] = {64{imm[19]}};
        end else begin                                                  // I
            case (inst[31:21])
                11'b11111000010 : imm = {{55{inst[20]}}, inst[20:12]};    // LDUR
                11'b11111000000 : imm = {{55{inst[20]}}, inst[20:12]};    // STUR   
            endcase      
            case (inst[31:22])
                10'b1001000100 : imm = {52'b0, inst[21:10]};    // ADDI
                10'b1001001000 : imm = {52'b0, inst[21:10]};    // ANDI
                10'b1011001000 : imm = {52'b0, inst[21:10]};    // ORRI
                10'b1101000100 : imm = {52'b0, inst[21:10]};    // SUBI
                10'b1101001000 : imm = {52'b0, inst[21:10]};    // EORI
                10'b1011000100 : imm = {52'b0, inst[21:10]};    // ADDIS
                10'b1111000100 : imm = {52'b0, inst[21:10]};    // SUBIS
                10'b1111001000 : imm = {52'b0, inst[21:10]};    // ANDIS     
            endcase
        end
    end
endmodule
