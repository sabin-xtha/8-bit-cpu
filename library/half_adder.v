`timescale 1ns / 1ps
module half_adder(
    input a, b,
    output s, cout
    );
    
    assign s = a^b;
    assign cout = a&b;
endmodule
