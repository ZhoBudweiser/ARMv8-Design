//////////////////////////////////////////////////////////////////////
// Module:  id_ex
// Author:  Buwei Zhou
// Description: ID/EX�׶εļĴ���
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module id_ex(

	input  wire                        clk,            // ��λ�źţ��ߵ�ƽ��Ч
	input  wire                        rst,            // ʱ���ź�
	                                                   
	//������׶δ��ݵ���Ϣ                                        
	input  wire    [`OpCodeBus]        id_opcode,      // ����׶ε�ָ��Ĳ������ֶΣ�inst[31:21]
	input  wire    [`RegAddrBus]       id_waddr,       // ����׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ
	input  wire    [`RegBus]           id_reg1,        // ����׶ε�ָ��Ҫ���е������Դ������1
	input  wire    [`RegBus]           id_reg2,        // ����׶ε�ָ��Ҫ���е������Դ������2
	input  wire    [`ShamtBus]         id_shamt,       // ����׶���λ
	input  wire    [`ImmBus]           id_imm, 
    input  wire                        id_MemRead,   
    input  wire                        id_MemtoReg,  
    input  wire                        id_MemWrite,  
    input  wire                        id_ALUSrc,    
    input  wire                        id_RegWrite,  
    input  wire     [`AluOpBus]        id_ALUOp,
    input  wire    [`RegAddrBus]       id_Rn,
    input  wire    [`RegAddrBus]       id_Rm,
    
	input wire     [`InstAddrBus]      id_pc,   // ����׶ε�PC
    input wire                         id_isZeroBranch,
    input wire                         id_isUnconBranch,
    input wire                         id_isNZBranch, 
          
	                                                
	//���ݵ�ִ�н׶ε���Ϣ                                       
	output reg     [`OpCodeBus]        ex_opcode,      // ִ�н׶ε�ָ��Ĳ������ֶΣ�inst[31:21]
	output reg     [`RegAddrBus]       ex_waddr,       // ִ�н׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ    
	output reg     [`RegBus]           ex_reg1,        // ִ�н׶ε�ָ��Ҫ���е������Դ������1   
	output reg     [`RegBus]           ex_reg2,        // ִ�н׶ε�ָ��Ҫ���е������Դ������2   
	output reg     [`ShamtBus]         ex_shamt,        // ִ�н׶���λ
	output reg     [`ImmBus]           ex_imm, 
    output reg                         ex_MemRead,   
    output reg                         ex_MemtoReg,  
    output reg                         ex_MemWrite,  
    output reg                         ex_ALUSrc,    
    output reg                         ex_RegWrite,  
    output reg     [`AluOpBus]         ex_ALUOp,
    output reg     [`RegAddrBus]       ex_Rn,
    output reg     [`RegAddrBus]       ex_Rm,
    
	output reg     [`InstAddrBus]      ex_pc,   // ����׶ε�PC
    output reg                         ex_isZeroBranch,
    output reg                         ex_isUnconBranch,
    output reg                         ex_isNZBranch 
    
     
	
);

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			ex_opcode <= `EXE_NOP_OP;
			ex_reg1 <= `ZeroWord;
			ex_reg2 <= `ZeroWord;
			ex_waddr <= `NOPRegAddr;
			ex_shamt <= `NOPShamt;
			ex_imm <= `ZeroWord;
			ex_MemRead      <=   `False_v;
			ex_MemtoReg     <=   `False_v;
			ex_MemWrite     <=   `False_v;
			ex_ALUSrc       <=   `False_v;
			ex_RegWrite     <=   `False_v;
			ex_ALUOp        <=   `NOPALUop;
			ex_Rn           <=   `NOPRegAddr;
			ex_Rm           <=   `NOPRegAddr;
			ex_pc           <=   `ZeroWord;
            ex_isZeroBranch <=   `False_v;        
            ex_isUnconBranch<=   `False_v;        
            ex_isNZBranch   <=   `False_v;         
		end else begin		
			ex_opcode <= id_opcode;
			ex_reg1 <= id_reg1;
			ex_reg2 <= id_reg2;
			ex_waddr <= id_waddr;
			ex_shamt <= id_shamt;
			ex_imm <= id_imm;
			ex_MemRead      <=   id_MemRead  ;
			ex_MemtoReg     <=   id_MemtoReg ;
			ex_MemWrite     <=   id_MemWrite ;
			ex_ALUSrc       <=   id_ALUSrc   ;
			ex_RegWrite     <=   id_RegWrite ;
			ex_ALUOp        <=   id_ALUOp    ;
			ex_Rn           <=   id_Rn       ;
            ex_Rm           <=   id_Rm       ;
            ex_pc           <=   id_pc           ;        
            ex_isZeroBranch <=   id_isZeroBranch ;
            ex_isUnconBranch<=   id_isUnconBranch;
            ex_isNZBranch   <=   id_isNZBranch   ;
		end
	end
	
endmodule