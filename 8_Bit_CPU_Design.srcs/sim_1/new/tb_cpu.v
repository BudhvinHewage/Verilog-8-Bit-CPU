`timescale 1ns / 1ps

module tb_cpu;
    reg clk, data_in;
    reg [7:0] A, B;
    reg Reset_All;
    reg Enable_Decoder;

    wire [7:0] OpCodeCheck, RCheck;
    wire [6:0] Led;
    wire [3:0] Anodes;
    
    CPU DUT (
        .clk(clk),
        .data_in(data_in),
        .Reset_All(Reset_All),
        .A(A),
        .B(B),
        .Enable_Decoder(Enable_Decoder),
        .OpCodeCheck(OpCodeCheck),
        .RCheck(RCheck),
        .Led(Led),
        .Anodes(Anodes)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        Reset_All = 1;
        data_in = 0;
        Enable_Decoder = 0;
        A = 8'd0; B = 8'd0;
        #10;
        Reset_All = 0;
        A = 8'd6; B = 8'd4;
        #10;
        Enable_Decoder = 1;
        repeat (8) begin 
            #10;
            $display("The current result is %0d", RCheck);
            @(negedge clk); data_in = 1;
            @(negedge clk); data_in = 0;      
        end
        #10 $finish;
    end

endmodule
