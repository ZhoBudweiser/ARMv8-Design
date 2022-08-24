`include "defines.v"


module seg(

    output  reg    [15:0]    duan,	// 数码管的公共段选信号
    output  reg    [7:0]    an,		// 作为8个数码管的位选信号
    
    input   wire            clk,
    input   wire            rst,
    input   wire    [3:0]   in3, in2, in1, in0,
    input   wire    [3:0]   in7, in6, in5, in4
    
    );
    	// EGo1数码管是共阴极的，需要连接高电平，对应位置被点亮
	   parameter   _0 = ~8'hc0;
	   parameter   _1 = ~8'hf9;
	   parameter   _2 = ~8'ha4;
	   parameter   _3 = ~8'hb0;
	   parameter   _4 = ~8'h99;
	   parameter   _5 = ~8'h92;
	   parameter   _6 = ~8'h82;
	   parameter   _7 = ~8'hf8;
	   parameter   _8 = ~8'h80;
	   parameter   _9 = ~8'h90;
	   parameter   _a = ~8'h88;
	   parameter   _b = ~8'h83;
	   parameter   _c = ~8'hc6;
	   parameter   _d = ~8'ha1;
	   parameter   _e = ~8'h86;
	   parameter   _f = ~8'h8e;
	   parameter   _err = ~8'hcf;
	   
	   parameter   N = 18;
    
       
    reg     [N-1 : 0]  regN; 
    reg     [3:0]       hex_in;
    
    always @ (posedge clk or posedge rst)   begin
        if (rst == `RstEnable)    begin
            regN    <=  0;
        end else    begin
            regN    <=  regN + 1;
        end
    end
    // regN实现对100MHz的系统时钟的分频
    always @ (*)    begin
        case (regN[N-1: N-3])
            3'b000:  begin
                an  <=  8'b00000001;
                hex_in  <=  in0;
            end
            3'b001:  begin
                an  <=  8'b00000010;
                hex_in  <=  in1;
            end
            3'b010:  begin
                an  <=  8'b00000100;
                hex_in  <=  in2;
            end
            3'b011:  begin
                an  <=  8'b00001000;
                hex_in  <=  in3;
            end
            3'b100:  begin
                an  <=  8'b00010000;
                hex_in  <=  in4;
            end
            3'b101:  begin
                an  <=  8'b00100000;
                hex_in  <=  in5;
            end
            3'b110:  begin
                an  <=  8'b01000000;
                hex_in  <=  in6;
            end
            3'b111:  begin
                an  <=  8'b10000000;
                hex_in  <=  in7;
            end
            default:    begin
                an  <=  8'b11111111;
                hex_in  <=  in3;
            end
        endcase
    end
    
    always @ (*)    begin
        if ((an & 8'b11110000) == 0)
            case (hex_in)
                4'h0:   duan[7:0] <=  _0;
                4'h1:   duan[7:0] <=  _1;
                4'h2:   duan[7:0] <=  _2;
                4'h3:   duan[7:0] <=  _3;
                4'h4:   duan[7:0] <=  _4;
                4'h5:   duan[7:0] <=  _5;
                4'h6:   duan[7:0] <=  _6;
                4'h7:   duan[7:0] <=  _7;
                4'h8:   duan[7:0] <=  _8;
                4'h9:   duan[7:0] <=  _9;
                4'ha:   duan[7:0] <=  _a;
                4'hb:   duan[7:0] <=  _b;
                4'hc:   duan[7:0] <=  _c;
                4'hd:   duan[7:0] <=  _d;
                4'he:   duan[7:0] <=  _e;
                4'hf:   duan[7:0] <=  _f;
                default:duan[7:0] <=  _err;
            endcase
        else
            case (hex_in)
                4'h0:   duan[15:8] <=  _0;
                4'h1:   duan[15:8] <=  _1;
                4'h2:   duan[15:8] <=  _2;
                4'h3:   duan[15:8] <=  _3;
                4'h4:   duan[15:8] <=  _4;
                4'h5:   duan[15:8] <=  _5;
                4'h6:   duan[15:8] <=  _6;
                4'h7:   duan[15:8] <=  _7;
                4'h8:   duan[15:8] <=  _8;
                4'h9:   duan[15:8] <=  _9;
                4'ha:   duan[15:8] <=  _a;
                4'hb:   duan[15:8] <=  _b;
                4'hc:   duan[15:8] <=  _c;
                4'hd:   duan[15:8] <=  _d;
                4'he:   duan[15:8] <=  _e;
                4'hf:   duan[15:8] <=  _f;
                default:duan[15:8] <=  _err;
            endcase
    end
            
endmodule
