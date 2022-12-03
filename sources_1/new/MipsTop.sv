
module MipsTop(
    input logic clk, reset
);

    logic [31:0] writedata, dataadr;
    logic memwrite;

    logic [31:0] pc, instr, readdata;

    Mips mips(clk, reset, pc, instr, memwrite, dataadr,
        writedata, readdata);

    IMem imem(pc[7:2], instr);
    DMem dmem(clk, memwrite, dataadr, writedata, readdata);

endmodule