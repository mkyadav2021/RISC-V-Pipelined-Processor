

module memory_rw_stage_module(clk,rst, RegWriteM,ResultSrcM,MemWriteM,RdM,PCPlus4M,ALUResultM,WriteDataM,
RegWriteW,ResultSrcW,RdW,PCPlus4W,ReadDataW,ALUResultW);

input clk,rst,RegWriteM,ResultSrcM,MemWriteM;
input [31:0] ALUResultM,WriteDataM,PCPlus4M;
input [4:0] RdM;

output RegWriteW,ResultSrcW;
output [31:0]  PCPlus4W,ALUResultW, ReadDataW;
output [4:0] RdW;

//wires
wire [31:0] RD_M;

//registers
reg RegWriteM_reg,ResultSrcM_reg;
reg [4:0]RdM_reg;
reg [31:0] PCPlus4M_reg, ALUResultM_reg,ReadDataM_reg;


//instantiation
data_memory_module dmm(
    .A(ALUResultM),.WE(MemWriteM),.WD(WriteDataM),.RD(RD_M),.clk(clk),.rst(rst));

//assigning to registers
always @(posedge clk or negedge rst) begin
if (rst==1'b0) begin
RegWriteM_reg<=1'b0;
ResultSrcM_reg<=1'b0;
RdM_reg<=5'h0;
PCPlus4M_reg<=32'h0;
ALUResultM_reg<=32'h0;
ReadDataM_reg<=32'h0;
end
else begin
RegWriteM_reg<=RegWriteM;
ResultSrcM_reg<=ResultSrcM;
RdM_reg<=RdM;
PCPlus4M_reg<=PCPlus4M;
ALUResultM_reg<=ALUResultM;
ReadDataM_reg<=RD_M;
end 
end

//assigning to outputs
assign RegWriteW=RegWriteM_reg;
assign ResultSrcW=ResultSrcM_reg;
assign RdW=RdM_reg;
assign PCPlus4W=PCPlus4M_reg;
assign ReadDataW=ReadDataM_reg;
assign ALUResultW=ALUResultM_reg;

endmodule

