//////////////////////////////////////////////////////////////////////
// Module:  mem_wb
// Author:      Buwei Zhou
// Description: 访存/写回阶段流水线寄存器
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module mem_wb(
    
    input  wire                    rst,                  // 复位信号，高电平有效       
    input  wire                    clk,                  // 时钟信号   
    
    input  wire [`DataBus]         mem_rdata,            // 访存阶段数据存储器读取输出的数据 
    input  wire [`RegBus]          mem_result,           // 访存阶段的ALU运算结果           
    input  wire [`RegAddrBus]      mem_waddr,            // 访存阶段的指令要写入的目的寄存器地址，inst[4:0]
    input  wire                    mem_MemtoReg ,
    input  wire                    mem_RegWrite ,                                                                                         
         
    output reg   [`DataBus]        wb_rdata,            // 写回阶段数据存储器读取输出的数据                    
    output reg   [`RegBus]         wb_result,           // 写回阶段的ALU运算结果                        
    output reg   [`RegAddrBus]     wb_waddr,            // 写回阶段的指令要写入的目的寄存器地址，inst[4:0]        
    output reg                     wb_MemtoReg ,
    output reg                     wb_RegWrite 


    );
    
	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			wb_rdata     <= `ZeroWord;
			wb_result    <= `ZeroWord;
			wb_waddr     <= `NOPRegAddr;
			wb_MemtoReg <=  `False_v;
            wb_RegWrite <=  `False_v;		
		end else begin		
			wb_rdata     <= mem_rdata ;
			wb_result    <= mem_result;
			wb_waddr     <= mem_waddr ;
			wb_MemtoReg <=  mem_MemtoReg;
            wb_RegWrite <=  mem_RegWrite;	
//			wb_rdata     <= 64'h7;
//			wb_result    <= 64'h8;
//			wb_waddr     <= 5'h3;				
		end
	end
	
endmodule
