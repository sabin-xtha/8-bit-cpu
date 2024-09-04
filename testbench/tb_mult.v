`timescale 1ns/1ps
`define DATA_WIDTH 8

module tb_mult ();

reg clk;
reg rst;
reg [`DATA_WIDTH-1:0]in1;
reg [`DATA_WIDTH-1:0]in2;
wire [`DATA_WIDTH*2-1:0]out;


multiplier uut(
    .clk(clk),
    .rst(rst),
    .in1(in1),
    .in2(in2),
    .out(out)  
);

initial begin
        $dumpfile("../simulations/tb_mult.vcd");
        $dumpvars(0, tb_mult);
    end

initial begin
    in1 <= -21;
    in2 <= 35;
    rst = 1;
    #5;
    rst = 0;
    #5;
    rst <= 1;
end

reg j;
initial
begin
  for(j=0;j<20;j=j+1)
    begin
      clk = 1;
      #5;
      clk = 0;
      #5;
    end
  end
endmodule