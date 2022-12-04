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
            if (instr[5:0] === 8'h20) begin   // we are in the add instruction
                if (aluout === 5 & rd2 === 3 & memwrite === 0) begin 
                    $display("Simulation succeeded");
                    $stop;
                end else begin
                    $display("Simulation failed");
                    $stop;
                end
            end
        end

endmodule
