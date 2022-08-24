//////////////////////////////////////////////////////////////////////
// Simulation:  id_sim
// Author:      Buwei Zhou
// Description: ����׶η���
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module id_sim();
    // input
    reg     clock       =  1'b0;
    reg     reset       =  1'b1;
    reg     [`InstAddrBus]        id_pc_i        = 32'h0000;          // ����׶�ȡ�õ�ָ���Ӧ�ĵ�ַ      
    reg     [`InstBus]            id_inst_i      = 32'h0000;        // ����׶�ȡ�õ�ָ��           
    // output
	wire  [`OpCodeBus]        ex_opcode_o;      // ִ�н׶ε�ָ��Ĳ������ֶΣ�inst[31:2
	wire  [`RegAddrBus]       ex_waddr_o;       // ִ�н׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ     
    wire  [`RegBus]           ex_reg1_o;       // ִ�н׶ε�ָ��Ҫ���е������Դ������1        
    wire  [`RegBus]           ex_reg2_o;        // ִ�н׶ε�ָ��Ҫ���е������Դ������2
    
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
