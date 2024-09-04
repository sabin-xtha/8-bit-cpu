`timescale 1ns / 1ps
module full_adder(
    input a,b,cin,
    output s,cout
    );
wire c1, s1, c2;

half_adder h1(a,b,s1,c1);
half_adder h2(cin, s1, s, c2);
assign  cout  = c1 | c2;

endmodule
