`timescale 1ns / 1ps

module RegisterFile (
    input clock, write, reset,
    input [3:0] readAdd, writeAdd,
    input [7:0] writeData,
    output reg [7:0] readData
);

reg [7:0] registers [15:0];
initial begin           // Initiallizing the registers
    registers[0] = 10;
    registers[1] = 20;
    registers[2] = 30;
    registers[3] = 40;
    registers[4] = 50;
    registers[5] = 60;
    registers[6] = 70;
    registers[7] = 80;
    registers[8] = 90;
    registers[9] = 100;
    registers[10] = 110;
    registers[11] = 120;
    registers[12] = 130;
    registers[13] = 140;
    registers[14] = 150;
    registers[15] = 160;
end
integer j;
always @(posedge clock) begin
    if (reset) begin
        for (j = 0; j < 16; j = j + 1) begin
            registers[j] <= j; // On reseting we are initializing registers with numbers 0 to 15.
        end
    end else if (write) begin
        registers[writeAdd] <= writeData;
    end
    readData <= registers[readAdd];
end

endmodule