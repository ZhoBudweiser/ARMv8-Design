//////////////////////////////////////////////////////////////////////
// Module:  inst_rom
// Author:  Buwei Zhou
// Description: 指令存储器
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module inst_rom(

	input  wire                        rst,             // 复位信号，高电平有效
	input  wire    [`InstAddrBus]      addr,   // 要读取的指令地址
	output reg     [`InstBus]          inst    // 读出的指令
	
);

	reg[`BYTESIZE-1:0]  inst_mem[0:`InstMemSize-1];

	initial $readmemh (`INSTFILE, inst_mem );
	
//	initial begin
//        inst_mem[0]         <=      8'h8a;
//        inst_mem[1]         <=      8'h1f;
//        inst_mem[2]         <=      8'h00;
//        inst_mem[3]         <=      8'h00; 
//        inst_mem[4]         <=      8'h91;
//        inst_mem[5]         <=      8'h00;
//        inst_mem[6]         <=      8'h04;
//        inst_mem[7]         <=      8'h00; 
//        inst_mem[8]         <=      8'heb;
//        inst_mem[9]         <=      8'h01;
//        inst_mem[10]        <=      8'h00;
//        inst_mem[11]        <=      8'h02; 
//        inst_mem[12]        <=      8'h91;
//        inst_mem[13]        <=      8'h00;
//        inst_mem[14]        <=      8'h04;
//        inst_mem[15]        <=      8'h00; 
//        inst_mem[16]        <=      8'h8a;
//        inst_mem[17]        <=      8'h02;
//        inst_mem[18]        <=      8'h00;
//        inst_mem[19]        <=      8'h03; 
//        inst_mem[20]        <=      8'hb1;
//        inst_mem[21]        <=      8'h00;
//        inst_mem[22]        <=      8'h04;
//        inst_mem[23]        <=      8'h00; 
//        inst_mem[24]        <=      8'hd3;
//        inst_mem[25]        <=      8'h40;
//        inst_mem[26]        <=      8'h04;
//        inst_mem[27]        <=      8'h84; 
//        inst_mem[28]        <=      8'h17;
//        inst_mem[29]        <=      8'hff;
//        inst_mem[30]        <=      8'hff;
//        inst_mem[31]        <=      8'hf9; 
//        inst_mem[32]        <=      8'h00;
//        inst_mem[33]        <=      8'h00;
//        inst_mem[34]        <=      8'h00; 
//        inst_mem[35]        <=      8'h00;
//        inst_mem[36]        <=      8'h00;
//        inst_mem[37]        <=      8'h00;
//        inst_mem[38]        <=      8'h00; 
//        inst_mem[39]        <=      8'h00;
//        inst_mem[40]        <=      8'h00;
//        inst_mem[41]        <=      8'h00;
//        inst_mem[42]        <=      8'h00; 
//        inst_mem[43]        <=      8'h00; 
//	end
	
	

	always @ (*) begin
		if (rst == `RstEnable) begin
            inst <= `InstZeroWord;
        end else begin
            inst[7:0]   = inst_mem[addr + 3];
            inst[15:8]  = inst_mem[addr + 2];
            inst[23:16] = inst_mem[addr + 1];
            inst[31:24] = inst_mem[addr];
		end
	end

endmodule