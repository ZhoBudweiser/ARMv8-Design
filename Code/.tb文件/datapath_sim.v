//////////////////////////////////////////////////////////////////////
// Simulation:  datapath_sim
// Author:      Buwei Zhou
// Description: 数据通路仿真
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module datapath_sim();

    reg     clock       =  1'b1;
    reg     reset       =  1'b0;
    

    datapath datapath0(
        clock,
        reset
        );
    
    initial begin
        #300   reset = 1'b1;
        #6000
        $stop;       
    end
    always #50 clock = ~clock; 
    
endmodule
