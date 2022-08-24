`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/04 11:32:01
// Design Name: 
// Module Name: register_mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_mux(
    input wire[4:0] Ain,
    input wire[4:0] Bin,
    input wire En,
    output reg [4:0] out
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
