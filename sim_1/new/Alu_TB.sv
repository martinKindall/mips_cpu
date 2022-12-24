
module Alu_TB;

    logic clk;
    logic [2:0] alucontrol;
    logic [3:0] srca, srcb, aluout, aluoutTest;
    logic zero, zeroTest;

    logic [15:0] testvectors[1000:0];
    logic [31:0] vectornum, errors;

    Alu #(4) dut(srca, srcb, alucontrol, aluout, zero);

    initial begin
        $readmemb("Alu.tv", testvectors);
        vectornum = 0; errors = 0;
        #2;
    end

    always begin
        clk <= 1; #5;     
        clk <= 0; #5;     
    end

    always @(posedge clk) begin
        #1; {srca, srcb, alucontrol, aluoutTest, zeroTest} = testvectors[vectornum];
    end

    always @(negedge clk)
        begin
            if ({aluout, zero} !== {aluoutTest, zeroTest}) begin
                $display("Error: output = %b (%b expected)", {aluout, zero}, {aluoutTest, zeroTest});
                $display("vectornum %b", vectornum);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 'x) begin 
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end

endmodule