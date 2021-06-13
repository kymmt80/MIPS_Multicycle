module memory(input memWrite,memRead,input [8:0]writeData,input [5:0]Address,output reg [8:0]readData);
reg[8:0] mem[0:32];

initial begin
    mem[0]=8'd5;
end

always@(memRead,Address,memWrite)begin
    if (memRead ==1)
        readData <= mem[Address];
    else if(memWrite==1)
        mem[Address]<=writeData;
end
endmodule