`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2026 03:16:26 PM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input clk, res,
    input [7:0] Reg1, Reg2, opcode,
    input [3:0] studentID,
    output reg [7:0] result,
    output reg [3:0] check
    );

always @(clk or res) begin
    if res
        result <= 8b'00000000;
    else
        case (opcode)
            8b'00000001: result <= Reg1 + 2;                // Add 2 to Reg1 
            8b'00000010: result <= Reg1 >> 2;               // Logical right shift by 2 or divide by 4
            8b'00000100: 
                if (Reg1 > Reg2)
                    result <= Reg2;                         // Set to Reg2 if Reg1 is greater than Reg2
                else
                    result <= Reg1;                         // Otherwise, set to Reg1
            8b'00001000: result <= Reg1[0:1] & Reg1[7:2];   // Bitwise AND of the least significant 2 bits and the most significant 6 bits of Reg1
            8b'00010000: result <= NOT (Reg2);              // Bitwise NOT of Reg2
            8b'00100000: result <= XOR (Reg1, Reg2);        // Bitwise OR of Reg1 and Reg2
            8b'01000000: result <= Reg1 + Reg2 - 4;         // Add Reg1 and Reg2, then subtract 4
            8b'10000000: result <= Reg1 << 1;               // Logical left shift by 1 or multiply by 2
            default: 
                result <= 8b'00000000;                      // Default case
        endcase
endmodule
