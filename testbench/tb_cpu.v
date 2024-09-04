`timescale 1ns/1ps

module tb_cpu ();
    reg clk;
    reg reset;
    reg program;
    reg [`DATA_WIDTH-1:0] buffer;
    wire [`DATA_WIDTH-1:0] data;
    wire [`ADDR_WIDTH-1:0] addr;

    cpu uut(
    .clk(clk),
    .reset(reset),
    .program(program),
    .data_bus(data),
    .addr(addr)
    );

initial begin
        $dumpfile("simulations/tb_cpu.vcd");
        $dumpvars(0, tb_cpu);
    end

    // initial begin
    //     reset = 1;
    //     program = 1;

    //     // addr = 0;
    //     buffer = 8'h00;
    //     clk = 1;
    //     #1;
    //     clk = 0;
    //     #1;

    //     // addr = 1;
    //     buffer = 8'h50;
    //     clk = 1;
    //     #1;
    //     clk = 0;
    //     #1;

    //     // addr = 2;
    //     buffer = 8'h09;
    //     clk = 1;
    //     #1;
    //     clk = 0;

    //     // addr = 3;
    //     buffer = 8'h30;
    //     clk = 1;
    //     #1;
    //     clk = 0;
    //     #1;

    //     // addr = 4;
    //     buffer = 8'h69;
    //     clk = 1;
    //     #1;
    //     clk = 0;
    //     #1;

    //     // addr = 5;
    //     buffer = 8'h57;
    //     clk = 1;
    //     #1;
    //     clk = 0;
    //     #1;

    //     // addr = 6;
    //     buffer = 8'h30;
    //     clk = 1;
    //     #1;
    //     clk = 0;
    //     #1;

    //     program = 0;


    //     // $display("data at 4 :: %h", data);

    // end

initial begin
    program = 0;
    reset = 0;
    clk=0; #1;
    clk=1; #1;
    reset = 1;
    clk=0; #1;
    clk=1; #1;
    clk=0; #1;
    clk=1; #1;
    clk=0; #1;
    clk=1; #1;
    clk=0; #1;
    clk=1; #1;
    clk=0; #1;
    clk=1; #1;
    clk=0; #1;
    clk=1; #1;
    clk=0; #1;
    clk=1; #1;
    clk=0; #1;
    clk=1; #1;
    clk=0; #1;
    clk=1; #1;
end
assign data = program ? buffer : 'bz;

// always @(posedge clk) begin
//         $display("data = %d, %d", data, addr);
//     end
endmodule