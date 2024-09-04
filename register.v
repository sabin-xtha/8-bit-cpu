`timescale 1ns / 1ps
`include "param.v"

module register(
    input clk,
    input reset,
    input enable,
    input [`DATA_WIDTH-1:0] in,
    output reg [`DATA_WIDTH-1:0] out
    );

    always @(posedge clk, negedge reset)
        begin
            if(enable)
                if(!reset)
                    out <= 0;
                else
                    out <= in;
    end
endmodule
