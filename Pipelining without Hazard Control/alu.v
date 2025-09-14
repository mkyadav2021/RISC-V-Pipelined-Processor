module alu_module(A,B,ALUControl,ALUResult,Ze,N,V,C);

//32 bit ALU
        //decalring inputs
        input [31:0] A,B;
        input [2:0] ALUControl;

        //declaring outputs
        output [31:0] ALUResult;

        output Ze,N,V,C;

        //declaring interim wires
        wire [31:0] a_and_b;
        wire [31:0] a_or_b;
        wire [31:0] not_b;

        wire [31:0] mux_1;

        wire [31:0] sum;
        wire [31:0] mux_2;
        
        wire cout; //default is [0:0]
        
        wire [31:0] slt;
        //logic design
        assign a_and_b=A&B;
        assign a_or_b=A|B;
        assign not_b=~B;

        //designing 2by1 mux
        assign mux_1=(ALUControl[0]==1'b0) ? B:not_b;

        //addition and subtraction
        assign {cout,sum}=A+mux_1+ALUControl[0]; //cout gets the carry and sum gets the addition or subtraction result
        
        //zero extension (appending zeros to the MSB of sum result)
        assign slt={31'b0, sum[31]};
        //slt means "set on less than", while doing A-B and if A<B then slt is set to 1.


        //designing 4by1 mux (it holds result)
        assign mux_2=(ALUControl[2:0]==3'b000)? sum:
                     (ALUControl[2:0]==3'b001) ? sum :
                     (ALUControl[2:0]==3'b010) ? a_and_b :
                     (ALUControl[2:0]==3'b011) ? a_or_b : 
                     (ALUControl[2:0]==3'b101) ? slt : 32'h00000000;


        assign ALUResult=mux_2;

        // Flags Zero, Negative, Carry out, Overflow
    assign Ze = (ALUResult==32'b0);
    assign N = ALUResult[31];
    assign C = cout & (~ALUControl[1]); // ALUControl[1]=1 means logical operation and ALUControl[1]=0 means arithmentic operation
    assign V = (~ALUControl[1]) & (A[31] ^ sum[31]) &  (~(A[31] ^ B[31] ^ ALUControl[0]));



endmodule