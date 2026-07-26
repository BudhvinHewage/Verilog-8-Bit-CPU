`timescale 1ns / 1ps

module sseg (
    input clk,
    input  [3:0] FirstFour, SecondFour,
    output reg [6:0] led,
    output reg [3:0] anodes
);
    reg [17:0] refresh_counter = 0;
    
    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1'b1;
    end
    
    wire [1:0] digit_select = refresh_counter[17:16];

    reg [6:0] led1_seg, led2_seg;
    reg [6:0] led1_sign, led2_sign;
        
    always @(*) begin
        if (FirstFour[3] == 1'b0)
            led1_sign = ~7'b0000000;
        else
            led1_sign = ~7'b0000001;
        
        if (SecondFour[3] == 1'b0)
            led2_sign = ~7'b0000000;
        else
            led2_sign = ~7'b0000001;   
                     
        case (FirstFour)
            4'b0000:          led1_seg = ~7'b1111110; // Display 0
            4'b0001, 4'b1111: led1_seg = ~7'b0110000; // Display 1
            4'b0010, 4'b1110: led1_seg = ~7'b1101101; // Display 2
            4'b0011, 4'b1101: led1_seg = ~7'b1111001; // Display 3
            4'b0100, 4'b1100: led1_seg = ~7'b0110011; // Display 4
            4'b0101, 4'b1011: led1_seg = ~7'b1011011; // Display 5
            4'b0110, 4'b1010: led1_seg = ~7'b1011111; // Display 6
            4'b0111, 4'b1001: led1_seg = ~7'b1110000; // Display 7
            4'b1000:          led1_seg = ~7'b1111111; // Display 8
            default:          led1_seg = ~7'b0000000; 
        endcase
        case (SecondFour)
            4'b0000:          led2_seg = ~7'b1111110; // Display 0
            4'b0001, 4'b1111: led2_seg = ~7'b0110000; // Display 1
            4'b0010, 4'b1110: led2_seg = ~7'b1101101; // Display 2
            4'b0011, 4'b1101: led2_seg = ~7'b1111001; // Display 3
            4'b0100, 4'b1100: led2_seg = ~7'b0110011; // Display 4
            4'b0101, 4'b1011: led2_seg = ~7'b1011011; // Display 5
            4'b0110, 4'b1010: led2_seg = ~7'b1011111; // Display 6
            4'b0111, 4'b1001: led2_seg = ~7'b1110000; // Display 7
            4'b1000:          led2_seg = ~7'b1111111; // Display 8
            default:          led2_seg = ~7'b0000000; 
        endcase
    end
    
    always @(*) begin
        case (digit_select)
            2'b00: begin
                anodes = 4'b1110;        
                led    = led1_seg;       
            end
            2'b01: begin
                anodes = 4'b1101;        // Turn ON Digit 1
                led    = led1_sign;     // Off (or map SecondFour here)
            end
            2'b10: begin
                anodes = 4'b1011;        // Turn ON Digit 2
                led    = led2_seg;     // Off
            end
            2'b11: begin
                anodes = 4'b0111;        // Turn ON Digit 3 (Leftmost)
                led    = led2_sign;     // Off
            end
        endcase
    end

endmodule
