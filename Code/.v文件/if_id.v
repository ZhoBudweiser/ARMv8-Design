//////////////////////////////////////////////////////////////////////
// Module:  if_id
// Author:  Buwei Zhou
// Description: IF/ID阶段的寄存器
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module if_id(

	input  wire                            clk,        // 时钟信号 
	input  wire                            rst,        // 复位信号 
	                                               
	input  wire    [`InstAddrBus]          if_pc,      // 取指阶段取得的指令对应的地址
	input  wire    [`InstBus]              if_inst,    // 取指阶段取得的指令
	                                          
	output reg     [`InstAddrBus]          id_pc,      // 译码阶段取得的指令对应的地址
	output reg     [`InstBus]              id_inst     // 译码阶段取得的指令
	
);

	always @ (posedge clk) begin
        if (rst == `RstEnable) begin
			id_pc <= `ZeroWord;
			id_inst <= `InstZeroWord;
        end else begin
		  id_pc <= if_pc;
		  id_inst <= if_inst;
		end
	end

endmodule