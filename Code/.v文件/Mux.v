//////////////////////////////////////////////////////////////////////
// Module:  WB_Mux
// Author:      Zhe Xv
// Description: ±È½ÏÆ÷
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module Mux(
    input wire[63:0] Ain,
    input wire[63:0] Bin,
    input wire En,
    output reg [63:0] out
    );
    
    always @(*) begin
        if (En == `True_v) begin
            out <= Ain;
        end
        else begin
            out <= Bin;
        end
    end
    
endmodule
