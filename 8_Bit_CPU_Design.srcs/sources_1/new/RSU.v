`timescale 1ns / 1ps

module RSU(
    input [7:0] A,
    input res, clk,
    output reg [7:0] Q
    );

    always @(posedge res or posedge clk) begin
        if (res)
            Q <= 8'b00000000;
        else
            Q <= A;
    end        
endmodule
