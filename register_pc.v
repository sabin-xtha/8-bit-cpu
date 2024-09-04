`timescale 1ns / 1ps
`include "param.v"

module pc(
    input clk,
    input reset,
    input enable,
    input inc,
    input [`DATA_WIDTH-1:0] in,
    output reg [`DATA_WIDTH-1:0] out
    );

    always @(posedge clk, negedge reset)
        begin
                if(!reset)
                    out <= 0;
                else if(enable)
                    if(inc)
                        out = out + 1;
                    else
                        out <= in;
    end
endmodule
