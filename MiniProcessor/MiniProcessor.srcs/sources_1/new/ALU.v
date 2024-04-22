`timescale 1ns / 1ps

module ALU(
input clock,
input [7:0] operand1,
input [7:0] operand2,
input [3:0] alu_op,
input single,
output reg [7:0] result,
output reg [7:0] EXT,
output reg cb
);

reg [15:0] temp;
always @(posedge clock) begin
    EXT = 0;
    if (single == 1) begin
        if (alu_op==1) begin
            result = operand1 <<< 1;
        end
        else if (alu_op==2) begin
            result = operand1 >>> 1;
        end
        else if (alu_op==3) begin
            result[7] = operand1[0];
            result[6:0] = operand1[7:1];
        end
        else if (alu_op==4) begin
            result[0] = operand1[7];
            result[7:1] = operand1[6:0];
        end
        else if (alu_op == 5) begin
            result[7] = operand1[7];
            result[6:0] = operand1[7:1];
        end
        else if (alu_op == 6) begin
            if (operand1 == 255) begin
                result = 0;
                cb = 1;
            end
            else begin
                result = operand1 + 1;
            end
        end
        else if (alu_op == 7) begin
            if (operand1 == 0) begin
                result = 255;
                cb = 1;
            end
            else begin
                result = operand1 - 1;
            end
        end
    end
    else begin
        if (alu_op==1) begin
            temp = operand1 + operand2;
            cb = temp[8];
            result = temp[7:0];
        end
        else if (alu_op==2) begin
            temp = operand1 - operand2;
            cb = temp[8];
            result = temp[7:0];
        end
        else if (alu_op==3) begin
            temp = operand1 * operand2;
            EXT = temp[15:8];
            result = temp[7:0];
        end
        else if (alu_op==4) begin
            EXT = operand1 % operand2;
            result = operand1 / operand2;
        end
        else if (alu_op == 5) begin
            result = operand1 & operand2;
        end
        else if (alu_op==6) begin
            result = operand1 ^ operand2;
        end
        else if (alu_op==7) begin
            if (operand1 >= operand2) 
                cb = 0;
            else 
                cb = 1;
        end
        else begin
            result = 0;
            EXT = 0;
        end
    end
end

endmodule