//////////////////////////////////////////////////////////////////////
// Module:  mem_wb
// Author:      Buwei Zhou
// Description: �ô�/д�ؽ׶���ˮ�߼Ĵ���
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module mem_wb(
    
    input  wire                    rst,                  // ��λ�źţ��ߵ�ƽ��Ч       
    input  wire                    clk,                  // ʱ���ź�   
    
    input  wire [`DataBus]         mem_rdata,            // �ô�׶����ݴ洢����ȡ��������� 
    input  wire [`RegBus]          mem_result,           // �ô�׶ε�ALU������           
    input  wire [`RegAddrBus]      mem_waddr,            // �ô�׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ��inst[4:0]
    input  wire                    mem_MemtoReg ,
    input  wire                    mem_RegWrite ,                                                                                         
         
    output reg   [`DataBus]        wb_rdata,            // д�ؽ׶����ݴ洢����ȡ���������                    
    output reg   [`RegBus]         wb_result,           // д�ؽ׶ε�ALU������                        
    output reg   [`RegAddrBus]     wb_waddr,            // д�ؽ׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ��inst[4:0]        
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
