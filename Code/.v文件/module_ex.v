//////////////////////////////////////////////////////////////////////
// Module:  module_ex
// Author:      Buwei Zhou
// Description: 执行模块
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module module_ex(

    input    wire   clock,
    input    wire   reset, 
	input    wire      [`OpCodeBus]        ex_opcode_i,      // 执行阶段的指令的操作码字段，inst[31:21]
	input    wire      [`RegAddrBus]       ex_waddr_i,       // 执行阶段的指令要写入的目的寄存器地址    
	input    wire      [`RegBus]           ex_reg1_i,        // 执行阶段的指令要进行的运算的源操作数1   
	input    wire      [`RegBus]           ex_reg2_i,        // 执行阶段的指令要进行的运算的源操作数2      
    input    wire      [`ShamtBus]         ex_shamt_i,
    input    wire      [`ImmBus]           ex_imm_i,
    input    wire                          ex_MemRead_i,    
    input    wire                          ex_MemtoReg_i,   
    input    wire                          ex_MemWrite_i,   
    input    wire                          ex_ALUSrc_i,     
    input    wire                          ex_RegWrite_i,   
    input    wire      [`AluOpBus]         ex_ALUOp_i,
    input    wire      [`ForwardBus]          f_Fa,
    input    wire      [`ForwardBus]          f_Fb,
    input    wire      [`DataBus]          f_ALURes,
    input    wire      [`DataBus]          f_Out,
    
    input   wire       [`InstAddrBus]       ex_pc_i,   // PC   
    input   wire                            ex_isZeroBranch_i, 	// M Stage
    input   wire                            ex_isUnconBranch_i, 	// M Stage
    input   wire                            ex_isNZBranch_i, 
    
    output   wire    [`FlagBus]            mem_flags_o,    // 访存阶段的结果0标志位                                     
    output   wire    [`RegBus]             mem_result_o,      // 访存阶段的ALU运算结果                                    
    output   wire    [`RegBus]             mem_reg2_o,        // 访存阶段的参与运算的源操作数2                                 
    output   wire    [`RegAddrBus]         mem_waddr_o,	 	// 访存阶段的指令要写入的目的寄存器地址，inst[4:0]                         
    output   wire                          mem_MemRead_o,    
    output   wire                          mem_MemtoReg_o,   
    output   wire                          mem_MemWrite_o,       
    output   wire                          mem_RegWrite_o,
    
    output   wire   [`InstAddrBus]         mem_add_o,                                           
    output   wire                          mem_isZeroBranch_o, 	
    output   wire                          mem_isUnconBranch_o, 
    output   wire                          mem_isNZBranch_o
     
    );

    wire    [`ALUCtlBus]            ex_control;
    wire    [`FlagBus]              ex_flags;
    wire    [`RegBus]               ex_result;
    wire                            setflags;
//    wire                            ALUSrc = 1;
    wire    [`DataBus]              out0;
    wire    [`DataBus]              out1;
    wire    [`DataBus]              out2;

//    wire [`DWORDSIZE-1:0] ex_mux;  //比较器的输出
    wire [`RegBus] ex_add;  // 加法器的输出
    wire add_zeroflag;  // 废弃变量

    alu_control alu_control0(
      .aluop(ex_ALUOp_i),
      .opcode(ex_opcode_i),
      .control(ex_control),
      .setflags(setflags)
    );
    
    Mux Mux1(
        .Ain(ex_imm_i),
        .Bin(out2),
        .En(ex_ALUSrc_i),
        .out(out0)
    );
    
//    Mux alu_mux(
//        .Ain(ex_imm_i), 
//        .Bin(ex_reg2_i), 
//        .En(ex_ALUSrc_i), 
//        .out(ex_mux)
//    );
    
    TripleMux TripleMux0(
        .Ain(ex_reg1_i),
        .Bin(f_Out),
        .Cin(f_ALURes),
        .En(f_Fa),
        .out(out1)
    );
    
    
    TripleMux TripleMux1(
        .Ain(ex_reg2_i),
        .Bin(f_Out),
        .Cin(f_ALURes),
        .En(f_Fb),
        .out(out2)
    );
     
    alu alu0(
      .reg1_i(out1),
      .reg2_i(out0),
      .shamt(ex_shamt_i),
      .control(ex_control),
      .setflags(setflags),
      .result(ex_result),
      .flags(ex_flags)
    );
    
    alu add(
      .reg1_i(ex_pc_i),
      .reg2_i(ex_imm_i << 2),
      .shamt(6'b0),
      .control(4'b0010),
      .setflags(1'b0),
      .result(ex_add),
      .flags()
    );
     
    ex_mem ex_mem0(
        .clk(clock),           
        .rst(reset),            
        .ex_flags(ex_flags),   
        .ex_result(ex_result),     
        .ex_reg2(ex_reg2_i),       
        .ex_waddr(ex_waddr_i),
        .ex_MemRead(ex_MemRead_i), 
        .ex_MemtoReg(ex_MemtoReg_i),
        .ex_MemWrite(ex_MemWrite_i),
        .ex_RegWrite(ex_RegWrite_i),
        
        .ex_add_result(ex_add),
        .ex_isZeroBranch(ex_isZeroBranch_i), 
        .ex_isUnconBranch(ex_isUnconBranch_i),
        .ex_isNZBranch(ex_isNZBranch_i), 
 	
        .mem_flags(mem_flags_o),  
        .mem_result(mem_result_o),    
        .mem_reg2(mem_reg2_o),      
        .mem_waddr(mem_waddr_o),
        .mem_MemRead(mem_MemRead_o),      
        .mem_MemtoReg(mem_MemtoReg_o),     
        .mem_MemWrite(mem_MemWrite_o),     
        .mem_RegWrite(mem_RegWrite_o),
        
        .mem_add_result(mem_add_o), 
        .mem_isZeroBranch(mem_isZeroBranch_o), 
        .mem_isUnconBranch(mem_isUnconBranch_o),
        .mem_isNZBranch(mem_isNZBranch_o)
             	 	
    );
    
endmodule

