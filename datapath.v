module datapath(input clk,rst,ld_PC,ld_IR,ld_A,MemRead,MemWrite,push,pop,top,PCsrc,s1,s2,s4,input[1:0]s3,input [2:0]ALU_operation,output [8:0]inst,output Zero);
    wire [7:0]MemOut,Inst,MDRout,StackIn,StackOut,Aout,Bout,ALUinA,ALUinB,ALUout,ALUregOut;
    wire [4:0]instAddress,PCsrcIn,Address;

    register #5 PC(
        .clk(clk),
        .ld(ld_PC),
        .rst(rst),
        .Qin(PCsrcIn),
        .Q(instAddress)
    );
    
    mux2nton #5 MemAdd(
        .a(instAddress),
        .b(inst[4:0]),
        .s(s1),
        .o(Address)
    );

    memory Memory(
        .memRead(MemRead),
        .memWrite(MemWrite),
        .Address(Address),
        .writeData(Aout),
        .readData(MemOut)
    );

    register IR(
        .clk(clk),
        .ld(ld_IR),
        .rst(rst),
        .Qin(MemOut),
        .Q(Inst)
    );

    register MDR(
        .clk(clk),
        .ld(1'b1),
        .rst(rst),
        .Qin(MemOut),
        .Q(MDRout)
    );

    mux2nton ALUtoStack(
        .a(MDRout),
        .b(ALUregOut),
        .o(StackIn),
        .s(s4)
    );

    stack Stack(
        .push(push),
        .pop(pop),
        .top(top),
        .d_in(StackIn),
        .clk(clk),
        .rst(rst),
        .d_out(StackOut)
    );

    register A(
        .clk(clk),
        .ld(ld_A),
        .rst(rst),
        .Qin(StackOut),
        .Q(Aout)
    );

    register B(
        .clk(clk),
        .ld(1'b1),
        .rst(rst),
        .Qin(StackOut),
        .Q(Bout)
    );

    mux2nton Bmux(
        .a(Bout),
        .b(8'd1),
        .s(s2),
        .o(ALUinB)
    );

    mux3nton Amux(
        .a(Aout),
        .b(instAddress),
        .c(8'd0),
        .s(s3),
        .o(ALUinA)
    );

    ALU ALU(
        .A(ALUinA),
        .B(ALUinB),
        .ALU_control(ALU_operation),
        .Zero(Zero),
        .Out(ALUout)
    );

    register ALUreg(
        .clk(clk),
        .ld(1'b1),
        .rst(rst),
        .Qin(ALUout),
        .Q(ALUregOut)
    );

    mux2nton PCsrcMux(
        .b(inst[4:0]),
        .a(ALUout),
        .s(PCsrc),
        .o(PCsrcIn)
    );



endmodule