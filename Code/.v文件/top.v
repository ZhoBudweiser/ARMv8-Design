//////////////////////////////////////////////////////////////////////
// Module:  top
// Author:      Buwei Zhou
// Description: 顶层文件
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"


module top(

    input wire   clock,
    input wire   reset,
//    input wire   stick,
    
    output  wire    [15:0]    seg_o,
    output  wire    [7:0]    an_o	
    
    );

//    wire    [7:0]    seg_o;	// 数码管的公共段选信号  
//    wire    [3:0]    an_o;		// 作为4个数码管的位选信号
        wire        bps;
//        wire        bps_o;
        
        wire        [`InstAddrBus]  pc;
        wire        [`DataBus]      o1; 
        wire        [`DataBus]      o2; 
        wire        [`DataBus]      o3; 
        wire        [`DataBus]      o4;

//        wire        [3:0]           num;
//        assign num = (clock == 0) ? 4'd0 : 4'd1;
        
    datapath datapath(

    .clock(clock),
    .reset(reset),
    .pc(pc),
    .o1(o1),
    .o2(o2),
    .o3(o3),
    .o4(o4)
    
    );
    
    seg seg0(
        .clk(clock),
        .rst(reset),
        .in7(pc[15:12]), 
        .in6(pc[11:8]), 
        .in5(pc[7:4]), 
        .in4(pc[3:0]),
        .in3(o4[3:0]), 
        .in2(o3[3:0]), 
        .in1(o2[3:0]), 
        .in0(o1[3:0]),
        .duan(seg_o),	// 数码管的公共段选信号
        .an(an_o)		// 作为8个数码管的位选信号
    );

    counter counter0(
        .clk(clock),
 	 	.rst(reset),
 	 	.clk_bps(bps)
 	 	
 	 	);	
 	 	
//    counter counter1(
//        .clk(bps),
// 	 	.rst(reset),
// 	 	.clk_bps(bps_o)
 	 	
// 	 	);	
 	 	    
endmodule
