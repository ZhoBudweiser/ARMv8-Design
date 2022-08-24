//////////////////////////////////////////////////////////////////////
// Simulation:  mem_sim
// Author:      Buwei Zhou
// Description: �ô�׶η���
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module mem_sim();
    reg                    rst = 1;             // ��λ�źţ��ߵ�ƽ��Ч                                            
    reg                    clk = 0;             // ʱ���ź�                                                  
    reg [`DataAddrBus]     addr;            // �洢���Ķ�д��ַ                                              
    reg [`DataBus]         wdata;           // Ҫд�������                                                
    reg                    rden;            // ��ȡʹ��                                                  
    reg                    wren;            // д��ʹ��                                                  
    reg  [`RegAddrBus]     waddr;           // �Ĵ�����д���ַ                                                         
    reg  [`DataBus]        result;           // Ҫд�������
                                                                                                      
    wire   [`DataBus]        wb_rdata;            // д�ؽ׶����ݴ洢����ȡ���������                               
    wire   [`RegBus]         wb_result;           // д�ؽ׶ε�ALU������                                   
    wire   [`RegAddrBus]    wb_waddr;             // д�ؽ׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ��inst[4:0]                   

    module_mem module_mem0(  
        rst,             // ��λ�źţ��ߵ�ƽ��Ч
        clk,             // ʱ���ź�
        addr,            // �洢���Ķ�д��ַ
        wdata,           // Ҫд�������
        rden,            // ��ȡʹ��            
        wren,            // д��ʹ�� 
        waddr,
        result,     
        wb_rdata,            // д�ؽ׶����ݴ洢����ȡ���������                    
        wb_result,           // д�ؽ׶ε�ALU������                        
        wb_waddr             // д�ؽ׶ε�ָ��Ҫд���Ŀ�ļĴ�����ַ��inst[4:0]        
        );

    initial begin
        #100   rst <= 1'b0;
        addr    <=  64'h0;
        wdata   <=  64'h6;
        rden    <=  1'b0;
        wren    <=  1'b1;
        waddr   <=  5'b0;
        result  <=  64'b0;
        #500 
        addr    <=  64'h0;
        rden    <=  1'b1;
        wren    <=  1'b0;
        result  <=  64'h4;
        #500 $stop;     
    end
    always #50 clk = ~clk; 
    
endmodule
