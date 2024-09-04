`timescale 1ns / 1ps

`include "library/and_8bit.v"
`include "library/add_sub_8bit.v"
`include "library/full_adder.v"
`include "library/half_adder.v"
`include "param.v"

module alu(
    input [3:0] sel,
    input [`DATA_WIDTH-1:0] a,
    input [`DATA_WIDTH-1:0] b,
    output reg [`DATA_WIDTH-1:0] z,
    output reg [`DATA_WIDTH-1:0] flag  //0-carry, 1-zero...
    );
    
    reg one = 8'b1, zero = 8'b0;
    wire [7:0] add_out, sub_out, and_out;
    wire add_cout, sub_bout;
    add_8bit add(a, b, zero, add_out, add_cout);
    add_8bit subtract(a, b, one, sub_out, sub_bout);
    and_8bit and_gate(a, b, and_out);

    always@(a, b, sel) 
        begin
            case(sel)
                4'b0001: 
                begin
                    z[7:0] = add_out;
                    flag[0] = add_cout;
                end
                4'b0010:
                begin
                    z[7:0] = sub_out;
                    flag[0] = sub_bout;
                end 
                4'b0011: z[7:0] = and_out;
                default: 
                begin 
                    flag <= 1'b0; 
                    z <= 8'b00000000;
                end 
            endcase    
        end
endmodule
