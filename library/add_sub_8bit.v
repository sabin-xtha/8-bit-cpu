`timescale 1ns/1ps

module add_8bit(
    input [7:0] a, 
    input [7:0] b, 
    input sel,
    output [7:0] z, 
    output cout);
    
    reg [7:0] nb, c;
    reg one = 1;
    
    always@(*) begin
        nb <= b ^ {8{sel}};
    end
    wire c1,c2,c3, c4, c5, c6, c7;
    
    full_adder f1(a[0], nb[0], sel, z[0], c1);
    full_adder f2(a[1], nb[1], c1, z[1], c2);
    full_adder f3(a[2], nb[2], c2, z[2], c3);
    full_adder f4(a[3], nb[3], c3, z[3], c4);
    full_adder f5(a[4], nb[4], c4, z[4], c5);
    full_adder f6(a[5], nb[5], c5, z[5], c6);
    full_adder f7(a[6], nb[6], c6, z[6], c7);
    full_adder f8(a[7], nb[7], c7, z[7], cout);
    
endmodule