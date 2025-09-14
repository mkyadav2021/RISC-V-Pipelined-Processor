

module writeback_reg_stage_module(clk,rst, RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW, PCPlus4W,
RegWriteW_wb,  RdW_wb, ResultW);

input clk,rst, RegWriteW,ResultSrcW;
input [31:0]  PCPlus4W,ALUResultW, ReadDataW;
input [4:0] RdW;

output RegWriteW_wb;
output [4:0] RdW_wb;
output [31:0] ResultW;




//instantiation
mux_module mm1(
    .a(ALUResultW),.b(ReadDataW),.s(ResultSrcW),.c(ResultW));


//assigning to outputs
assign RegWriteW_wb=RegWriteW;
assign RdW_wb=RdW;


endmodule


