`timescale 1ns / 1ps

module SevenSegRegister(
        input logic clk,
        input logic we3,
        input logic selector,
        output logic [6:0] led_segment,
        output logic [3:0] anode_activate,
        output logic dp);
    
    logic [31:0] regOutput;
    logic [15:0] displayed_number;
    logic unconn;
    logic [25:0] aCounter;
    logic limited;
    
    always_ff @(posedge clk)
        aCounter <= aCounter + 1;
        
    InputLimiter inputLimiter(
        .clk(clk),
        .selector(we3),
        .limited(limited)
    );
    
    regfile my_reg(
        .clk(clk),
        .we3(limited),
        .ra1(1'b1),
        .ra2(2'b10),
        .wa3(1'b1),
        .wd3({~aCounter[25:10], aCounter[25:10]}),
        .rd1(regOutput),
        .rd2(unconn)
    );
    
    SevenSegmentTop sevenSegmentTop(
        .clk(clk),
        .displayed_number(displayed_number),
        .led_segment(led_segment),
        .anode_activate(anode_activate),
        .dp(dp));
    
    always_comb
        case (selector)
            0: displayed_number <= regOutput[15:0];
            1: displayed_number <= regOutput[31:16];
        endcase 
    
endmodule
