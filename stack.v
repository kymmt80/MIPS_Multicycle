module stack(input clk,rst,push,pop,top,input [7:0]d_in,output reg[7:0]d_out);
reg[7:0] mem[0:255];
reg [7:0]stack_ptr;
always @(posedge clk,posedge rst) begin
    if(rst)
        stack_ptr=8'b11111111;
    else begin
        if(pop)begin
            d_out=mem[stack_ptr];
            stack_ptr=stack_ptr-1;
        end
        else if (push)begin
            stack_ptr=stack_ptr+1;
            mem[stack_ptr]=d_in;
        end
        else if (top) begin
            d_out=mem[stack_ptr];
        end
    end
end
endmodule