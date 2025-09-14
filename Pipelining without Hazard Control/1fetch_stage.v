

module fetch_stage_module(clk,rst,PCSrcE,PCTargetE,InstrD,PCD,PCPlus4D);

input clk, rst,  PCSrcE;
input [31:0] PCTargetE;
output [31:0] InstrD, PCD, PCPlus4D;

//wires
wire [31:0] PCFbar, PCF, PCPlus4F, InstrF;


//Registers to hold fetch stage content
reg[31:0] InstrF_reg,PCF_reg,PCPlus4F_reg;


//instantiation
mux_module pc_mux(
    .a(PCPlus4F),.b(PCTargetE),.s(PCSrcE),.c(PCFbar));

program_counter_module pcm(
    .rst(rst),.clk(clk),.PC(PCF),.PC_NEXT(PCFbar));

instruction_memory_module im(
    .rst(rst),.A(PCF),.RD(InstrF));

pc_adder_module pam(
    .a(PCF),.b(32'h4),.c(PCPlus4F));



always @(posedge clk or negedge rst) begin
  if(rst==1'b0) begin
  InstrF_reg<=32'h0;
  PCF_reg<=32'h0;
  PCPlus4F_reg<=32'h0;
  end
  else begin
   InstrF_reg<=InstrF;
   PCF_reg<=PCF;
   PCPlus4F_reg<=PCPlus4F;
 end
end

//assigning output from the Fetch stage registers to the output port
assign InstrD=(rst==1'b0) ? 32'h0:InstrF_reg;
assign PCD=(rst==1'b0) ? 32'h0:PCF_reg;
assign PCPlus4D=(rst==1'b0) ? 32'h0:PCPlus4F_reg; 

endmodule