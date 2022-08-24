//////////////////////////////////////////////////////////////////////
// Module:  datapath
// Author:      Buwei Zhou*     Zhe Xv
// Description: ����ͨ·
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module datapath(

    input wire   clock,
    input wire   reset,
    
    output  wire        [`InstAddrBus]  pc,
    output  wire        [`DataBus]      o1,
    output  wire        [`DataBus]      o2,
    output  wire        [`DataBus]      o3,
    output  wire        [`DataBus]      o4
    
    );
    

	wire   [`InstAddrBus]  id_pc;          // ����׶�ȡ�õ�ָ���Ӧ�ĵ�ַ
	wire   [`InstBus]      id_inst;        // ����׶�ȡ�õ�ָ��
	
    assign  pc = id_pc;	
    
	// ����
    wire   [`InstAddrBus]  mem_add_o;
    
    // ����    
	wire    [`FlagBus]            mem_flags_o; 
    wire mem_isZeroBranch; 
    wire mem_isUnconBranch;  
    wire mem_isNZBranch;
    
    // ����
    wire[`InstAddrBus] ex_pc_o;    
    wire ex_isZeroBranch; 
    wire ex_isUnconBranch;
    wire ex_isNZBranch;
    
        
    module_if module_if0(
        .clock(clock),
        .reset(reset),
        .if_pc_i(mem_add_o),
        .PCSrc(mem_isUnconBranch || (mem_flags_o[2] && mem_isZeroBranch) || (!mem_flags_o[2] && mem_isNZBranch)), 
        .id_pc_o(id_pc),
        .id_inst_o(id_inst)
    );
    
//    reg    RegWrite = 1'b1;
    
	wire  [`OpCodeBus]        ex_opcode_o;      // ִ�н׶ε�ָ��Ĳ������ֶΣ�inst[31:21]
	wire  [`RegAddrBus]       ex_waddr_o;       // ִ�н׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ     
    wire  [`RegBus]           ex_reg1_o;       // ִ�н׶ε�ָ��Ҫ���е������Դ������1        
    wire  [`RegBus]           ex_reg2_o;        // ִ�н׶ε�ָ��Ҫ���е������Դ������2
    wire  [`ShamtBus]         ex_shamt_o;
    wire  [`ImmBus]           ex_imm_o;

    wire   [`RegAddrBus]      wb_waddr;             // д�ؽ׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ��inst[4:0]                   
    wire   [`DataBus]         wb_out;
                    
    wire                      ex_MemRead_o;              
    wire                      ex_MemtoReg_o;             
    wire                      ex_MemWrite_o;             
    wire                      ex_ALUSrc_o;
    wire                      wb_RegWrite_o ; 
//    wire                      ex_RegWrite_i;              
    wire                      ex_RegWrite_o;            
    wire   [`AluOpBus]        ex_ALUOp_o;
    wire   [`RegAddrBus]      ex_Rn_o;
    wire   [`RegAddrBus]      ex_Rm_o;                
         
    module_id module_id0(
        .clock(clock),                        
        .reset(reset),                        
        .id_pc_i(id_pc),   
        .id_inst_i(id_inst), 
        .RegWrite_i(wb_RegWrite_o), 
        .waddr(wb_waddr),    
        .wdata(wb_out), 
           
        .ex_opcode_o(ex_opcode_o),  
        .ex_waddr_o(ex_waddr_o),   
        .ex_reg1_o(ex_reg1_o),    
        .ex_reg2_o(ex_reg2_o), 
        .ex_shamt_o(ex_shamt_o),
        .ex_imm_o(ex_imm_o),
        .ex_MemRead_o(ex_MemRead_o),  
        .ex_MemtoReg_o(ex_MemtoReg_o), 
        .ex_MemWrite_o(ex_MemWrite_o), 
        .ex_ALUSrc_o(ex_ALUSrc_o),   
        .ex_RegWrite_o(ex_RegWrite_o), 
        .ex_ALUOp_o(ex_ALUOp_o),
        .ex_Rn(ex_Rn_o),
        .ex_Rm(ex_Rm_o),
        
        .ex_pc_o(ex_pc_o),    
        .ex_control_isZeroBranch(ex_isZeroBranch), 
        .ex_control_isUnconBranch(ex_isUnconBranch),
        .ex_control_isNZBranch(ex_isNZBranch),
       
        .o1(o1),
        .o2(o2),
        .o3(o3),
        .o4(o4)
    );
    
          
//    reg     [`AluOpBus]         aluop = 2'b00;      
    
    // output
//	wire    [`FlagBus]            mem_flags_o;
	wire    [`RegBus]             mem_result_o;    
    wire    [`RegBus]             mem_reg2_o;         
    wire    [`RegAddrBus]         mem_waddr_o;
    wire                          mem_MemRead_o;  
    wire                          mem_MemtoReg_o;  
    wire                          mem_MemWrite_o;  
    wire                          mem_RegWrite_o;   	 	
    
    wire    [`ForwardBus]         Fa; 
    wire    [`ForwardBus]         Fb;  
    
    module_ex module_ex0(
        .clock(clock),                                     
        .reset(reset),                                     
        .ex_opcode_i(ex_opcode_o),      
        .ex_waddr_i(ex_waddr_o),       
        .ex_reg1_i(ex_reg1_o),        
        .ex_reg2_i(ex_reg2_o),        
        .ex_shamt_i(ex_shamt_o),         
        .ex_imm_i(ex_imm_o),           
        .ex_MemRead_i(ex_MemRead_o),       
        .ex_MemtoReg_i(ex_MemtoReg_o),      
        .ex_MemWrite_i(ex_MemWrite_o),      
        .ex_ALUSrc_i(ex_ALUSrc_o),        
        .ex_RegWrite_i(ex_RegWrite_o),      
        .ex_ALUOp_i(ex_ALUOp_o),         
        .f_Fa(Fa),     
        .f_Fb(Fb),     
        .f_ALURes(mem_result_o), 
        .f_Out(wb_out),    
        
        .ex_pc_i(ex_pc_o),   
        .ex_isZeroBranch_i(ex_isZeroBranch), 	
        .ex_isUnconBranch_i(ex_isUnconBranch), 	
        .ex_isNZBranch_i(ex_isNZBranch),
                   
        .mem_flags_o(mem_flags_o),    
        .mem_result_o(mem_result_o),   
        .mem_reg2_o(mem_reg2_o),     
        .mem_waddr_o(mem_waddr_o),	 	
        .mem_MemRead_o(mem_MemRead_o),      
        .mem_MemtoReg_o(mem_MemtoReg_o),     
        .mem_MemWrite_o(mem_MemWrite_o),     
        .mem_RegWrite_o(mem_RegWrite_o),
        	       
        .mem_add_o(mem_add_o), 
        .mem_isZeroBranch_o(mem_isZeroBranch), 
        .mem_isUnconBranch_o(mem_isUnconBranch),
        .mem_isNZBranch_o(mem_isNZBranch)	
         	                 
    );
    

//    reg                    rden = 1'b0;            // ��ȡʹ��                                                  
//    reg                    wren = 1'b1;            // д��ʹ��
    
    wire   [`DataBus]        wb_rdata;            // д�ؽ׶����ݴ洢����ȡ���������                               
    wire   [`RegBus]         wb_result;           // д�ؽ׶ε�ALU������ 
    
    wire                     wb_MemtoReg_o ;
//    wire                     wb_RegWrite_o ;                                  

    module_mem module_mem0(  
        reset,             // ��λ�źţ��ߵ�ƽ��Ч
        clock,             // ʱ���ź�
        mem_result_o,    // �洢���Ķ�д��ַ
        mem_reg2_o,     // Ҫд�������
        mem_waddr_o,
        mem_result_o,
        mem_MemRead_o, 
        mem_MemtoReg_o,
        mem_MemWrite_o,
        mem_RegWrite_o, 
             
        wb_rdata,            // д�ؽ׶����ݴ洢����ȡ���������                    
        wb_result,           // д�ؽ׶ε�ALU������                        
        wb_waddr,             // д�ؽ׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ��inst[4:0] 
        wb_MemtoReg_o,        
        wb_RegWrite_o 
       );
        
//     reg         MemtoReg = 1'b1;    
         
     Mux mux0(
        wb_rdata,
        wb_result,
        wb_MemtoReg_o,
        wb_out
     );
     
    forwarding forwarding0(
        .Rn(ex_Rn_o),
        .Rm(ex_Rm_o),
        .ex_Rd(mem_waddr_o),
        .mem_Rd(wb_waddr),
        .ex_RegWrite(mem_RegWrite_o),
        .mem_RegWrite(wb_RegWrite_o),
        
        .Fa(Fa),
        .Fb(Fb)
        );
    
endmodule
