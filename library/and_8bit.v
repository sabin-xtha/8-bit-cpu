`timescale 1ns / 1ps
module and_8bit(
    input [7:0] a,
    input [7:0] b,
    output [7:0] z
    );
    assign z = a & b;
endmodule
