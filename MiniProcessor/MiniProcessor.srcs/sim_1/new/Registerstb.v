`timescale 1ns / 1ps

module regfiletb();

reg clock;
reg [3:0] readAdd;
reg [3:0] writeAdd;
reg write, reset;
reg [7:0] writeData;
wire [7:0] acc;

RegisterFile obj (
    .clock(clock), 
    .readAdd(readAdd),
    .writeAdd(writeAdd), 
    .write(write), 
    .reset(reset), 
    .writeData(writeData),
    .readData(acc));

initial begin
    clock = 0;
    forever #5 clock = ~clock;
end

initial begin
    reset = 1;
    #10;
    reset = 0;
    write = 1;
    readAdd = 4'b1000;
    writeAdd = 4'b1010;
    writeData = 8'b10101010;
    #10;
    write = 0;
    writeAdd = 4'b1000;
    writeData = 8'b10100000;
    #10;
    write = 1;
    writeAdd = 4'b1110;
    writeData = 8'b10111110;
    #10;
    write = 0;
    #10 $finish;
end

endmodule