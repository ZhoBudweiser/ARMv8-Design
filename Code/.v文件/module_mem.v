//////////////////////////////////////////////////////////////////////
// Module:  module_mem
// Author:      Buwei Zhou
// Description: �ô�ģ��
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module module_mem(
    
	input  wire                    rst,             // ��λ�źţ��ߵ�ƽ��Ч
	input  wire                    clk,             // ʱ���ź�
	input  wire [`DataAddrBus]     addr,            // �洢���Ķ�д��ַ
	input  wire [`DataBus]         wdata,           // Ҫд�������
//	input  wire                    rden,            // ��ȡʹ��            
//	input  wire                    wren,            // д��ʹ�� 
	input  wire  [`RegAddrBus]     waddr,     
	input  wire  [`DataBus]        result,           // ALU������Ҫд�������
    input  wire                    mem_MemRead_i,    
    input  wire                    mem_MemtoReg_i,   
    input  wire                    mem_MemWrite_i,       
    input  wire                    mem_RegWrite_i,    
	
    output wire   [`DataBus]        wb_rdata,            // д�ؽ׶����ݴ洢����ȡ���������                    
    output wire   [`RegBus]         wb_result,           // д�ؽ׶ε�ALU������                        
    output wire   [`RegAddrBus]     wb_waddr,            // д�ؽ׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ��inst[4:0]        
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
        
        rst,                  // ��λ�źţ��ߵ�ƽ��Ч       
        clk,                  // ʱ���ź� 
          
        rdata,               // �ô�׶����ݴ洢����ȡ��������� 
        result,           // �ô�׶ε�ALU������           
        waddr,            // �ô�׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ��inst[4:0] 
        mem_MemtoReg_i,
        mem_RegWrite_i,                                                                                           
             
        wb_rdata,            // д�ؽ׶����ݴ洢����ȡ���������                    
        wb_result,           // д�ؽ׶ε�ALU������                        
        wb_waddr,             // д�ؽ׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ��inst[4:0]        
        wb_MemtoReg_o , 
        wb_RegWrite_o 
    
        );
    
endmodule
