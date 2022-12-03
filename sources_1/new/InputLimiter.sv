`timescale 1ns / 1ps

module InputLimiter(
        input logic clk,
        input logic selector,
        output logic limited
    );
    
    logic prevState;
    
    always_ff @ (posedge clk)
        if (limited) begin
            limited <= 0;
            prevState <= 1; 
        end
        else if (selector & ~prevState)
            limited <= 1;
        else if (~selector & prevState)
            prevState <= 0;
    
endmodule
