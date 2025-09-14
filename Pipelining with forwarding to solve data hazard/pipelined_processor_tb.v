
module testbench();

reg rst, clk=0;

    pipeline_processor_module ppm(
        .clk(clk), .rst(rst)
    );

always begin
clk=~clk;
#50;
end

initial begin
rst<=1'b0;
#200;
rst<=1'b1;
#1500;
$finish;
end

initial begin
$dumpfile("pipelined_dump.vcd");
$dumpvars(0);
end


endmodule