module ALU(input [7:0]A ,B,input [2:0]ALU_control,output Zero,output reg [7:0]Out);
    always@(ALU_control,A,B)begin
        Out=0;
        case(ALU_control)
        3'b000: Out=A & B;
        3'b010: Out=A+B;
        3'b011: Out=A-B;
        3'b111: Out= ~A;
        endcase
    end
    assign Zero=(Out==0)?1:0;
endmodule