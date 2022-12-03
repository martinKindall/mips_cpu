
module DMem(
    input logic clk, we,
    input logic [31:0] a, wd,
    output logic [31:0] rd);

    logic [31:0] RAM[63:0];

    assign rd = RAM[a[31:2]];  // 2 LSB are 0 as it's word aligned

    always_ff @(posedge clk)
        if (we) RAM[a[31:2]] <= wd;        

endmodule