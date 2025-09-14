//kind of a secondary storage type

module data_memory_module(A,WE,WD,RD,clk,rst);

input [31:0]A,WD;
input WE,clk,rst;

output [31:0]RD;

reg [31:0] data_mem [65536:0];

//reading
assign RD = (~rst) ? 32'h0 : data_mem[A];

//writing
always@(posedge clk)
begin
    if(WE)
    data_mem[A]<=WD;
end

//test data for lw instruction
initial begin
//data_mem[8192]=32'h10;
data_mem[0]=32'h0;
end

endmodule