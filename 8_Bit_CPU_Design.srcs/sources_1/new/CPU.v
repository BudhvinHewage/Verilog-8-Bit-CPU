`timescale 1ns / 1ps

module CPU(
    // System Inputs
    input clk,
    input data_in,
    input Reset_All,
    
    
    // RSU Inputs
    input [7:0] A,
    input [7:0] B,
    
    // Decoder & Control Inputs
    input Enable_Decoder,
    
    // System Outputs
    output [7:0] OpCodeCheck,
    output [7:0] RCheck,
    
    // Seven Segment Outputs
    output [6:0] Led,
    output [3:0] Anodes
);

    // Internal Wires
    wire Reset_A,Reset_B,Reset_C,FSM_Reset;
    wire [2:0] current_state_wire;
    wire [7:0] opcode_wire;
    wire [7:0] reg1_wire;
    wire [7:0] reg2_wire;
    wire [7:0] result_wire;

    // Direct input connections to internal wires
    assign Reset_A = Reset_All;
    assign Reset_B = Reset_All;
    assign Reset_C = Reset_All;
    assign FSM_Reset = Reset_All;
    
    // Direct output connections from internal wires
    assign OpCodeCheck = opcode_wire;
    assign RCheck      = result_wire;

    // 1. Machine (FSM) Instantiation
    machine machine (
        .clk(clk),
        .data_in(data_in),
        .reset(FSM_Reset),
        .current_state(current_state_wire)
    );

    // 2. Decoder Instantiation
    decod decod (
        .w(current_state_wire),
        .En(Enable_Decoder),
        .y(opcode_wire)
    );

    // 3. First RSU Instance (Register A)
    RSU RSU1 (
        .clk(clk),
        .res(Reset_A),
        .A(A),
        .Q(reg1_wire)
    );

    // 4. Second RSU Instance (Register B)
    RSU RSU2 (
        .clk(clk),
        .res(Reset_B),
        .A(B),
        .Q(reg2_wire)
    );

    // 5. ALU Instantiation
    ALU ALU (
        .clk(clk),
        .res(Reset_C),
        .opcode(opcode_wire),
        .Reg1(reg1_wire),
        .Reg2(reg2_wire),
        .result(result_wire)
    );

    // 7. First Four Bits (R[3..0]) 7-Segment Display
    sseg Full_Display (
        .clk(clk),
        .FirstFour(result_wire[3:0]),
        .SecondFour(result_wire[7:4]),
        .led(Led),
        .anodes(Anodes)
    );

endmodule