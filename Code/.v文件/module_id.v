//////////////////////////////////////////////////////////////////////
// Module:  module_id
// Author:      Buwei Zhou
// Description: 译码模块
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module module_id(

    input    wire   clock,
    input    wire   reset,
	input    wire   [`InstAddrBus]        id_pc_i,          // 译码阶段取得的指令对应的地址
	input    wire   [`InstBus]            id_inst_i,        // 译码阶段取得的指令
	input    wire                         RegWrite_i,
	input    wire   [`RegAddrBus]         waddr,
	input    wire   [`RegBus]             wdata,
    
	output   wire  [`OpCodeBus]        ex_opcode_o,      // 执行阶段的指令的操作码字段，inst[31:21]
	output   wire  [`RegAddrBus]       ex_waddr_o,       // 执行阶段的指令要写入的目的寄存器地址    
	output   wire  [`RegBus]           ex_reg1_o,        // 执行阶段的指令要进行的运算的源操作数1   
	output   wire  [`RegBus]           ex_reg2_o,         // 执行阶段的指令要进行的运算的源操作数2      
    output   wire  [`ShamtBus]         ex_shamt_o,       // 执行阶段移位
    output   wire  [`ImmBus]           ex_imm_o,  
    output   wire                      ex_MemRead_o,    
    output   wire                      ex_MemtoReg_o,   
    output   wire                      ex_MemWrite_o,   
    output   wire                      ex_ALUSrc_o,     
    output   wire                      ex_RegWrite_o,   
    output   wire   [`AluOpBus]        ex_ALUOp_o,
    output   wire   [`RegAddrBus]      ex_Rn,
    output   wire   [`RegAddrBus]      ex_Rm,
    
	output   wire  [`InstAddrBus]      ex_pc_o,     // 译码阶段的PC输出      
    output   wire                      ex_control_isZeroBranch, 
    output   wire                      ex_control_isUnconBranch,
    output   wire                      ex_control_isNZBranch,
    
	output   wire    [`DataBus]        o1,
	output   wire    [`DataBus]        o2,
	output   wire    [`DataBus]        o3,
	output   wire    [`DataBus]        o4 

    );


    wire  [`RegBus]           id_reg1_o;
    wire  [`RegBus]           id_reg2_o;
    wire  [`RegBus]           raddr2;
    wire  [`ImmBus]           id_imm_o;
//    wire                      Reg2Loc = 1;
    wire                      Reg2Loc;   
    wire                      MemRead;   
    wire                      MemtoReg;  
    wire                      MemWrite;  
    wire                      ALUSrc;    
//    wire                      RegWrite;  
    wire   [`AluOpBus]        ALUOp;      
     
    wire control_isZeroBranch; 
    wire control_isUnconBranch;
    wire control_isNZBranch; 


//    assign ex_Rn = id_inst_i[9:5]; 
//    assign ex_Rm = id_inst_i[20:16];
    
    wire[4:0] register_in;
    
    register_mux register_mux(
        .Ain(id_inst_i[4:0]), 
        .Bin(id_inst_i[20:16]), 
        .En(id_inst_i[28]), 
        .out(register_in)
    );
        
    regfile regfile0(
        .clk(clock),                    
        .rst(rest),                     
        .raddr1(id_inst_i[9:5]),        
        .rdata1(id_reg1_o),                        
        .raddr2(register_in),             
        .rdata2(id_reg2_o),                        
        .we(RegWrite_i),             
        .waddr(waddr),         
        .wdata(wdata),
        .o1(o1),
        .o2(o2),
        .o3(o3),
        .o4(o4)                          
    );
    
    id_ex id_ex0(
        .clk(clock),            
        .rst(reset),                         
        .id_opcode(id_inst_i[31:21]),      
        .id_waddr(id_inst_i[4:0]),       
        .id_reg1(id_reg1_o),        
        .id_reg2(id_reg2_o), 
        .id_shamt(id_inst_i[15:10]),
        .id_imm(id_imm_o),   
        .id_MemRead(MemRead), 
        .id_MemtoReg(MemtoReg),
        .id_MemWrite(MemWrite),
        .id_ALUSrc(ALUSrc),  
        .id_RegWrite(RegWrite),
        .id_ALUOp(ALUOp),
        .id_Rn(id_inst_i[9:5]),
        .id_Rm(id_inst_i[20:16]),
        
        .id_pc(id_pc_i),
        .id_isZeroBranch(control_isZeroBranch), 
        .id_isUnconBranch(control_isUnconBranch),
        .id_isNZBranch(control_isNZBranch),   
                             
        .ex_opcode(ex_opcode_o),      
        .ex_waddr(ex_waddr_o),       
        .ex_reg1(ex_reg1_o),        
        .ex_reg2(ex_reg2_o),
        .ex_shamt(ex_shamt_o),
        .ex_imm(ex_imm_o),
        .ex_MemRead(ex_MemRead_o), 
        .ex_MemtoReg(ex_MemtoReg_o),
        .ex_MemWrite(ex_MemWrite_o),
        .ex_ALUSrc(ex_ALUSrc_o),  
        .ex_RegWrite(ex_RegWrite_o),
        .ex_ALUOp(ex_ALUOp_o),
        .ex_Rn(ex_Rn),
        .ex_Rm(ex_Rm),
        
        .ex_pc(ex_pc_o),      
        .ex_isZeroBranch(ex_control_isZeroBranch), 
        .ex_isUnconBranch(ex_control_isUnconBranch),
        .ex_isNZBranch(ex_control_isNZBranch)     
        
    );
    
    sign_extend sign_extend0(
        .inst(id_inst_i),
        .imm(id_imm_o)
        );
        
//    Mux mux0(
//        id_inst_i[4:0],
//        id_inst_i[20:16],
//        Reg2Loc,
//        raddr2
//    );
    
    control control0(   
        .inst(id_inst_i),
        .Reg2Loc(Reg2Loc),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp),
        
        .isZeroBranch(control_isZeroBranch), 
        .isUnconBranch(control_isUnconBranch),
        .isNZBranch(control_isNZBranch)  
    );
     
endmodule

