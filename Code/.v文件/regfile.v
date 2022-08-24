//////////////////////////////////////////////////////////////////////
// Module:  regfile
// Author:  Buwei Zhou
// Description: 64位通用寄存器，共32个
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module regfile(

	input  wire					    clk,       // 复位信号，高电平有效
	input  wire					    rst,       // 时钟信号
	                                            
	//读端口1                                  
	input  wire    [`RegAddrBus]	raddr1,    // 第一个读寄存器端口要读取的寄存器的地址
	output reg     [`RegBus]        rdata1,    // 第一个读寄存器端口输出的寄存器值
	                                           
	//读端口2                                   
	input  wire    [`RegAddrBus]	raddr2,    // 第二个读寄存器端口要读取的寄存器的地址
	output reg     [`RegBus]        rdata2,    // 第二个读寄存器端口输出的寄存器值
	                                            
	//写端口                                    
	input  wire						we,        // 写使能信号
	input  wire    [`RegAddrBus]	waddr,     // 要写入的寄存器地址
	input  wire    [`RegBus]		wdata,      // 要写入的数据
	
	output wire    [`DataBus]      o1,
	output wire    [`DataBus]      o2,
	output wire    [`DataBus]      o3,
	output wire    [`DataBus]      o4
	
);

	reg[`RegBus]  regs[0:`RegNum-1];
	
    integer initCount;
    
    assign  o1 = regs[0];
    assign  o2 = regs[2];
    assign  o3 = regs[3];
    assign  o4 = regs[4];
    
    initial begin
    
        for (initCount = 0; initCount < `RegNum; initCount = initCount + 1) begin
            regs[initCount] = initCount;
        end
        
        regs[31] = 64'h00000000;
    end
	
    // 读端口1操作
	always @ (negedge clk) begin
		if(rst == `RstEnable) begin
			  rdata1 <= `ZeroWord;
		// 31号寄存器的值始终是数值0
        end else if(raddr1 == `RegNumLog2'd31) begin
	  		rdata1 <= `ZeroWord;
	  	// 读取的目标寄存器与要写入的目的寄存器相同
        end else if((raddr1 == waddr) && (we == `WriteEnable)) begin
            rdata1 <= wdata;
        end else begin
            rdata1 <= regs[raddr1];
	  end
	end

    // 读端口2操作
	always @ (negedge clk) begin
		if(rst == `RstEnable) begin
            rdata2 <= `ZeroWord;
        // 31号寄存器的值始终是数值0
        end else if(raddr2 == `RegNumLog2'd31) begin
	  		rdata2 <= `ZeroWord;
	  	// 读取的目标寄存器与要写入的目的寄存器相同
        end else if((raddr2 == waddr) && (we == `WriteEnable)) begin
            rdata2 <= wdata;
        end else begin
            rdata2 <= regs[raddr2];
	  end
	end

    // 写端口操作
	always @ (posedge clk) begin
//	   regs[waddr] <= wdata;
//		if (rst == `RstDisable) begin
//		    // 31号寄存器的值始终是数值0，无法进行读写
//		    regs[waddr] <= wdata;
			if((we == `WriteEnable) && (waddr != `RegNumLog2'd31)) begin
				regs[waddr] <= wdata;
			end
//		end
	end
	
endmodule