//////////////////////////////////////////////////////////////////////
// Simulation:  ex_sim
// Author:      Buwei Zhou
// Description: Ö´ÐÐ½×¶Î·ÂÕæ
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module ex_sim();
    // input
    reg     clock       =  1'b0;
    reg     reset       =  1'b1;
    reg     [`OpCodeBus]        ex_opcode_i;   
    reg     [`RegAddrBus]       ex_waddr_i;    
    reg     [`RegBus]           ex_reg1_i;     
    reg     [`RegBus]           ex_reg2_i;     
    reg     [`AluOpBus]         aluop;      
    
    // output
	wire                          mem_zeroflag_o;
	wire    [`RegBus]             mem_result_o;    
    wire    [`RegBus]             mem_reg2_o;         
    wire    [`RegAddrBus]         mem_waddr_o;	 	
    
    module_ex module_ex0(
        clock,
        reset, 
        ex_opcode_i,      
        ex_waddr_i,       
        ex_reg1_i,        
        ex_reg2_i,        
        aluop,
        mem_zeroflag_o,                    
        mem_result_o,                      
        mem_reg2_o,                        
        mem_waddr_o	 	                 
    );
    
    initial begin
        #100   reset = 1'b0;
        ex_opcode_i = 11'h550;
        ex_waddr_i = 32'h0;
        ex_reg1_i = 32'h1; 
        ex_reg2_i = 32'h2;  
        aluop = 2'b10;  
        #150 $stop;     
    end
    always #50 clock = ~clock;  
endmodule
