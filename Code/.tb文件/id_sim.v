//////////////////////////////////////////////////////////////////////
// Simulation:  id_sim
// Author:      Buwei Zhou
// Description: 译码阶段仿真
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module id_sim();
    // input
    reg     clock       =  1'b0;
    reg     reset       =  1'b1;
    reg     [`InstAddrBus]        id_pc_i        = 32'h0000;          // 译码阶段取得的指令对应的地址      
    reg     [`InstBus]            id_inst_i      = 32'h0000;        // 译码阶段取得的指令           
    // output
	wire  [`OpCodeBus]        ex_opcode_o;      // 执行阶段的指令的操作码字段，inst[31:2
	wire  [`RegAddrBus]       ex_waddr_o;       // 执行阶段的指令要写入的目的寄存器地址     
    wire  [`RegBus]           ex_reg1_o;       // 执行阶段的指令要进行的运算的源操作数1        
    wire  [`RegBus]           ex_reg2_o;        // 执行阶段的指令要进行的运算的源操作数2
    
    module_id module_id0(
        .clock(clock),                        
        .reset(reset),                        
        .id_pc_i(id_pc_i),   
        .id_inst_i(id_inst_i), 
        .ex_opcode_o(ex_opcode_o),  
        .ex_waddr_o(ex_waddr_o),   
        .ex_reg1_o(ex_reg1_o),    
        .ex_reg2_o(ex_reg2_o)     
    );
    
    initial begin
        #100   reset = 1'b0;
        #100   id_inst_i = 32'b10101010000_00000_000000_00001_00010;
        #100   id_inst_i = 32'b10101010000_00011_000000_00100_00101;
        #150 $stop;     
    end
    always #50 clock = ~clock;  
endmodule
