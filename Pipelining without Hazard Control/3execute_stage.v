

module execute_stage_module(clk,rst,RegWriteE, ResultSrcE, MemWriteE,BranchE,ALUControlE,ALUSrcE,RD1_E,RD2_E,PCE,RdE,ImmExtE,PCPlus4E,
 PCTargetE,PCSrcE,RegWriteM,ResultSrcM,MemWriteM,ALUResultM,WriteDataM,RdM,PCPlus4M);

input clk,rst;
input RegWriteE,ResultSrcE,MemWriteE,BranchE,ALUSrcE;
input [2:0]ALUControlE;  
input [31:0] RD1_E, RD2_E, ImmExtE;
input [4:0] RdE;
input [31:0] PCE, PCPlus4E;

output [31:0] PCTargetE;   
output PCSrcE;
output RegWriteM,ResultSrcM,MemWriteM;
output [31:0]ALUResultM,WriteDataM,PCPlus4M;
output [4:0]RdM;

//wire
wire [31:0]SrcBE,ALUResultE;
wire ZeroE;

//registers
reg RegWriteE_reg,ResultSrcE_reg,MemWriteE_reg;
reg [31:0]ALUResultE_reg, WriteDataE_reg,PCPlus4E_reg;
reg [4:0]RdE_reg;


//instantiation
alu_module am(
    .A(RD1_E),.B(SrcBE),.ALUControl(ALUControlE),.ALUResult(ALUResultE),.Ze(ZeroE),.N(),.V(),.C());


mux_module mm(
    .a(RD2_E),.b(ImmExtE),.s(ALUSrcE),.c(SrcBE));

pc_adder_module pa(
    .a(PCE),.b(ImmExtE),.c(PCTargetE));


//assigning to registers
always @(posedge clk or negedge rst) begin
if (rst==1'b0) begin
RegWriteE_reg<=1'b0;
ResultSrcE_reg<=1'b0;
MemWriteE_reg<=1'b0;
ALUResultE_reg<=32'h0;
WriteDataE_reg<=32'h0;
PCPlus4E_reg<=32'h0;
RdE_reg<=5'h0;
end
else begin
RegWriteE_reg<=RegWriteE;
ResultSrcE_reg<=ResultSrcE;
MemWriteE_reg<=MemWriteE;
ALUResultE_reg<=ALUResultE;
WriteDataE_reg<=RD2_E;
PCPlus4E_reg<=PCPlus4E;
RdE_reg<=RdE;
end
 
end


//assigning to outputs
assign PCSrcE= (ZeroE & BranchE);

assign RegWriteM=RegWriteE_reg;
assign ResultSrcM=ResultSrcE_reg;
assign MemWriteM=MemWriteE_reg;
assign ALUResultM=ALUResultE_reg;
assign WriteDataM=WriteDataE_reg;
assign RdM=RdE_reg;
assign PCPlus4M=PCPlus4E_reg;



endmodule