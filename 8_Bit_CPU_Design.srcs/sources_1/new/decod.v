`timescale 1ns / 1ps

module decod(
    input [2:0] w,
    input En,
    output [7:0] y
    );

    dec2to4 decoder1(
        .w0 (w[0]),
        .w1 (w[1]),
        .En (~w[2] & En),
        .y  (y[3:0])
    );

    dec2to4 decoder2(
        .w0 (w[0]),
        .w1 (w[1]),
        .En (w[2] & En),
        .y  (y[7:4])        
    );
endmodule
