//////////////////////////////////////////////////////////////////////
// Module:  counter
// Author:      Internet* Buwei Zhou
// Description: ��Ƶ��
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"


module counter(
        input clk,
 	 	input rst,
 	 	output clk_bps
 	 	);	
 	 	reg [13:0]cnt_first,cnt_second;
 	 	always @( posedge clk or posedge rst )
 	 	 	if( rst == `RstEnable )
 	 			cnt_first <= 14'd0;
 	 		else if( cnt_first == 14'd10000 )
 	 			cnt_first <= 14'd0;
 	 		else
 	 			cnt_first <= cnt_first + 1'b1;
 	 	always @( posedge clk or posedge rst )
 	 		if( rst == `RstEnable )
 	 			cnt_second <= 14'd0;
 	 		else if( cnt_second == 14'd10000 )
 	 			cnt_second <= 14'd0;
 	 		else if( cnt_first == 14'd10000 )
 	 			cnt_second <= cnt_second + 1'b1;
 	 	assign clk_bps = cnt_second == 14'd10000 ? 1'b1 : 1'b0;
endmodule