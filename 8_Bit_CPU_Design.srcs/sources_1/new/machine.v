`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2026 02:54:15 PM
// Design Name: 
// Module Name: machine
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


module machine(
    input data_in, clk, reset,
    output reg [2:0] current_state
);
    reg [2:0] yfsm;
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    parameter S5 = 3'b101;
    parameter S6 = 3'b110;
    parameter S7 = 3'b111;

    always @(posedge clk or posedge reset) begin
        if (reset)
            yfsm <= S0;
        else begin
            case (yfsm)
                S0: if (data_in) yfsm <= S1;
                S1: if (data_in) yfsm <= S2;
                S2: if (data_in) yfsm <= S3;
                S3: if (data_in) yfsm <= S4;
                S4: if (data_in) yfsm <= S5;
                S5: if (data_in) yfsm <= S6;
                S6: if (data_in) yfsm <= S7;
                S7: if (data_in) yfsm <= S0;
            endcase
        end
    end

    always @(*) begin
        case (yfsm)
            S0: current_state = 3'b000;
            S1: current_state = 3'b001;
            S2: current_state = 3'b010;
            S3: current_state = 3'b011;
            S4: current_state = 3'b100;
            S5: current_state = 3'b101;
            S6: current_state = 3'b110;
            S7: current_state = 3'b111;
            default: current_state = 3'b000;
        endcase
    end

endmodule
