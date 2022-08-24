//////////////////////////////////////////////////////////////////////
// Module:          pc_reg
// Author:          Buwei Zhou
// Description:     ָ��ָ��Ĵ���PC
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module pc_reg(

    input   wire                        clk,        // ʱ���ź�  
    input   wire                        rst,        // ��λ�ź�   
    
    input wire PCSrc,  // ����
    input wire[`InstAddrBus] pc_in, 

    output  reg     [`InstAddrBus]      pc         // Ҫ��ȡ��ָ���ַ
	
);

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			pc <= 64'h0000000000000000;
		end else begin
	 		if (PCSrc == 1'b1) begin
	 		    pc <= pc_in;
	 		end
	 		else begin 
	 		    pc <= pc + 4;
	 		end
		end
	end
	

endmodule