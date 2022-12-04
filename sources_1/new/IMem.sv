`timescale 1ns / 1ps

module IMem(
    input logic [5:0] a,
    output logic [31:0] rd
);

    logic [31:0] ROM[63:0];  // 64 words

    initial
        $readmemh("twoPlusTwo.dat", ROM);
        //$readmemh("memfile.dat", ROM);

    assign rd = ROM[a];

endmodule