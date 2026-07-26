`timescale 1ns / 1ps

module tb_cpu;
    reg clk, data_in, FSM_Reset;
    reg [7:0] A, B;
    reg Reset_A, Reset_B, Enable_Decoder, Reset_C;

    wire [7:0] OpCodeCheck, RCheck;
    wire [6:0] Led;
    wire [3:0] Anodes;
    
    CPU DUT (
        .clk(clk),
        .data_in(data_in),
        .FSM_Reset(FSM_Reset),
        .A(A), .Reset_A(Reset_A),
        .B(B), .Reset_B(Reset_B),
        .Enable_Decoder(Enable_Decoder),
        .Reset_C(Reset_C),
        .OpCodeCheck(OpCodeCheck),
        .RCheck(RCheck),
        .Led(Led),
        .Anodes(Anodes)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        FSM_Reset = 1;
        data_in = 0;
        Reset_A = 1; Reset_B = 1; Reset_C = 1;
        Enable_Decoder = 0;
        A = 8'd0; B = 8'd0;
        #10;
        FSM_Reset = 0;
        Reset_A = 0; Reset_B = 0; Reset_C = 0;
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
