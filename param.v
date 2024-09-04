`ifndef PARAM
`define PARAM

`define ADDR_WIDTH 8
`define DATA_WIDTH 8

//registers A,B, R1,R2,R3,R4, R5,F
//IR,PC,MAR,MBR
//
`define FI  3'b000
`define DI  3'b001
`define FO  3'b010
`define EI  3'b011

//registers
`define A 3'b000
`define B 3'b001
`define C 3'b010
`define R1 3'b011
`define R2 3'b100
`define R3 3'b101
`define R4 3'b110
`define M 3'b111

//instruction header
`define MOV        2'b00
`define ARITHMATIC  2'b01
`define LOGICAL     2'b10
`define JUMP        2'b11

//arithmatic instruction
`define NOP 3'b000
`define ADD 3'b001
`define SUB 3'b010
`define INC 3'b011
`define DEC 3'b100
`define ADC 3'b101
`define MUL 3'b110
`define DIV 3'b111

//logical instruction
`define AND 3'b000
`define OR  3'b001
`define XOR 3'b010
`define NOT 3'b011
`define SHR 3'b100
`define SHL 3'b101
`define ROR 3'b110
`define ROL 3'b111

/***********************
instruction format
mov r1, r2 --> 8'b00___, ___(reg,reg)
arithmatic op --> 8'b10 ___,___(opcode,reg)
logical --> 8'b11___,___(op, reg)
jump and others --> 8'b11___,___()
************************/

//T states
`define T1 3'b000
`define T2 3'b001
`define T3 3'b010
`define T4 3'b011
`define T5 3'b100
`define T6 3'b101
`define T7 3'b110
`define T8 3'b111

//execution states
`define STATE_NEXT          8'b00000000
`define STATE_FETCH_PC      8'b00000001
`define STATE_FETCH_INST    8'b00000010
`define STATE_ALU_EXEC      8'b00000011
`define STATE_SET_REG       8'b00000100
`define STATE_MOV_FETCH     8'b00000101
`define STATE_HALT          8'b00000110

//opcodes
`define OP_NOP  8'h00
`define OP_HALT 8'h01
`define OP_MOV  8'h02
`define OP_ALU  8'h03
`define OP_LDI  8'h04
`define OP_JUMP 8'h05

`endif

