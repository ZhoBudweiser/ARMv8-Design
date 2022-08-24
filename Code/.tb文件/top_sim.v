`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/05 10:58:54
// Design Name: 
// Module Name: top_sim
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

`timescale 1ns / 1ps
`include "defines.v"

module top_sim();

    reg     clock       =  1'b1;
    reg     reset       =  1'b0;
    

    top top(
        clock,
        reset
        );
    
    initial begin
        #100   reset = 1'b1;
        #6000
        $stop;       
    end
    always #50 clock = ~clock; 
    
endmodule
