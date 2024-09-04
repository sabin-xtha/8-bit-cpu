`timescale 1ns / 1ps

`include "add_sub_8bit.v"
`include "full_adder.v"
`include "half_adder.v"

`define DATA_WIDTH 8

module multiplier (
    input clk,
    input rst,
    input [`DATA_WIDTH-1:0] in1,in2,
    output reg [`DATA_WIDTH*2-1:0] out  
);

reg signed [`DATA_WIDTH*2:0] out_buffer;
reg [`DATA_WIDTH-1:0] M;
wire [`DATA_WIDTH-1:0] A, Q;
wire Qn, Qn1;
reg [3:0] counter;

wire [`DATA_WIDTH-1:0] sum, diff;

add_8bit add(
    .a(A),
    .b(M),
    .sel(1'b0),
    .z(sum),
    .cout()
);

add_8bit sub(
    .a(A),
    .b(M),
    .sel(1'b1),
    .z(diff),
    .cout()
);

initial begin
    out_buffer = {8'b00000000, in2, 1'b0};
    M = in1;
    counter = 8;
end

reg [`DATA_WIDTH-1:0] s;
reg [`DATA_WIDTH-1:0] d;
always @(posedge clk, negedge rst) begin
    if(!rst)begin
        out_buffer = {8'b00000000, in2, 1'b0};
        M = in1;
        counter = 8;
    end
    else if(counter  > 0) begin
        case({Qn,Qn1})
            2'b00,2'b11: 
            begin
                out_buffer <= out_buffer>>>1;
                $display("ashr, \t\t%b|%b|%b", out_buffer[16:9], out_buffer[8:1], out_buffer[0]);
            end
            2'b01: 
            begin
                out_buffer <= $signed({sum[`DATA_WIDTH-1:0], out_buffer[`DATA_WIDTH:0]}) >>> 1;
                $display("add+ashr, \t%b|%b|%b", out_buffer[16:9], out_buffer[8:1], out_buffer[0]);
            end
            2'b10: 
            begin
                out_buffer <= $signed({diff[`DATA_WIDTH-1:0], out_buffer[`DATA_WIDTH:0]}) >>>1;
                $display("sub+ashr, \t%b|%b|%b", out_buffer[16:9], out_buffer[8:1], out_buffer[0]);
            end
        endcase
        counter <= counter-1;
    end
    else begin
        out <= out_buffer[`DATA_WIDTH*2:1];
    end
end

assign Qn = out_buffer[1];
assign A = out_buffer[`DATA_WIDTH*2:`DATA_WIDTH+1];
assign Q = out_buffer[`DATA_WIDTH:1];
assign Qn1 = out_buffer[0];
endmodule