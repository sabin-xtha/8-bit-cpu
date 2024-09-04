`timescale 1ns / 1ps
`include "param.v"

module cu(
    input clk,
    input program,
    input reset,
    input [`DATA_WIDTH-1:0] flag,
    input [`DATA_WIDTH-1:0] instruction,
    output reg en_ir, rst_ir, en_pc, rst_pc, inc_pc, en_mar, rst_mar, rw_mem, en_mem,
    output reg [3:0] sel_alu,
    output reg [2:0] state
    );

    reg cycle;
    reg [7:0] opcode;
    initial begin
        cycle = 0;
        state = `FI;
        en_pc = 1;

        rst_ir = reset;
        rst_mar = reset;
        rst_pc = reset;
    end

    always @(posedge clk) begin
        if(instruction[2:0] == instruction[5:3])    opcode = `OP_LDI;
        else if(instruction[7:6] == `MOV)           opcode = `OP_MOV;
        else if(instruction[7:6] == `ARITHMATIC)    opcode = `OP_ALU;
        else if(instruction[7:6] == `LOGICAL)       opcode = `OP_ALU;
        else if(instruction[7:6] == `JUMP)          opcode = `OP_JUMP;
        else if(instruction == 8'b00000000)         opcode = `OP_NOP;
        else                                        opcode = `OP_HALT;
    end 

    always @(posedge clk) begin
        if(program) begin
            en_mem <= 1;
            rw_mem <= 0;

            en_pc <= 1;
        end
        // else begin
        // case(state)
        //     `FI:
        //     begin
        //         // inc_pc = 1;
        //         en_mar <= 1;
        //         en_mem <= 1;
        //         rw_mem <= 1;
        //         en_ir <= 1;
        //         state <= `DI;
        //     end
        //     `DI:
        //     begin
                // inc_pc <= 1;
                // en_mem = 0;
                // en_ir = 1;
                // state <= `FI;

            //     case (opcode & 8'b11000000)
            //         `MOV:
            //             begin
            //                 if(((opcode>>3) & 8'b00000111) == (opcode & 8'b00000111))
            //                     begin
            //                         state <= `FO;
            //                     end

            //                 // registers[(opcode>>3) & 8'b00000111] <= registers[opcode & 8'b00000111];
            //             end

            //         `ARITHMATIC:
            //             begin
            //                 // data1 <= registers[0];
            //                 // data2 <= registers[opcode[2:0]];
            //                 sel_alu <= opcode[5:3];
            //             end
            //     endcase
            // end
            // `FO:
            // begin
            //     en_mem <= 1;
            //     rw_mem <= 1;
            //     en_ir <= 1;
            // end

        //     endcase
        // end


        case (cycle)
            T1: state = `STATE_FETCH_PC;
            T2: state = `STATE_FETCH_INST;
            T3: state = (opcode == `OP_HALT)?   `STATE_HALT:
                        (opcode == `OP_MOV)?    `STATE_MOV_FETCH:
                        (opcode == `OP_ALU)?    `STATE_ALU_EXEC:
                        (opcode == `OP_LDI)?    `STATE_FETCH_PC:
                        `STATE_NEXT;
            T4: state = (opcode == `OP_LDI)?   `STATE_SET_REG:
                        (opcode == `OP_MOV)?   `STATE_MOV_LOAD:
                        // (opcode ==)?   :
                        // (opcode ==)?   :
                        // (opcode ==)?   :
                        `STATE_NEXT;
            T5: state = `STATE_NEXT;
            default: 
        endcase
        cycle = (cycle > 8) ? 0 : cycle +1;
        end
endmodule
