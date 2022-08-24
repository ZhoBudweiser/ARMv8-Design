//////////////////////////////////////////////////////////////////////
// Module:          pc_reg
// Author:          Buwei Zhou
// Description:     指令指针寄存器PC
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module pc_reg(

    input   wire                        clk,        // 时钟信号  
    input   wire                        rst,        // 复位信号   
    
    input wire PCSrc,  // 增加
    input wire[`InstAddrBus] pc_in, 

    output  reg     [`InstAddrBus]      pc         // 要读取的指令地址
	
);

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			pc <= 64'h0000000000000000;
		end else begin
	 		if (PCSrc == 1'b1) begin
	 		    pc <= pc_in;
	 		end
	 		else begin 
	 		    pc <= pc + 4;
	 		end
		end
	end
	

endmodule