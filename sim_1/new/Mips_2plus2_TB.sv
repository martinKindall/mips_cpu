`timescale 1ns / 1ps

module Mips_2plus2_TB();

    logic clk, reset;

    logic [31:0] rd2, aluout, instr;
    logic memwrite;

    MipsTop dut(clk, reset, rd2, aluout, instr, memwrite);

    initial
        begin
            reset <= 1; #22; reset <= 0;
        end

    always
        begin
            clk <= 1; #5;
            clk <= 0; #5;
        end

    always @(negedge clk)
        begin
            if (memwrite === 1) begin   // we are in the sw instruction
                if (aluout === 68 & rd2 === 5) begin 
                    $display("Simulation succeeded");
                    $stop;
                end else begin
                    $display("Simulation failed");
                    $stop;
                end
            end
        end

endmodule
