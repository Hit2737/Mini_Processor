`timescale 1s/1ps

module processor_tb;

// Inputs
reg clock;
reg reset;
reg En;
reg [1:0] displayAdd;

// Outputs
wire CB;
wire [7:0] display;
wire slow_clock;
wire [2:0] pc;
// Instantiate the processor module
processor dut(
    .real_clock(clock),
    .reset(reset),
    .En(En),
    .displayAdd(displayAdd),
    .CB(CB),
    .display(display),
    .clock(slow_clock),  // Use real clock for simulation as you won't be able to see the signals changing due to very low frequency of slow_clock
    .pc(pc)
);

// Clock generation
always #5 clock = ~clock;

// Initial values
initial begin
    clock = 0;
    reset = 1;
    En = 0;
    displayAdd = 0;
    
    // You can write your own instructions for checking the simulation for different inputs
    
    // Wait for a few clock cycles before releasing reset
    #40;
    reset = 0;
    
    // Enable processor
    En = 1;
    
    // Test scenario 1: Write data to register file and read from it
//    write = 1;
    displayAdd = 1;
    #20;
//    write = 1;
//    displayAdd = 2;
    #20;
    
    // Test scenario 2: Perform arithmetic operation
//    write = 1;
//    displayAdd = 3;
    #20;
//    write = 0;
    displayAdd = 1;
    #20;
    
    // Test scenario 3: Test branch instruction
//    write = 1;
    displayAdd = 1;
    #20;
//    displayAdd = 2;
    #20;
    
    // Test scenario 4: Test halt instruction
//    write = 1;
//    displayAdd = 2;
    #20;
//    displayAdd = 3;
    #20;
    
    // Finish simulation after a while
    #100;
    $finish;
end

endmodule
