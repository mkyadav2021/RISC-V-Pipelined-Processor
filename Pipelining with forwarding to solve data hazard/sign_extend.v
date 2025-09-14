//Sign extension simply means copying the sign bit into the most significant bits: ImmExt31:12 = Instr31, and ImmExt11:0 = Instr31:20.


module sign_extend_module(Instr, ImmExt, ImmSrc);

//output is correct of this module, the input is not taken as mentioned in the book, we just take all the input
input [1:0]ImmSrc;
input [31:0]Instr;
output [31:0]ImmExt;


assign ImmExt = (ImmSrc==2'b01)? ({{20{Instr[31]}},Instr[31:25],Instr[11:7]}) : //S type
                {{20{Instr[31]}}, Instr[31:20]}; //I type



endmodule