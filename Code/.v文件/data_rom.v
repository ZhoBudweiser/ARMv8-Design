//////////////////////////////////////////////////////////////////////
// Module:  data_rom
// Author:      Buwei Zhou
// Description: ���ݴ洢��
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module data_rom(

	input  wire                    rst,             // ��λ�źţ��ߵ�ƽ��Ч
	input  wire                    clk,             // ʱ���ź�
	input  wire [`DataAddrBus]     addr,            // �洢���Ķ�д��ַ
	input  wire [`DataBus]         wdata,           // Ҫд�������
	input  wire                    rden,            // ��ȡʹ��            
	input  wire                    wren,            // д��ʹ��            
	                                             
	output reg [`DataBus]         rdata            // ��ȡ���������
	
    );
    
	reg [`BYTESIZE-1:0] data[0:`DataMemSize-1];


	initial begin
		$readmemh(`DATAFILE, data);
	end

//    assign rdata = rden ? {data[addr], data[addr + 1], data[addr + 2], data[addr + 3], 
//                    data[addr + 4], data[addr + 5], data[addr + 6], data[addr + 7]}
//	                : {`DWORDSIZE{1'b0}};

	always @(posedge clk) begin 
		if (rst == `RstEnable)
			rdata <= {`DWORDSIZE{1'b0}};
		else if (rden == `ReadEnable)
		begin
			rdata[63:56]   <=  data[addr]    ;
			rdata[55:48]   <=  data[addr + 1];
			rdata[47:40]   <=  data[addr + 2];
			rdata[39:32]   <=  data[addr + 3];
			rdata[31:24]   <=  data[addr + 4];
			rdata[23:16]   <=  data[addr + 5];
			rdata[15:8]    <=  data[addr + 6];
			rdata[7:0]     <=  data[addr + 7];
		end
	end

	always @(posedge clk) begin 
		if (rst == `RstEnable)
			$readmemh(`DATAFILE, data);
		else if (wren == `WriteEnable)
		begin
			data[addr]       <=  wdata[63:56];
			data[addr + 1]   <=  wdata[55:48];
			data[addr + 2]   <=  wdata[47:40];
			data[addr + 3]   <=  wdata[39:32];
			data[addr + 4]   <=  wdata[31:24];
			data[addr + 5]   <=  wdata[23:16];
			data[addr + 6]   <=  wdata[15:8];
			data[addr + 7]   <=  wdata[7:0];
		end
	end
	
//	always @ * begin 	
//		if (rst == `RstDisable)	begin	
//            if (rden) begin
//                rdata <= {data[addr], data[addr + 1], data[addr + 2], data[addr + 3], data[addr + 4], data[addr + 5], data[addr + 6], data[addr + 7]};
//            end else begin
//                rdata <= {`DWORDSIZE{1'b0}};
//            end
//        end
//	end
endmodule