`timescale 1ns/1ps

module bpa(
    input [7:0] a, 
    input [7:0] b,
    input cin,
    output [7:0] s,
    output cout);
    
//    $display("%b",b[0]);
    
    wire c1,c2,c3, c4, c5, c6, c7;
    full_adder f1(a[0], b[0], cin, s[0], c1);
    full_adder f2(a[1], b[1], c1, s[1], c2);
    full_adder f3(a[2], b[2], c2, s[2], c3);
    
    full_adder f4(a[3], b[3], c3, s[3], c4);
    full_adder f5(a[4], b[4], c4, s[4], c5);
    full_adder f6(a[5], b[5], c5, s[5], c6);
    full_adder f7(a[6], b[6], c6, s[6], c7);
    
    full_adder f8(a[7], b[7], c7, s[7], cout);
endmodule