module controller(input clk,rst,Zero,input[3:0]opcode,output ld_PC,output reg ld_IR,ld_A,MemRead,MemWrite,push,pop,top,PCsrc,s1,s2,s4,output reg [1:0]s3,output [2:0]ALU_control);
parameter[3:0] 
    IF = 4'd0, ID=4'd1, Jmp1=4'd2, Jz1=4'd3, Jz2=4'd4, Push1=4'd5, Push2=4'd6, PNR1=4'd7, RT1=4'd8, RT2=4'd9, Not1=4'd10, Pop1=4'd11, NR1=4'd12, NR2=4'd13   ;
reg [1:0] ALUop;
reg PCwrite,PCwriteCond;

reg[3:0] ns,ps;
always@(opcode,ps)begin
    case(ps)
        IF: ns=ID;
        ID: ns=(opcode==3'b110)?Jmp1:(opcode==3'b111)?Jz1:(opcode==3'b100)?Push1:PNR1;
        Jmp1: ns=IF;
        Jz1: ns=Jz2;
        Jz2: ns=IF;
        Push1: ns=Push2;
        Push2: ns=IF;
        PNR1: ns=(opcode==3'b101)?Pop1:(opcode==3'b011)?Not1:RT1;
        RT1: ns=RT2;
        RT2: ns=NR1;
        Not1: ns=NR1;
        Pop1: ns=IF;
        NR1: ns=NR2;
        NR2: ns=IF;
    endcase

end

always @(ps) begin
    ld_IR=1'b0;ld_A=1'b0;MemRead=1'b0;MemWrite=1'b0;push=1'b0;pop=1'b0;top=1'b0;PCsrc=1'b0;s1=1'b0;s2=1'b0;s4=1'b0;s3=2'b00;ALUop=2'b00;PCwrite=1'b0;
    case(ps)
        IF: begin s3=2'b01;s2=1'b1;ALUop=2'b00;PCsrc=1'b0;PCwrite=1'b1;s1=1'b0;MemRead=1'b1;ld_IR=1'b1; end
        ID: begin top=1'b1; end
        Jmp1: begin PCsrc=1'b1;PCwrite=1'b1; end
        Jz1: ;
        Jz2: begin s3=2'b10;s2=1'b0;ALUop=2'b00;PCsrc=1'b1;PCwriteCond=1'b1; end
        Push1: begin s1=1'b1; MemRead=1'b1; end
        Push2: begin s4=1'b0; push=1'b1; end
        PNR1: begin pop=1'b1; ld_A=1'b1; end
        RT1: begin pop=1'b1; end
        RT2: ;
        Not1: begin ALUop=2'b10; s3=2'b00; end
        Pop1: begin s1=1'b1; MemWrite=1'b1; end
        NR1: begin s3=2'b00; s2=1'b0; ALUop=2'b10; end
        NR2: begin push=1'b1; s4=1'b1; end
    endcase
end

always @(posedge clk,posedge rst) begin
    if(rst)
        ps<=IF;
    else
        ps<=ns;
end

//ALU controller:
ALU_controller Ac(.opcode(opcode),.ALUop(ALUop),.ALU_control(ALU_control));

//PC decider:
assign ld_PC=(Zero & PCwriteCond)|PCwrite;

endmodule