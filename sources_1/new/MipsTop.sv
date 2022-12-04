`timescale 1ns / 1ps

module MipsTop(
    input logic clk, reset,
    output logic [31:0] writedata, dataadr, instr,
    output logic memwrite
);

    logic [31:0] pc, readdata;

    Mips mips(clk, reset, pc, instr, memwrite, dataadr,
        writedata, readdata);

    IMem imem(pc[7:2], instr);
    DMem dmem(clk, memwrite, dataadr, writedata, readdata);

endmodule
