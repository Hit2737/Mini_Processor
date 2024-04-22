# Mini-Processor

We know that computing power hinges on processors. A good processor can prevent system hang-ups and enable seamless gaming experiences. To delve deeper into their inner workings, my friend Ruchit Jagodara and I created a mini-processor. This repository contains our code and results.

## Overview

Real processors execute numerous operations, but our focus was understanding the workings of the processor, so we implemented basic operations. This processor includes operations and their respective operation codes, which are described in below table. The first four bits of these codes specify the operation, while the last four bits indicate the register (a unit of memory) involved. Operations are performed using the accumulator, a pivotal component of the processor. You can learn more about the accumulator [here](https://www.studysmarter.co.uk/explanations/computer-science/computer-organisation-and-architecture/accumulator/#:~:text=An%20accumulator%20functions%20as%20a,main%20memory%20or%20another%20register.).

| Instruction | Opcode | Operation          |
|-------------|--------|--------------------|
| 0000 0000   | NOP    | No operation       |                                                  
| 0001 xxxx   | ADD Ri | Add ACC with Register contents and store the result in ACC. Updates C/B | 
| 0010 xxxx   | SUB Ri | Subtract ACC with Register contents and store the result in ACC. Updates C/B | 
| 0011 xxxx   | MUL Ri | Multiply ACC with Register contents and store the result in ACC. Updates EXT | 
| 0100 xxxx   | DIV Ri | Divide ACC with Register contents and store the Quotient in ACC. Updates EXT with remainder. | 
| 0000 0001   | LSL ACC| Left shift left logical the contents of ACC. Does not update C/B | 
| 0000 0010   | LSR ACC| Left shift right logical the contents of ACC. Does not update C/B | 
| 0000 0011   | CIR ACC| Circuit right shift ACC contents. Does not update C/B | 
| 0000 0100   | CIL ACC| Circuit left shift ACC contents. Does not update C/B | 
| 0000 0101   | ASR ACC| Arithmetic Shift Right ACC contents | 
| 0101 xxxx   | AND Ri | AND ACC with Register contents (bitwise) and store the result in ACC. C/B is not updated | 
| 0110 xxxx   | XRA Ri | XRA ACC with Register contents (bitwise) and store the result in ACC. C/B is not updated | 
| 0111 xxxx   | CMP Ri | CMP ACC with Register contents (ACC-Reg) and update C/B. If ACC>=Reg, C/B=0, else C/B=1 | 
| 0000 0110   | INC ACC| Increment ACC, updates C/B when overflows | 
| 0000 0117   | DEC ACC| Decrement ACC, updates C/B when underflows | 
| 1000 xxxx   | Br <4-bit address> | Update PC and branch to 4-bit address if C/B=1 | 
| 1001 xxxx   | MOV ACC, Ri | Move the contents of Ri to ACC | 
| 1010 xxxx   | MOV Ri, ACC | Move the contents of ACC to Ri | 
| 1011 xxxx   | Ret <4-bit address> | Update PC and return to the called program. | 
| 1111 1111   | HLT    | Stop the program (last instruction) | 

For further understanding, refer to resources on [Program Counter (PC)](https://en.wikipedia.org/wiki/Program_counter#:~:text=The%20program%20counter%20(PC)%2C,computer%20is%20in%20its%20program) and [Register Files](https://en.wikipedia.org/wiki/Register_file#:~:text=A%20register%20file%20is%20an,functional%20units%20on%20the%20chip.).


## Results

Below is a video explaining how our processor works, in which the processor executes the program written in the program.v file which is located inside the processor folder.



## Schematic

Below is the image of what exactly the circuit of this processor looks like.
![Screenshot from 2024-04-22 15-23-25](https://github.com/RuchitJagodara/Mini-Processor/assets/137716667/aa150603-9907-4933-95fb-d379e97d71cb)


Above implementations are made using verilog.

## Installation and trying out the code

If you want to run this code in your vivado software then just open the downloaded folder and you will be able to work with it, but while contributing to this repo you have to contribute through github directly changing the code in vivado won't work because vivado does not provide support to work with git or github directly.

## Contributions

If you want to contribute to this just make a PR. :-)
