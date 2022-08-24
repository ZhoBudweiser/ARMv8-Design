//////////////////////////////////////////////////////////////////////
// Module:  ex_mem
// Author:  Buwei Zhou
// Description: EX/MEM�׶ε���ˮ�߼Ĵ���
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module ex_mem(

	input  wire								clk,           // ��λ�źţ��ߵ�ƽ��Ч
	input  wire								rst,           // ʱ���ź�
	                                               
	//����ִ�н׶ε���Ϣ	                                      
	input  wire    [`FlagBus]              ex_flags,    // ִ�н׶εĽ��0��־λ
	input  wire    [`RegBus]               ex_result,      // ִ�н׶ε�ALU������
	input  wire    [`RegBus]               ex_reg2,        // ִ�н׶εĲ��������Դ������2
	input  wire    [`RegAddrBus]           ex_waddr,	 	// ִ�н׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ��inst[4:0]      
    input  wire                            ex_MemRead,   
    input  wire                            ex_MemtoReg,  
    input  wire                            ex_MemWrite,     
    input  wire                            ex_RegWrite,
    
	input  wire    [`InstAddrBus]          ex_add_result,     // �ӷ�����������
	input  wire                            ex_isZeroBranch, 	// M Stage
    input  wire                            ex_isUnconBranch, 	// M Stage
    input  wire                            ex_isNZBranch,  
		
	//�͵��ô�׶ε���Ϣ
	output  reg    [`FlagBus]              mem_flags,    // �ô�׶εĽ��0��־λ
	output  reg    [`RegBus]               mem_result,      // �ô�׶ε�ALU������
	output  reg    [`RegBus]               mem_reg2,        // �ô�׶εĲ��������Դ������2
	output  reg    [`RegAddrBus]           mem_waddr,  	// �ô�׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ��inst[4:0]    
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