`timescale 1ns / 1ps

module alu_tb;
reg [3:0] sel;
reg [7:0] a;
reg [7:0] b;
wire [7:0] z;
wire [7:0] f; //0-carry, 1-zero...

alu uut(
    .a(a),
    .b(b),
    .sel(sel),
    .z(z),
    .flag(f)
    );


    
    reg [3:0] i;
initial begin    
    a = 8'b10000011;
    b = 8'b00110011;
    sel = 4'b0000;
    
    for(i = 0; i<=15; i=i+1)
    begin   
        sel = i;
        #1;
    end 
    a = 8'b0;
    b = 8'b0; 
end
endmodule
