`timescale 1ns / 1ps

module Instdecodertb();

reg [7:0] inst;
wire [3:0] operand2;
wire [3:0] alu_op;
wire single;

InstructionDecoder obj(.single(single),.inst(inst),.operand2(alu_op),.opcode(alu_op));

initial begin
    inst = 8'b0;
    #10 inst = 8'b00101010;
    #10 inst = 8'b00010001;
    #10 $finish;
end

endmodule
