`timescale 1ns / 1ps

module InstructionDecoder(
input [7:0] inst,
output reg [3:0] operandAdd,
output reg [3:0] alu_op,
output reg single
);

always @* begin
    alu_op = inst[7:4];
    if (inst[7:4] == 4'b0000) begin
        operandAdd = 8'hff;
        single = 1;
    end
    else begin
        operandAdd = inst[3:0];
        single = 0;
    end
end

endmodule

