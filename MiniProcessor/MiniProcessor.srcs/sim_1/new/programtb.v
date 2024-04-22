`timescale 1ns / 1ps

module program_tb();

reg clock;
reg [2:0] pc;
wire [7:0] inst;

program pro(.clock(clock),.pc(pc),.inst(inst));

initial begin
    clock = 0;
    pc = 0;
    forever #5 clock = ~clock;
end
always @* 
    if(inst == 8'b11111111) 
        $finish;

always @(posedge clock) begin
    #5 pc = pc + 1;
    if(pc == 7)
        #5 $finish;
end
endmodule
