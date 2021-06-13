module controller(input clk,rst,Zero,input[3:0]opcode,output reg ld_PC,ld_IR,ld_A,MemRead,MemWrite,push,pop,top,PCsrc,s1,s2,s4,output reg [1:0]s3,output [2:0]ALU_control);
reg [1:0] ALUop;

/*Controller State Machine to be Added*/

ALU_controller Ac(.opcode(opcode),.ALUop(ALUop),.ALU_control(ALU_control));
endmodule