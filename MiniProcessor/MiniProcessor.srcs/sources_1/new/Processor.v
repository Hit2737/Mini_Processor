`timescale 1ns / 1ps

module processor(
    input real_clock, reset, En, write2,
    input [4:0] displayAdd,
    output reg CB, 
    output reg [7:0] display, writeData2,  // nothing, acc, ext, inst, & all registers
    output wire clock,
    output reg [2:0] pc_out
);

slowing_the_clock slwclk(.clk(real_clock),.clk_out(clock));

reg [2:0] PC;
reg [7:0] ACC, EXT;
reg [7:0] inst;

wire [7:0] tempinst;
wire tempCB,single;
wire [3:0] regAdd,alu_op;
wire [7:0] tempReg, tempACC, tempEXT, tempReg2;

reg [3:0] readAdd, writeAdd, readAdd2, writeAdd2;
reg [7:0] readData, writeData, readData2;
reg  tempPC, write;
reg stop;
initial begin
    PC = 0;
    CB = 0;
    ACC = 0;
    EXT = 0;
    inst = 0;
    readAdd = 0;
    readData = 0;
    writeAdd = 0;
    writeAdd2 = 0;
    readAdd2 = 0;
    readData2 = 0;
    writeData = 0;
    display = 0;
    stop = 0;
end

and(Enclock,En,clock);

program pgm(.clock(Enclock),
            .pc(PC),
            .inst(tempinst));

InstructionDecoder pm(.inst(inst),
            .operandAdd(regAdd),
            .single(single),
            .alu_op(alu_op));

RegisterFile r(.clock(Enclock),
            .write(write),
            .reset(reset), 
            .readAdd(readAdd), 
            .writeAdd(writeAdd), 
            .writeData(writeData), 
            .readData(tempReg));

RegisterFile r2(.clock(clock),
            .write(write2),
            .reset(reset),
            .readAdd(readAdd2),
            .writeAdd(writeAdd2),
            .writeData(writeData2),
            .readData(tempReg2));
            
ALU alu(.clock(Enclock),
            .operand1(ACC),
            .operand2(readData),
            .single(single),
            .alu_op(alu_op),
            .result(tempACC),
            .EXT(tempEXT),
            .cb(tempCB));

always @(posedge real_clock) begin
    case(displayAdd)
        5'b00001: display = ACC;
        5'b00010: display = EXT;
        5'b00011: display = inst;
        default: display = 0;
    endcase   
    if(displayAdd[4]) begin
        readAdd2 = displayAdd[3:0];
        display = tempReg2;
        if(write) begin
            writeAdd2 = displayAdd[3:0];
        end
    end
end

always @(posedge Enclock) begin
    if(reset) begin
        PC = 0;
        CB = 0;
        ACC = 0;
        EXT = 0;
        readAdd = 0;
        readData = 0;
        writeAdd = 0;
        writeData = 0;
        stop = 0;
    end
    else if (!reset) begin
        if(alu_op == 8 & CB == 1) begin
            tempPC = PC + 1;
            PC = regAdd;
            write = 1;
            writeData = tempPC;
        end
        else if (alu_op == 9) begin
            ACC = readData;
        end 
        else if (alu_op == 10) begin
            write = 1;
            writeData = ACC;
        end
        else if(alu_op == 11) begin
            PC = tempPC;
        end
        else if(alu_op == 15) begin
            stop = 1;
        end
        if(!stop) begin
            pc_out = PC;
            PC = PC + 1;
            ACC = tempACC;
            EXT = tempEXT;
            inst = tempinst;
            readData = tempReg;
            readAdd = regAdd;
            writeAdd = regAdd;
            CB = tempCB;
        end
    end
end
endmodule

module slowing_the_clock(
input clk,
output reg clk_out
);
reg [31:0] counter = 0;
always @(posedge clk) begin
    counter <= counter + 1;
    clk_out <= counter[27];
end
endmodule
