//RISC-V has 32 registers each of 32bit
//Book page 269,395

module register_file_module(A1,RD1,A2,RD2,A3,WD3,WE3,clk,rst);

input clk,rst,WE3;
input [4:0]A1,A2,A3;
input [31:0]WD3;

output [31:0]RD1,RD2;

//creating memory (RISC-V has 32 registers each of 32 bit)
reg [31:0] Registers [31:0];


//reading
assign RD1= (!rst) ? 32'h0 : Registers[A1];
assign RD2= (!rst) ? 32'h0 : Registers[A2];

//writing
always@(posedge clk)
begin
    if(WE3)
    Registers[A3]<=WD3;

end

//test data for lw instruction
initial begin
Registers[0]=32'h0;
//Registers[6]=32'd10;
//Registers[5]=32'd6;
end

endmodule
