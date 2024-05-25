module eight_bit_ALU(
  input logic[7:0] a, b, 
  input logic CarryIn,
  input logic[1:0] Operation,
  output logic[7:0] Result,
  output logic CarryOut
);
  // TODO: Complete the implementation of this module
endmodule

module testbench;
  logic[7:0] a, b, Result, Expected;
  logic CarryIn, CarryOut;
  logic[1:0] Operation;

  eight_bit_ALU f(a, b, CarryIn, Operation, Result, CarryOut);

initial begin
    for (logic[16:0] i = 0; i < 17'h1ffff; i++) begin
        for (logic[2:0] oper = 0; oper < 3; oper++) begin
            #1;
            a = i[7:0];
            b = i[15:8];
            CarryIn = i[16];
            Operation = oper;
            #1;
            Expected = ((oper == 0)?(a & b) : (oper == 1)? (a | b) : a + b + CarryIn);
            assert (Result ===  Expected) 
            else   $display("Test failed for oper %h:  a=%h, b=%h, CarryIn=%h, resulted in %h, but should be %h", oper, a, b, CarryIn, Result, Expected);
        end
    end
end
endmodule