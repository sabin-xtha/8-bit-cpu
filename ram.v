`timescale 1ns / 1ps
`include "param.v"
module ram(
    input rw, clk, memio,
    input wire [`ADDR_WIDTH-1:0] addr,
    inout wire [`DATA_WIDTH-1:0] data 
    );
    reg [7:0] buffer;
    reg[7:0] memory[0:255];

    initial begin
        memory[0] = 8'h00;
        memory[1] = 8'h50;
        memory[2] = 8'h09;
        memory[3] = 8'h30;
        memory[4] = 8'h69;
        memory[5] = 8'h57;
        memory[6] = 8'h30;
    end

    always @(posedge clk)
        begin
        if(memio)
            if(rw) begin
                buffer <= memory[addr];
            end
            else begin
                memory[addr] <= data;
            end
        end

    // always @(posedge clk) begin
    //     $display("ram data = %h", buffer);
    // end
    assign data = (rw) ? buffer : 'bz;
endmodule
