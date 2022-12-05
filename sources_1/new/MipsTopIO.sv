
module MipsTopIO(
    input logic clk,
    input logic reset,
    input logic [1:0] btns,
    input logic selector,
    output logic [6:0] led_segment,
    output logic [3:0] anode_activate,
    output logic dp,
    output logic memwrite);

    logic slow_clk;
    logic [31:0] displayedReg;
    logic [31:0] rd2;
    logic [31:0] aluout;
    logic [31:0] instr;
    logic [15:0] displayed_number;

    SlowClock slowClock(clk, slow_clk);

    MipsTop mips(slow_clk, reset, rd2, aluout, instr, memwrite);

    SevenSegmentTop sevenSegmentTop(
        .clk(clk),
        .displayed_number(displayed_number),
        .led_segment(led_segment),
        .anode_activate(anode_activate),
        .dp(dp));

    always_comb begin
        case (btns)
            0: displayedReg <= instr;
            1: displayedReg <= aluout;
            2: displayedReg <= rd2;
            default: displayedReg <= 0;
        endcase
        case (selector)
            0: displayed_number <= displayedReg[15:0];
            1: displayed_number <= displayedReg[31:16];
        endcase
    end

endmodule
