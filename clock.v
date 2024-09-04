`timescale 1ns / 1ps
module clock(
    output reg clk
    );
    
    initial begin   
        clk = ~clk;
        #1;
    end 
endmodule
