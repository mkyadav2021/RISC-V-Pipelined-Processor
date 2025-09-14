// `include "alu_decoder.v"
// `include "main_decoder.v"
// `include "sign_extend.v"
// `include "register_file.v"

module decode_stage_module(clk,rst, InstrD, PCD, PCPlus4D, RegWriteW, RdW, ResultW, 
RegWriteE, ResultSrcE, MemWriteE,BranchE,ALUControlE,ALUSrcE,RD1_E,RD2_E,PCE,RdE,ImmExtE,PCPlus4E,   RS1_E,RS2_E);

input clk,rst, RegWriteW;
input [4:0] RdW;
input [31:0]InstrD, PCD, PCPlus4D, ResultW;


output RegWriteE,ResultSrcE,MemWriteE,BranchE,ALUSrcE;
output [2:0]ALUControlE;  
output [31:0] RD1_E, RD2_E, ImmExtE;
output [4:0] RdE;
output [31:0] PCE, PCPlus4E;


//for hazard
output [4:0] RS1_E, RS2_E;
reg [4:0] RS1_D_r, RS2_D_r;


//wires
wire RegWriteD,ALUSrcD,MemWriteD,ResultSrcD,BranchD;
wire [1:0]ImmSrcD,ALUOp_wire;
output [2:0]ALUControlD;  

wire [31:0] RD1_D, RD2_D, ImmExtD;


//registers
reg RegWriteD_reg,ResultSrcD_reg,MemWriteD_reg,BranchD_reg,ALUSrcD_reg;
reg [2:0]ALUControlD_reg;  
reg [31:0] RD1_D_reg, RD2_D_reg, ImmExtD_reg;
reg [4:0] RdD_reg;
reg [31:0] PCD_reg, PCPlus4D_reg;





//instantiation
alu_decoder_module adm(
    .ALUOp(ALUOp_wire), .op(InstrD[5]), .funct3(InstrD[14:12]), .funct7(InstrD[30]), .ALUControl(ALUControlD));

main_decoder_module mdm(
    .op(InstrD[6:0]),.Branch(BranchD),.RegWrite(RegWriteD),.MemWrite(MemWriteD),.ResultSrc(ResultSrcD),.ALUSrc(ALUSrcD),.ImmSrc(ImmSrcD),.ALUOp(ALUOp_wire));

register_file_module rfm(
    .clk(clk),.rst(rst),.A1(InstrD[19:15]),.RD1(RD1_D),.A2(InstrD[24:20]),.RD2(RD2_D),.A3(RdW),.WD3(ResultW),.WE3(RegWriteW));

sign_extend_module sem(
    .Instr(InstrD[31:0]), .ImmExt(ImmExtD), .ImmSrc(ImmSrcD));


//assigning to registers

 always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            RegWriteD_reg <= 1'b0;
            ALUSrcD_reg <= 1'b0;
            MemWriteD_reg <= 1'b0;
            ResultSrcD_reg <= 1'b0;
            BranchD_reg <= 1'b0;
            ALUControlD_reg <= 3'b000;
            RD1_D_reg <= 32'h00000000; 
            RD2_D_reg <= 32'h00000000; 
            ImmExtD_reg <= 32'h00000000;
            RdD_reg <= 5'h00;
            PCD_reg <= 32'h00000000; 
            PCPlus4D_reg <= 32'h00000000;
        
        end
        else begin
            RegWriteD_reg <= RegWriteD;
            ALUSrcD_reg <= ALUSrcD;
            MemWriteD_reg <= MemWriteD;
            ResultSrcD_reg <= ResultSrcD;
            BranchD_reg <= BranchD;
            ALUControlD_reg <= ALUControlD;
            RD1_D_reg <= RD1_D; 
            RD2_D_reg <= RD2_D; 
            ImmExtD_reg <= ImmExtD;
            RdD_reg <= InstrD[11:7];
            PCD_reg <= PCD; 
            PCPlus4D_reg <= PCPlus4D;


            RS1_D_r <= InstrD[19:15];
            RS2_D_r <= InstrD[24:20];
         
        end
    end

    // assigning to output
    assign RegWriteE = RegWriteD_reg;
    assign ResultSrcE = ResultSrcD_reg;
    assign MemWriteE = MemWriteD_reg;
    assign BranchE = BranchD_reg;
    assign ALUControlE = ALUControlD_reg;
    assign ALUSrcE = ALUSrcD_reg;
    assign RD1_E = RD1_D_reg;
    assign RD2_E = RD2_D_reg;
    assign PCE = PCD_reg;
    assign RdE = RdD_reg;
    assign ImmExtE = ImmExtD_reg;
    assign PCPlus4E = PCPlus4D_reg;

    assign RS1_E = RS1_D_r;
    assign RS2_E = RS2_D_r;
   
endmodule