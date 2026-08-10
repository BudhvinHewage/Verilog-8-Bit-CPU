`timescale 1ns / 1ps

module machine(
    input data_in, clk, reset,
    output reg [2:0] current_state
);
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    parameter S5 = 3'b101;
    parameter S6 = 3'b110;
    parameter S7 = 3'b111;
    
    reg data_in_previous_state; 
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            data_in_previous_state <= 1'b0;
        else 
            data_in_previous_state <= data_in;            
    end
    
    wire data_in_current_state = data_in && !data_in_previous_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= S0;
        else if (data_in_current_state)
            case (current_state)
                S0: if (data_in) current_state <= S1;
                S1: if (data_in) current_state <= S2;
                S2: if (data_in) current_state <= S3;
                S3: if (data_in) current_state <= S4;
                S4: if (data_in) current_state <= S5;
                S5: if (data_in) current_state <= S6;
                S6: if (data_in) current_state <= S7;
                S7: if (data_in) current_state <= S0;
                default: current_state <= S0;
            endcase
    end
endmodule
