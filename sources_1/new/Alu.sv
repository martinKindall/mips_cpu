`timescale 1ns / 1ps

// behavioural implementation
module Alu #(parameter WIDTH=32) (
    input logic [WIDTH-1:0] srca, srcb,
    input logic [2:0] alucontrol,
    output logic [WIDTH-1:0] aluout,
    output logic zero
    );
    
    always_comb
        case (alucontrol)
            3'b000: aluout <= srca & srcb;
            3'b001: aluout <= srca | srcb;
            3'b010: aluout <= srca + srcb;
            3'b110: aluout <= srca - srcb;
            3'b111: aluout <= srca < srcb;
            default: aluout <= 0;
        endcase
    
    assign zero = ~| aluout;
    
endmodule
