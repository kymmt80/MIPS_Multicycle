module memory(input memWrite,memRead,input [7:0]writeData,input [4:0]Address,output reg [7:0]readData);
reg[7:0] mem[0:31];

initial begin
    //instruction//(c+d)-(a+b)
    mem[0]=8'b100_10000;//push <-M[16]//a 
    mem[1]=8'b100_10001;//push <-M[17]//b
    mem[2]=8'b000_00000;//add
    mem[3]=8'b100_10010;//push <-M[18]//c
    mem[4]=8'b100_10011;//push <-M[19]//d
    mem[5]=8'b000_00000;//add
    mem[6]=8'b001_00000;//sub
    mem[7]=8'b101_10100;//pop ->M[20]
    //data
    mem[16]=8'd7;
    mem[17]=8'd9;
    mem[18]=8'd14;
    mem[19]=8'd3;
end

always@(memRead,Address,memWrite)begin
    if (memRead ==1)
        readData <= mem[Address];
    else if(memWrite==1)
        mem[Address]<=writeData;
end
endmodule