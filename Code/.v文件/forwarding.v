//////////////////////////////////////////////////////////////////////
// Module:  forwarding
// Author:      Buwei Zhou
// Description: ÅÔÂ·¿ØÖÆÆ÷
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module forwarding(

    input   wire    [`RegAddrBus]    Rn,
    input   wire    [`RegAddrBus]    Rm,
    input   wire    [`RegAddrBus]    ex_Rd,
    input   wire    [`RegAddrBus]    mem_Rd,
    input   wire                     ex_RegWrite,
    input   wire                     mem_RegWrite,
    
    output  reg     [`ForwardBus]    Fa,
    output  reg     [`ForwardBus]    Fb
    
    );
    
    always @(*) begin
        Fa <= 2'b00;
        Fb <= 2'b00;
        if (ex_RegWrite && (ex_Rd != 5'd31) && (ex_Rd == Rn)) begin
            Fa <= 2'b10;   
        end                
        if (ex_RegWrite && (ex_Rd != 5'd31) && (ex_Rd == Rm)) begin
            Fb <= 2'b10;
        end
        if (mem_RegWrite && (mem_Rd != 5'd31) && (mem_Rd == Rn)
            && !(ex_RegWrite && (ex_Rd != 5'd31) && (ex_Rd == Rn))
        ) begin
            Fa <= 2'b01;
        end 
        if (mem_RegWrite && (mem_Rd != 5'd31) && (mem_Rd == Rm)
            && !(ex_RegWrite && (ex_Rd != 5'd31) && (ex_Rd == Rm))
        ) begin
            Fb <= 2'b01;
        end
    end
    
endmodule
