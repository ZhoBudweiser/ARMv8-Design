//////////////////////////////////////////////////////////////////////
// Simulation:  mem_sim
// Author:      Buwei Zhou
// Description: 访存阶段仿真
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module mem_sim();
    reg                    rst = 1;             // 复位信号，高电平有效                                            
    reg                    clk = 0;             // 时钟信号                                                  
    reg [`DataAddrBus]     addr;            // 存储器的读写地址                                              
    reg [`DataBus]         wdata;           // 要写入的数据                                                
    reg                    rden;            // 读取使能                                                  
    reg                    wren;            // 写入使能                                                  
    reg  [`RegAddrBus]     waddr;           // 寄存器的写入地址                                                         
    reg  [`DataBus]        result;           // 要写入的数据
                                                                                                      
    wire   [`DataBus]        wb_rdata;            // 写回阶段数据存储器读取输出的数据                               
    wire   [`RegBus]         wb_result;           // 写回阶段的ALU运算结果                                   
    wire   [`RegAddrBus]    wb_waddr;             // 写回阶段的指令要写入的目的寄存器地址，inst[4:0]                   

    module_mem module_mem0(  
        rst,             // 复位信号，高电平有效
        clk,             // 时钟信号
        addr,            // 存储器的读写地址
        wdata,           // 要写入的数据
        rden,            // 读取使能            
        wren,            // 写入使能 
        waddr,
        result,     
        wb_rdata,            // 写回阶段数据存储器读取输出的数据                    
        wb_result,           // 写回阶段的ALU运算结果                        
        wb_waddr             // 写回阶段的指令要写入的目的寄存器地址，inst[4:0]        
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
