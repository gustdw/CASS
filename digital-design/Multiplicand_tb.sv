module testbench;
  logic clk,shiftleft,load;
  initial clk = 0;
  always #5 clk = ~clk;

  logic[31:0] a,test;
  logic[63:0] Result, test_ext;

  Multiplicand m(clk, shiftleft, load, a, Result);

initial begin
    $dumpfile("Multiplicand.vcd");   // instruct simulator to dump signals in file Multiplicand.vcd
    $dumpvars(0,testbench); // dump ALL signals in that file
    test = 32'hdeadbeef;
    test_ext = {32'h0,test};
    a <= test;
    shiftleft <= 0;
    load <= 1;
    @(posedge clk); // wait until next posedge clk
    load <= 0;
    for (int i =0; i <10; i++) begin // test: no change if shiftleft==0
        @(posedge clk);
        assert (Result === test_ext); 
        else   $display("Test failed, got %h but expected %h", Result, test_ext);
    end;
    shiftleft <= 1;
    for (int i = 0; i < 32; i++) begin // test: correct change if shiftleft==1
        @(posedge clk);
        assert (Result === test_ext << i); 
        else   $display("Test failed, got %h but expected %h", Result, test_ext << i);
    end;
    $finish;
end
endmodule




