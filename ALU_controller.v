module ALU_controller(input[2:0]opcode,input[1:0]ALUop,output reg[2:0] ALU_control);
reg [2:0]funcOp;
always @(ALUop,funcOp) begin
    case(ALUop)
        2'b00:ALU_control=3'b010; //add
        2'b01:ALU_control=3'b011; //sub
        2'b10:ALU_control=funcOp; //R_type
    endcase
end
always @(opcode) begin
    case(opcode[1:0])
        2'b10:funcOp=3'b000; //and
        2'b00:funcOp=3'b010; //add
        2'b01:funcOp=3'b011; //sub
        2'b11:funcOp=3'b111; //not
    endcase
end
endmodule