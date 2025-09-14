`include "1fetch_stage.v"
`include "2decode_stage.v"
`include "3execute_stage.v"
`include "4memory_rw_stage.v"
`include "5writeback_reg_stage.v"

//for fetch stage
`include "mux.v"
`include "instruction_memory.v"
`include "program_counter.v"
`include "pc_adder.v"

//for decode stage
`include "alu_decoder.v"
`include "main_decoder.v"
`include "sign_extend.v"
`include "register_file.v"

//for execute stage
`include "alu.v"
//`include "mux.v"
//`include "pc_adder.v"

//for memory_rw stage
`include "data_memory.v"

//for writeback_reg stage
//`include "mux.v"


module pipeline_processor_module(clk,rst);

input clk,rst;

//wires
wire PCSrcE_wire, RegWriteW_wb_wire, RegWriteE_wire, ResultSrcE_wire, MemWriteE_wire, BranchE_wire, ALUSrcE_wire, RegWriteM_wire, ResultSrcM_wire, MemWriteM_wire, RegWriteW_wire, ResultSrcW_wire;
wire [2:0] ALUControlE_wire;
wire [4:0]  RdW_wb_wire,RdE_wire, RdW_wire, RdM_wire;
wire [31:0] PCTargetE_wire, InstrD_wire, PCD_wire, PCPlus4D_wire, ResultW_wire, RD1_E_wire, RD2_E_wire, PCE_wire, ImmExtE_wire, PCPlus4E_wire, ALUResultM_wire, PCPlus4M_wire, PCPlus4W_wire;
wire [31:0] WriteDataM_wire, ReadDataW_wire, ALUResultW_wire;

//instantiation
fetch_stage_module fs(
    .clk(clk),.rst(rst),.PCSrcE(PCSrcE_wire),.PCTargetE(PCTargetE_wire),.InstrD(InstrD_wire),.PCD(PCD_wire),.PCPlus4D(PCPlus4D_wire));

decode_stage_module ds(
    .clk(clk), .rst(rst), .InstrD(InstrD_wire), .PCD(PCD_wire), .PCPlus4D(PCPlus4D_wire), .RegWriteW(RegWriteW_wb_wire), .RdW(RdW_wb_wire), 
    .ResultW(ResultW_wire), .RegWriteE(RegWriteE_wire), .ResultSrcE(ResultSrcE_wire), .MemWriteE(MemWriteE_wire), .BranchE(BranchE_wire), .ALUControlE(ALUControlE_wire), 
.ALUSrcE(ALUSrcE_wire), .RD1_E(RD1_E_wire), .RD2_E(RD2_E_wire), .PCE(PCE_wire), .RdE(RdE_wire), .ImmExtE(ImmExtE_wire), .PCPlus4E(PCPlus4E_wire));

execute_stage_module es(
    .clk(clk), .rst(rst), .RegWriteE(RegWriteE_wire), .ResultSrcE(ResultSrcE_wire), .MemWriteE(MemWriteE_wire), .BranchE(BranchE_wire), 
    .ALUControlE(ALUControlE_wire), .ALUSrcE(ALUSrcE_wire), .RD1_E(RD1_E_wire), .RD2_E(RD1_E_wire), .PCE(PCE_wire), .RdE(RdE_wire), .ImmExtE(ImmExtE_wire), .PCPlus4E(PCPlus4E_wire),
     .PCTargetE(PCTargetE_wire), .PCSrcE(PCSrcE_wire), .RegWriteM(RegWriteM_wire), .ResultSrcM(ResultSrcM_wire), .MemWriteM(MemWriteM_wire), .ALUResultM(ALUResultM_wire), 
     .WriteDataM(WriteDataM_wire), .RdM(RdM_wire), .PCPlus4M(PCPlus4M_wire)
);

memory_rw_stage_module mrws(
    .clk(clk), .rst(rst), .RegWriteM(RegWriteM_wire), .ResultSrcM(ResultSrcM_wire), .MemWriteM(MemWriteM_wire), .RdM(RdM_wire), .PCPlus4M(PCPlus4M_wire), .ALUResultM(ALUResultM_wire), 
    .WriteDataM(WriteDataM_wire), .RegWriteW(RegWriteW_wire), .ResultSrcW(ResultSrcW_wire), .RdW(RdW_wire), .PCPlus4W(PCPlus4W_wire), .ReadDataW(ReadDataW_wire), .ALUResultW(ALUResultW_wire));

writeback_reg_stage_module wbrs(
.clk(clk),.rst(rst), .RegWriteW(RegWriteW_wire), .ResultSrcW(ResultSrcW_wire), .ALUResultW(ALUResultW_wire), .ReadDataW(ReadDataW_wire), .RdW(RdW_wire), .PCPlus4W(PCPlus4W_wire),
.RegWriteW_wb(RegWriteW_wb_wire),  .RdW_wb(RdW_wb_wire), .ResultW(ResultW_wire));



endmodule