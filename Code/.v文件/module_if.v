//////////////////////////////////////////////////////////////////////
// Module:  module_if
// Author:      Buwei Zhou
// Description: 取指模块
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module module_if(

    input wire   clock,
    input wire   reset,
    
    // 增加
    // input wire PCSrc,
    input wire[`InstAddrBus] if_pc_i, 
    input wire PCSrc,

	output wire   [`InstAddrBus]        id_pc_o,          // 译码阶段取得的指令对应的地址
	output wire   [`InstBus]            id_inst_o        // 译码阶段取得的指令
    
    );


    wire  [`InstAddrBus]        pc_i;             // 要读取的指令地址 
    
    wire  [`InstBus]            inst_o;           // 读出的指令   
        
    pc_reg pc_reg0(
        .clk(clock),
        .rst(reset),
        .PCSrc(PCSrc),  // 增加
        .pc_in(if_pc_i),    // 增加
        .pc(pc_i)
    );
    
    inst_rom inst_rom0(
        .rst(reset),
        .addr(pc_i),
        .inst(inst_o)
    );

    if_id if_id0(
        .clk(clock),
        .rst(reset),
        .if_pc(pc_i),
        .if_inst(inst_o),
        .id_pc(id_pc_o),
        .id_inst(id_inst_o)
    );
     
endmodule