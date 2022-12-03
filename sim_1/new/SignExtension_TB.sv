`timescale 1ns / 1ps

module SignExtension_TB;

    logic clk;
    logic [15:0] a;
    logic [31:0] y, yTest;

    logic [47:0] testvectors[1000:0];
    logic [31:0] vectornum, errors;

    SignExtension dut(
        .a(a),
        .y(y));

    initial begin
        $readmemh("SignExtension.tv", testvectors);
        vectornum = 0; errors = 0;
        #2;
    end

    always begin
        clk <= 1; #5;     
        clk <= 0; #5;     
    end

    always @(posedge clk) begin
        #1; {a, yTest} = testvectors[vectornum];
    end

    always @(negedge clk)
        begin
            if (yTest !== y) begin
                $display("Error: output = %b (%b expected)", y, yTest);
                $display("vectornum %b", vectornum);
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 'x) begin 
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end

endmodule
