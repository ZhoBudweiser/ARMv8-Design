//////////////////////////////////////////////////////////////////////
// Module:  alu
// Author:  Buwei Zhou
// Description: 运算器
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "defines.v"

module alu(

  input    wire     [`RegBus]      reg1_i,
  input    wire     [`RegBus]      reg2_i,
  input    wire     [`ShamtBus]    shamt,       
  input    wire     [`ALUCtlBus]   control,
  input    wire                    setflags,
  output   reg      [`RegBus]      result,
  output   reg      [`FlagBus]      flags            //NZVC
  
);

    reg carrybit;

  always @(reg1_i or reg2_i or control) begin
    case (control)
      4'b0000 : {carrybit, result} = reg1_i & reg2_i;
      4'b0001 : {carrybit, result} = reg1_i | reg2_i;
      4'b0010 : {carrybit, result} = reg1_i + reg2_i;
      4'b0110 : {carrybit, result} = reg1_i - reg2_i;
      4'b0111 : {carrybit, result} = reg2_i;
      4'b1000 : {carrybit, result} = reg1_i ^ reg2_i;
      4'b1100 : {carrybit, result} = ~(reg1_i | reg2_i);
      4'b1010 : {carrybit, result} = reg1_i >>> shamt;
      4'b1011 : {carrybit, result} = reg1_i << shamt;
    endcase
  end

  always @(*) begin
    if (setflags == `True_v) begin
        // 结果为负数
        flags[3] <= result[`DWORDSIZE-1];
        // 结果为0
        flags[2] <= result == 64'b0;
        // 结果溢出
        flags[1] <= (reg1_i[`DWORDSIZE-1] == reg2_i[`DWORDSIZE-1]) && (result[`DWORDSIZE-1] != reg1_i[`DWORDSIZE-1]);
        // 结果进位
        flags[0] <= carrybit;
    end else begin
        flags <= 4'b0000;
    end
  end
  
endmodule
