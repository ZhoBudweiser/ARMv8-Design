//////////////////////////////////////////////////////////////////////
// Simulation:  if_sim
// Author:      Buwei Zhou
// Description: ȡָ�׶η���
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module if_sim();
    // input
    reg     clock       =  1'b0;
    reg     reset       =  1'b1;
    // output
	wire   [`InstAddrBus]  id_pc;          // ����׶�ȡ�õ�ָ���Ӧ�ĵ�ַ
	wire   [`InstBus]      id_inst;        // ����׶�ȡ�õ�ָ��
        
    module_if module_if0(
        .clock(clock),
        .reset(reset),
        .id_pc_o(id_pc),
        .id_inst_o(id_inst)
    );
    
    initial begin
        #300   reset = 1'b0;       
    end
    always #50 clock = ~clock;  
endmodule
