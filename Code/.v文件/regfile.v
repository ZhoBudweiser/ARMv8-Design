//////////////////////////////////////////////////////////////////////
// Module:  regfile
// Author:  Buwei Zhou
// Description: 64λͨ�üĴ�������32��
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module regfile(

	input  wire					    clk,       // ��λ�źţ��ߵ�ƽ��Ч
	input  wire					    rst,       // ʱ���ź�
	                                            
	//���˿�1                                  
	input  wire    [`RegAddrBus]	raddr1,    // ��һ�����Ĵ����˿�Ҫ��ȡ�ļĴ����ĵ�ַ
	output reg     [`RegBus]        rdata1,    // ��һ�����Ĵ����˿�����ļĴ���ֵ
	                                           
	//���˿�2                                   
	input  wire    [`RegAddrBus]	raddr2,    // �ڶ������Ĵ����˿�Ҫ��ȡ�ļĴ����ĵ�ַ
	output reg     [`RegBus]        rdata2,    // �ڶ������Ĵ����˿�����ļĴ���ֵ
	                                            
	//д�˿�                                    
	input  wire						we,        // дʹ���ź�
	input  wire    [`RegAddrBus]	waddr,     // Ҫд��ļĴ�����ַ
	input  wire    [`RegBus]		wdata,      // Ҫд�������
	
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
	
    // ���˿�1����
	always @ (negedge clk) begin
		if(rst == `RstEnable) begin
			  rdata1 <= `ZeroWord;
		// 31�żĴ�����ֵʼ������ֵ0
        end else if(raddr1 == `RegNumLog2'd31) begin
	  		rdata1 <= `ZeroWord;
	  	// ��ȡ��Ŀ��Ĵ�����Ҫд���Ŀ�ļĴ�����ͬ
        end else if((raddr1 == waddr) && (we == `WriteEnable)) begin
            rdata1 <= wdata;
        end else begin
            rdata1 <= regs[raddr1];
	  end
	end

    // ���˿�2����
	always @ (negedge clk) begin
		if(rst == `RstEnable) begin
            rdata2 <= `ZeroWord;
        // 31�żĴ�����ֵʼ������ֵ0
        end else if(raddr2 == `RegNumLog2'd31) begin
	  		rdata2 <= `ZeroWord;
	  	// ��ȡ��Ŀ��Ĵ�����Ҫд���Ŀ�ļĴ�����ͬ
        end else if((raddr2 == waddr) && (we == `WriteEnable)) begin
            rdata2 <= wdata;
        end else begin
            rdata2 <= regs[raddr2];
	  end
	end

    // д�˿ڲ���
	always @ (posedge clk) begin
//	   regs[waddr] <= wdata;
//		if (rst == `RstDisable) begin
//		    // 31�żĴ�����ֵʼ������ֵ0���޷����ж�д
//		    regs[waddr] <= wdata;
			if((we == `WriteEnable) && (waddr != `RegNumLog2'd31)) begin
				regs[waddr] <= wdata;
			end
//		end
	end
	
endmodule