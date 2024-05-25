module testbench;
  logic clk,load;
  initial clk = 0;
  always #5 clk = ~clk;

  logic[31:0] a, b;
  logic[63:0] Result, Expected;

  Main m(clk, load, a, b, Result, valid);

initial begin
//  Creation of vcd files is commented out, because they can be very large
//     $dumpfile("fig_3_3.vcd");   // instruct simulator to dump signals in file fig_3_3.vcd
//     $dumpvars(0,testbench);     // dump ALL signals in that file

    // test some products of small numbers
    for (logic[7:0] i = 0; i < 8'hff; i++) begin
            // client provides a and b, and asserts load for 1 clock cycle
            a <= i[3:0];
            b <= i[7:4];
            load <= 1;
            @(posedge clk);
            load <= 0;
            // client waits for the multiplication to be ready
            fork // this waits for @posedge valid with a timeout of #1000
                #1000;
                @(posedge valid);
            join_any
            @(posedge clk);
            // client checks the result
            Expected = a * b;
            assert (Result ===  Expected) 
            else   $display("failed:  a=%h, b=%h, resulted in %h, but should be %h", a, b, Result, Expected);
    end
    // test some products of large numbers
    for (logic[7:0] i = 0; i < 8'hff; i++) begin
            a <= {i[3:0],27'h0};
            b <= {i[7:4],27'h0};
            load <= 1;
            @(posedge clk);
            load <= 0;
            fork // this waits for @posedge valid with a timeout of #1000
                #1000;
                @(posedge valid);
            join_any
            @(posedge clk);
            Expected = a * b;
            assert (Result ===  Expected) 
            else   $display("failed:  a=%h, b=%h, resulted in %h, but should be %h", a, b, Result, Expected);
    end
    $finish;
end
endmodule

