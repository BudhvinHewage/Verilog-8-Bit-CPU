`timescale 1ns / 1ps

module dec2to4(
    input w0, w1, En,
    output reg [3:0] y
);
    reg [2:0] sel;

    always @(*) begin
        sel = {En, w1, w0}; 
        
        case (sel)
            3'b100:  y = 4'b0001;
            3'b101:  y = 4'b0010;
            3'b110:  y = 4'b0100;
            3'b111:  y = 4'b1000;
            default: y = 4'b0000; 
        endcase
    end

endmodule