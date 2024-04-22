`timescale 1ns / 1ps

module program(
input clock,
input [2:0] pc,
output reg [7:0] inst
);

reg [7:0] programReg [7:0];

initial begin
    programReg[0] = 8'b10010000;
    programReg[1] = 8'b01100000;
    programReg[2] = 8'b00010100;
    programReg[3] = 8'b00010101;
    programReg[4] = 8'b10100110;
    programReg[5] = 8'b11111111;
    programReg[6] = 8'b00011111;
    programReg[7] = 8'b00010000;
end
initial begin 
    inst = 0;
end
always @(posedge clock)
    inst = programReg[pc];
 
endmodule
