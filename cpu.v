`timescale 1ns / 1ps
`include "clock.v"
`include "param.v"
`include "register.v"
`include "alu.v"
`include "ram.v"
`include "cu.v"
`include "register_pc.v"

module cpu(
    input clk,
    input reset,
    input program,
    inout wire [`DATA_WIDTH-1:0] data_bus,
    output wire [`ADDR_WIDTH-1:0] addr
);

//wire [`DATA_WIDTH-1:0] addr;
// wire clk;

// clock clock(
//     .clk(clk)
// );
wire [3:0] sel_alu;
wire[`DATA_WIDTH-1:0] data1, data2,flag, alu_out;

reg [`ADDR_WIDTH-1:0] in_pc;
wire [`ADDR_WIDTH-1:0] out_pc;
wire en_pc, rst_pc, inc_pc;

wire en_ir, rst_ir;
wire [`ADDR_WIDTH-1:0] in_ir;
wire [`ADDR_WIDTH-1:0] out_ir;

wire en_mar, rst_mar;
wire [`ADDR_WIDTH-1:0] in_mar, out_mar;

wire [`DATA_WIDTH-1:0] mem_data;

wire [2:0] state;
wire [`DATA_WIDTH-1:0] registers[7:0];

wire [`DATA_WIDTH-1:0] instruction;

cu cu(
    .clk(clk),
    .reset(reset),
    .program(program),
    .flag(flag),
    .instruction(instruction),
    .en_ir(en_ir),
    .rst_ir(rst_ir),
    .en_pc(en_pc),
    .rst_pc(rst_pc),
    .inc_pc(inc_pc),
    .en_mar(en_mar),
    .rst_mar(rst_mar),
    .rw_mem(rw_mem),
    .en_mem(en_mem),
    .sel_alu(sel_alu),
    // .addr(addr),
    .state(state)
);


pc pc(
    .clk(clk),
    .reset(rst_pc),
    .enable(en_pc),
    .inc(inc_pc),
    .in(in_pc),
    .out(out_pc)
);

register ir(
    .clk(clk),
    .reset(rst_ir),
    .enable(en_ir),
    .in(in_ir),
    .out(out_ir)
);

register mar(
    .clk(clk),
    .reset(rst_mar),
    .enable(en_mar),
    .in(in_mar),
    .out(out_mar)
);


alu alu(
    .sel(sel_alu),
    .a(data1),
    .b(data2),
    .z(alu_out),
    .flag(flag)
);

ram ram(
    .clk(clk),
    .rw(rw_mem),
    .memio(en_mem),
    .addr(addr),
    .data(mem_data)
);

// assign data1 = registers[0];
// assign data2 = registers[instruction[2:0]];

assign in_mar = out_pc;
assign addr = out_mar;
assign data_bus = (!program & en_mem) ? mem_data : alu_out;
assign in_ir = data_bus;
// assign mem_data = program ? data_bus:'bz;

initial begin
    in_pc = 0;
    // reset = 1;
end

always @(posedge clk) begin
        $display("addr, data, state = %h, %h, %d", out_mar, data_bus, state);
    end

endmodule
 