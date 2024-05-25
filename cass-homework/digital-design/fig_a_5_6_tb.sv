module testbench;
  logic a, b, CarryIn, Result, CarryOut, Expected;
  logic[1:0] Operation;

  one_bit_ALU f(a, b, CarryIn, Operation, Result, CarryOut);

initial begin
    $dumpfile("fig_a_5_6.vcd");   // instruct simulator to dump signals in file fig_a_5_6.vcd
    $dumpvars(0,testbench);       // dump ALL signals in that file
    for (logic[2:0] i = 0; i < 7; i++) begin
        for (logic[2:0] oper = 0; oper < 3; oper++) begin
            #1; // wait 1 time unit
            a = i[0];
            b = i[1];
            CarryIn = i[2];
            Operation = oper;
            #1;
            Expected = ((oper == 0)?(a & b) : (oper == 1)? (a | b) : a + b + CarryIn);
            assert (Result ===  Expected) 
            else   $display("Test failed for oper %h:  a=%h, b=%h, CarryIn=%h, resulted in %h, but should be %h", oper, a, b, CarryIn, Result, Expected);
        end
    end
end
endmodule