`timescale 1ns / 1ps

module SevenSegmentTop(
        input logic clk,
        input logic [4:0] btns,
        output logic [6:0] led_segment,
        output logic [3:0] anode_activate,
        output logic dp);
    
    logic [3:0] led_binary;
    logic [6:0] negSegments;
    
    SevenSegmentCtrl sevenSegmentCtrl(
        .clk(clk),
        .displayed_number({11'b00000000000, btns}),
        .anode_activate(anode_activate),
        .led_binary(led_binary)
    );
    
    SevenSegment sevenSegment(
        .binary(led_binary),
        .segments(negSegments)
    );
    
    assign dp = 1;
    assign led_segment = ~negSegments;
    
endmodule
