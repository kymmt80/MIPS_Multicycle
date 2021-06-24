module MIPS(input clk,rst);
wire ld_PC,ld_IR,ld_A,MemRead,MemWrite,push,pop,top,PCsrc,s1,s2,s4,Zero;
wire [1:0]s3;
wire [2:0]ALU_operation;
wire [7:0]inst;
    datapath dp(clk,rst,ld_PC,ld_IR,ld_A,MemRead,MemWrite,push,pop,top,PCsrc,s1,s2,s4,s3,ALU_operation,inst,Zero);
    controller c(clk,rst,Zero,inst[7:5],ld_PC,ld_IR,ld_A,MemRead,MemWrite,push,pop,top,PCsrc,s1,s2,s4,s3,ALU_operation);
endmodule