//////////////////////////////////////////////////////////////////////
// Module:  ex_mem
// Author:  Buwei Zhou
// Description: EX/MEM阶段的流水线寄存器
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module ex_mem(

	input  wire								clk,           // 复位信号，高电平有效
	input  wire								rst,           // 时钟信号
	                                               
	//来自执行阶段的信息	                                      
	input  wire    [`FlagBus]              ex_flags,    // 执行阶段的结果0标志位
	input  wire    [`RegBus]               ex_result,      // 执行阶段的ALU运算结果
	input  wire    [`RegBus]               ex_reg2,        // 执行阶段的参与运算的源操作数2
	input  wire    [`RegAddrBus]           ex_waddr,	 	// 执行阶段的指令要写入的目的寄存器地址，inst[4:0]      
    input  wire                            ex_MemRead,   
    input  wire                            ex_MemtoReg,  
    input  wire                            ex_MemWrite,     
    input  wire                            ex_RegWrite,
    
	input  wire    [`InstAddrBus]          ex_add_result,     // 加法器的运算结果
	input  wire                            ex_isZeroBranch, 	// M Stage
    input  wire                            ex_isUnconBranch, 	// M Stage
    input  wire                            ex_isNZBranch,  
		
	//送到访存阶段的信息
	output  reg    [`FlagBus]              mem_flags,    // 访存阶段的结果0标志位
	output  reg    [`RegBus]               mem_result,      // 访存阶段的ALU运算结果
	output  reg    [`RegBus]               mem_reg2,        // 访存阶段的参与运算的源操作数2
	output  reg    [`RegAddrBus]           mem_waddr,  	// 访存阶段的指令要写入的目的寄存器地址，inst[4:0]    
    output  reg                            mem_MemRead,   
    output  reg                            mem_MemtoReg,  
    output  reg                            mem_MemWrite,     
    output  reg                            mem_RegWrite,
    
	output  reg    [`InstAddrBus]          mem_add_result,
	output  reg                            mem_isZeroBranch, 	// M Stage
    output  reg                            mem_isUnconBranch, // M Stage
    output  reg                            mem_isNZBranch    
	
);

	always @ (posedge clk) begin
		if(rst == `RstEnable) begin
			mem_waddr    <= `NOPRegAddr;
			mem_flags    <= `FlagReset;
            mem_result   <= `ZeroWord;
            mem_reg2     <= `ZeroWord;
            mem_MemRead  <= `False_v;
            mem_MemtoReg <= `False_v;
            mem_MemWrite <= `False_v;
            mem_RegWrite <= `False_v;
            mem_add_result      <=  `ZeroWord;
            mem_isZeroBranch	<=  `False_v;
            mem_isUnconBranch   <=  `False_v;
            mem_isNZBranch      <=  `False_v;
		end else begin
			mem_waddr    <=  ex_waddr;         
			mem_flags    <=  ex_flags;    
            mem_result   <=  ex_result;  
            mem_reg2     <=  ex_reg2; 
            mem_MemRead  <=  ex_MemRead ;
            mem_MemtoReg <=  ex_MemtoReg;
            mem_MemWrite <=  ex_MemWrite;
            mem_RegWrite <=  ex_RegWrite;
            mem_add_result      <=  ex_add_result    ;
            mem_isZeroBranch	<=  ex_isZeroBranch  ;
            mem_isUnconBranch   <=  ex_isUnconBranch ;
            mem_isNZBranch      <=  ex_isNZBranch    ;
		end
	end		

endmodule