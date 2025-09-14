//Book page 399,400

module instruction_memory_module(rst,A,RD);

  input rst; //active low reset
  input [31:0]A;
  output [31:0]RD;

  reg [31:0] mem [1023:0]; //1024x32
  
  assign RD = (rst==1'b0) ? {32{1'b0}} : mem[A[31:2]]; //decoding logic using address bits of A is taken care by Verilog itslef, yaay!



initial begin
//mem[0]=32'hFFC4A303; //lw instruction I-type
//mem[0]=32'h0064A423; //sw instruction S-type
//mem[0]=32'h0062E233; //or instruction R-type
$readmemh("memoryfile.hex",mem);

end

endmodule