//////////////////////////////////////////////////////////////////////
// Module:  module_mem
// Author:      Buwei Zhou
// Description: 访存模块
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module module_mem(
    
	input  wire                    rst,             // 复位信号，高电平有效
	input  wire                    clk,             // 时钟信号
	input  wire [`DataAddrBus]     addr,            // 存储器的读写地址
	input  wire [`DataBus]         wdata,           // 要写入的数据
//	input  wire                    rden,            // 读取使能            
//	input  wire                    wren,            // 写入使能 
	input  wire  [`RegAddrBus]     waddr,     
	input  wire  [`DataBus]        result,           // ALU运算结果要写入的数据
    input  wire                    mem_MemRead_i,    
    input  wire                    mem_MemtoReg_i,   
    input  wire                    mem_MemWrite_i,       
    input  wire                    mem_RegWrite_i,    
	
    output wire   [`DataBus]        wb_rdata,            // 写回阶段数据存储器读取输出的数据                    
    output wire   [`RegBus]         wb_result,           // 写回阶段的ALU运算结果                        
    output wire   [`RegAddrBus]     wb_waddr,            // 写回阶段的指令要写入的目的寄存器地址，inst[4:0]        
    output wire                     wb_MemtoReg_o ,
    output wire                     wb_RegWrite_o 
    
    );
    
    wire [`DataBus]         rdata;
    
    data_rom data_rom0(
        rst,            
        clk,            
        addr,           
        wdata,          
        mem_MemRead_i,           
        mem_MemWrite_i,           
        rdata        
        );
        
    mem_wb mem_wb0(
        
        rst,                  // 复位信号，高电平有效       
        clk,                  // 时钟信号 
          
        rdata,               // 访存阶段数据存储器读取输出的数据 
        result,           // 访存阶段的ALU运算结果           
        waddr,            // 访存阶段的指令要写入的目的寄存器地址，inst[4:0] 
        mem_MemtoReg_i,
        mem_RegWrite_i,                                                                                           
             
        wb_rdata,            // 写回阶段数据存储器读取输出的数据                    
        wb_result,           // 写回阶段的ALU运算结果                        
        wb_waddr,             // 写回阶段的指令要写入的目的寄存器地址，inst[4:0]        
        wb_MemtoReg_o , 
        wb_RegWrite_o 
    
        );
    
endmodule
