`timescale 1ns / 1ps

module ALU(
    input clk, res,
    input [7:0] Reg1, Reg2, opcode,
    output reg [7:0] result
);

    // Sequential logic requires posedge sensitivity
    always @(posedge clk or posedge res) begin
        if (res) begin
            result <= 8'b00000000;
        end else begin
            case (opcode)
                8'b00000001: result <= Reg1 + 8'd2;               // Add 2 to Reg1 [2]
                8'b00000010: result <= Reg1 >> 2;                 // Shift right by 2
                8'b00000100: begin                                // Min function
                    if (Reg1 > Reg2)
                        result <= Reg2;
                    else
                        result <= Reg1;
                end
                
                // Concatenation: {2 LSBs} & {6 MSBs} padded to 8 bits
                8'b00001000: result <= {6'b0, Reg1[1:0]} & {2'b0, Reg1[7:2]}; 
                
                8'b00010000: result <= ~Reg2;                     // Bitwise NOT
                8'b00100000: result <= Reg1 ^ Reg2;               // Bitwise XOR
                8'b01000000: result <= Reg1 + Reg2 - 8'd4;        // Reg1 + Reg2 - 4
                8'b10000000: result <= Reg1 << 1;                 // Shift left by 1
                
                default:     result <= 8'b00000000;
            endcase
        end
    end

endmodule