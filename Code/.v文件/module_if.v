//////////////////////////////////////////////////////////////////////
// Module:  module_if
// Author:      Buwei Zhou
// Description: ȡָģ��
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module module_if(

    input wire   clock,
    input wire   reset,
    
    // ����
    // input wire PCSrc,
    input wire[`InstAddrBus] if_pc_i, 
    input wire PCSrc,

	output wire   [`InstAddrBus]        id_pc_o,          // ����׶�ȡ�õ�ָ���Ӧ�ĵ�ַ
	output wire   [`InstBus]            id_inst_o        // ����׶�ȡ�õ�ָ��
    
    );


    wire  [`InstAddrBus]        pc_i;             // Ҫ��ȡ��ָ���ַ 
    
    wire  [`InstBus]            inst_o;           // ������ָ��   
        
    pc_reg pc_reg0(
        .clk(clock),
        .rst(reset),
        .PCSrc(PCSrc),  // ����
        .pc_in(if_pc_i),    // ����
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