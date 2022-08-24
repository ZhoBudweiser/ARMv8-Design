//全局
`define RstEnable           1'b0                    // 
`define RstDisable          1'b1                    // 
`define ZeroWord            64'h0000000000000000    // 64位的数值0
`define InstZeroWord        32'h00000000            // 32位的数值0
`define WriteEnable         1'b1                    // 
`define WriteDisable        1'b0                    // 
`define ReadEnable          1'b1                    // 
`define ReadDisable         1'b0                    // 
`define AluOpBus            1:0                     // 
`define AluSelBus           2:0                     // 
`define OpCodeBus           10:0                    // 操作码字段总线宽度
`define ALUCtlBus           3:0                     // 控制信号总线宽度
`define True_v              1'b1                    // 逻辑真
`define False_v             1'b0                    // 逻辑假

//指令                                      
`define EXE_ORI             6'b001101               // 
`define EXE_NOP             6'b000000               // 

//AluOp                                             
`define EXE_OR_OP           8'b00100101             // 
`define EXE_ORI_OP          8'b01011010             // 
`define EXE_NOP_OP          11'b00000000000         // 空指令的操作码字段
`define FlagBus             3:0
`define NOPALUop            2'b11
                                                    
//AluSel                                            
`define EXE_RES_LOGIC       3'b001                  // 
`define EXE_RES_NOP         3'b000                  // 
                                                    // 
//指令存储器inst_rom                        
`define InstAddrBus         63:0                    // ROM的地址总线宽度
`define InstBus             31:0                    // ROM的数据总线宽度
`define InstMemSize         128                     // ROM的实际大小为128KB
`define InstMemSizeLog2     17                      // ROM实际使用的地址线宽度

//通用寄存器regfile 
`define RegAddrBus          4:0                     // Regfile模块的地址线宽度
`define RegBus              63:0                    // Regfile模块的数据线宽度
`define RegWidth            32                      // 
`define DoubleRegWidth      64                      // 
`define DoubleRegBus        63:0                    // 
`define RegNum              32                      // 通用寄存器的数量
`define RegNumLog2          5                       // 寻址通用寄存器使用的地址位数
`define NOPRegAddr          5'b11111                // 空指令目标寄存器
`define ShamtBus            5:0                     // 移位数据总线
`define NOPShamt            6'b000000

//数据存储器data_rom                        
`define DataAddrBus         63:0                    // ROM的地址总线宽度
`define DataBus             63:0                    // ROM的数据总线宽度
`define BYTESIZE            8                       // 一个字节大小
`define DWORDSIZE           64                      // 一个双字大小
`define DataMemSize         128                     // ROM的实际大小为128KB
`define INSTFILE            "inst_rom.data"
`define DATAFILE            "data_rom.data"

`define FlagReset           4'b000
`define ImmBus              63:0
`define ForwardBus          1:0

// 添加
`define INSTSIZE        32      // 指令宽度   
`define OPCODESIZE      11      // 最大操作数宽度
`define SHORTSIZE       26      // 最大立即数宽度
// 数据拓展
// B指令: B
`define B_MASK          'b011_1110_0000
`define B_BITSET        'b000_1010_0000
// B.cond
`define BFLAG_MASK      'b111_1111_1000
`define BFLAG_BITSET    'b010_1010_0000
// CB指令: CBZ, CBNZ
`define CB_MASK         'b111_1111_0000
`define CB_BITSET       'b101_1010_0000