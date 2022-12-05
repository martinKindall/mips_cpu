
module IMemTop(
    input logic clk,
    input logic [1:0] btns,
    input logic selector,
    output logic [6:0] led_segment,
    output logic [3:0] anode_activate,
    output logic dp);

    logic [31:0] read;
    logic [15:0] displayed_number;

    IMem iMem({4'b0, btns}, read);

    SevenSegmentTop sevenSegmentTop(
        .clk(clk),
        .displayed_number(displayed_number),
        .led_segment(led_segment),
        .anode_activate(anode_activate),
        .dp(dp));
    
    always_comb
        case (selector)
            0: displayed_number <= read[15:0];
            1: displayed_number <= read[31:16];
        endcase

endmodule