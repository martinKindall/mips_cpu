`timescale 1ns / 1ps

module FlopR #(parameter WIDTH=8)(
    input logic clk, reset,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q);
    
    always_ff @(posedge clk)
        if (reset)
            q <= 0;
        else
            q <= d;
    
endmodule
