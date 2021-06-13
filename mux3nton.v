module mux3nton#(parameter N=8)(input[N-1:0]a,b,c,input [1:0]s,output [N-1:0]o);
	assign o=(s==2'd0)?a:
		    (s==2'd1)?b:
            (s==2'd2)?c:1'bx;
endmodule