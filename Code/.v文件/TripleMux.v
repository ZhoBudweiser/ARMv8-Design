//////////////////////////////////////////////////////////////////////
// Module:  Triple
// Author:      Buwei Zhou
// Description: ÈýÂ·Ñ¡ÔñÆ÷
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module TripleMux(

    input wire[`DataBus] Ain,
    input wire[`DataBus] Bin,
    input wire[`DataBus] Cin,
    input wire [1:0] En,
    output reg [`DataBus] out
    
    );
    
    always @(*) begin
        if (En == 2'b00) begin
            out <= Ain;
        end else if (En == 2'b01) begin
            out <= Bin;
        end else if (En == 2'b10) begin
            out <= Cin;
//        end else if (En == 2'b11) begin
//            out <= Bin;
        end
    end
    
endmodule
