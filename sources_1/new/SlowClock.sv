`timescale 1ns / 1ps

// counts 1 second
module SlowClock(
    input logic clk_in,
    output logic clk_out);
    
    logic [25:0] counter = 0;
    logic state = 0;
    
    always_ff @(posedge clk_in) begin
        counter <= counter + 1;
        if (counter == 50_000_000 - 1)
          begin
            counter <= 0;
            state <= ~state;
          end
    end
    
    assign clk_out = state;
    
endmodule
