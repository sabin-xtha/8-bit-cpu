`timescale 1ns / 1ps
module tb_ram();

reg rw, clk, memio;
reg [7:0] addr;
wire [7:0]dataa;
reg [7:0] buffer;

ram uut(
    .rw(rw),
    .clk(clk),
    .memio(memio),
    .addr(addr),
    .data(dataa)
);
// reg clk = 0;
// always #1 clk = !clk;

initial begin
    $dumpfile("simulations/tb_ram.vcd");
    $dumpvars(0, tb_ram);
end

initial begin
    #1;
    addr = 8'b00000001;
    rw = 0;
    memio = 1;
    buffer = 8'b10101001;
    clk = 1;
    #1;
    clk = 0;
    #1;
    buffer = 0;
    memio = 0;
    clk = 1;
    #1;
    clk = 0;
    #1;
    addr = 8'b00000001;
    rw = 1;
    memio = 1;
    clk = 1;
    #1;
    clk = 0;
    #1;
end

assign dataa = rw ? 'bz:buffer;

endmodule
