`timescale 1ns / 1ps

module regfile_TB;

    logic clk, we3;
    logic [4:0] ra1, ra2, wa3;
    logic [31:0] rd1, rd2, wd3;

    logic [31:0] rd1T, rd2T;
    logic [111:0] testvectors[1000:0];
    logic [31:0] vectornum, errors;

    regfile dut(
        .clk(clk),
        .we3(we3),
        .ra1(ra1),
        .ra2(ra2),
        .wa3(wa3),
        .wd3(wd3),
        .rd1(rd1),
        .rd2(rd2)
    );

    initial begin
        $readmemh("regfile.tv", testvectors);
        vectornum = 0; errors = 0;
        ra1 <= 0; ra2 <= 0; wa3 <= 0; we3 <= 0; wd3 <= 0; #2;
    end

    always begin
        clk <= 1; #5;     
        clk <= 0; #5;     
    end

    always @(posedge clk) begin
        #1; {we3, ra1, ra2, wa3, wd3, rd1T, rd2T} = testvectors[vectornum];
    end

    always @(negedge clk)
        begin
            if ({rd1, rd2} !== {rd1T, rd2T}) begin
                $display("Error: output = %b (%b expected)", {rd1, rd2}, {rd1T, rd2T});
                $display("vectornum %b", vectornum);
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 'x) begin 
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end

endmodule
