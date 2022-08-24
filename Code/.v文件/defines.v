//ȫ��
`define RstEnable           1'b0                    // 
`define RstDisable          1'b1                    // 
`define ZeroWord            64'h0000000000000000    // 64λ����ֵ0
`define InstZeroWord        32'h00000000            // 32λ����ֵ0
`define WriteEnable         1'b1                    // 
`define WriteDisable        1'b0                    // 
`define ReadEnable          1'b1                    // 
`define ReadDisable         1'b0                    // 
`define AluOpBus            1:0                     // 
`define AluSelBus           2:0                     // 
`define OpCodeBus           10:0                    // �������ֶ����߿��
`define ALUCtlBus           3:0                     // �����ź����߿��
`define True_v              1'b1                    // �߼���
`define False_v             1'b0                    // �߼���

//ָ��                                      
`define EXE_ORI             6'b001101               // 
`define EXE_NOP             6'b000000               // 

//AluOp                                             
`define EXE_OR_OP           8'b00100101             // 
`define EXE_ORI_OP          8'b01011010             // 
`define EXE_NOP_OP          11'b00000000000         // ��ָ��Ĳ������ֶ�
`define FlagBus             3:0
`define NOPALUop            2'b11
                                                    
//AluSel                                            
`define EXE_RES_LOGIC       3'b001                  // 
`define EXE_RES_NOP         3'b000                  // 
                                                    // 
//ָ��洢��inst_rom                        
`define InstAddrBus         63:0                    // ROM�ĵ�ַ���߿��
`define InstBus             31:0                    // ROM���������߿��
`define InstMemSize         128                     // ROM��ʵ�ʴ�СΪ128KB
`define InstMemSizeLog2     17                      // ROMʵ��ʹ�õĵ�ַ�߿��

//ͨ�üĴ���regfile 
`define RegAddrBus          4:0                     // Regfileģ��ĵ�ַ�߿��
`define RegBus              63:0                    // Regfileģ��������߿��
`define RegWidth            32                      // 
`define DoubleRegWidth      64                      // 
`define DoubleRegBus        63:0                    // 
`define RegNum              32                      // ͨ�üĴ���������
`define RegNumLog2          5                       // Ѱַͨ�üĴ���ʹ�õĵ�ַλ��
`define NOPRegAddr          5'b11111                // ��ָ��Ŀ��Ĵ���
`define ShamtBus            5:0                     // ��λ��������
`define NOPShamt            6'b000000

//���ݴ洢��data_rom                        
`define DataAddrBus         63:0                    // ROM�ĵ�ַ���߿��
`define DataBus             63:0                    // ROM���������߿��
`define BYTESIZE            8                       // һ���ֽڴ�С
`define DWORDSIZE           64                      // һ��˫�ִ�С
`define DataMemSize         128                     // ROM��ʵ�ʴ�СΪ128KB
`define INSTFILE            "inst_rom.data"
`define DATAFILE            "data_rom.data"

`define FlagReset           4'b000
`define ImmBus              63:0
`define ForwardBus          1:0

// ���
`define INSTSIZE        32      // ָ����   
`define OPCODESIZE      11      // �����������
`define SHORTSIZE       26      // ������������
// ������չ
// Bָ��: B
`define B_MASK          'b011_1110_0000
`define B_BITSET        'b000_1010_0000
// B.cond
`define BFLAG_MASK      'b111_1111_1000
`define BFLAG_BITSET    'b010_1010_0000
// CBָ��: CBZ, CBNZ
`define CB_MASK         'b111_1111_0000
`define CB_BITSET       'b101_1010_0000