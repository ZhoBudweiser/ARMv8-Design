//////////////////////////////////////////////////////////////////////
// Module:  if_id
// Author:  Buwei Zhou
// Description: IF/ID�׶εļĴ���
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module if_id(

	input  wire                            clk,        // ʱ���ź� 
	input  wire                            rst,        // ��λ�ź� 
	                                               
	input  wire    [`InstAddrBus]          if_pc,      // ȡָ�׶�ȡ�õ�ָ���Ӧ�ĵ�ַ
	input  wire    [`InstBus]              if_inst,    // ȡָ�׶�ȡ�õ�ָ��
	                                          
	output reg     [`InstAddrBus]          id_pc,      // ����׶�ȡ�õ�ָ���Ӧ�ĵ�ַ
	output reg     [`InstBus]              id_inst     // ����׶�ȡ�õ�ָ��
	
);

	always @ (posedge clk) begin
        if (rst == `RstEnable) begin
			id_pc <= `ZeroWord;
			id_inst <= `InstZeroWord;
        end else begin
		  id_pc <= if_pc;
		  id_inst <= if_inst;
		end
	end

endmodule