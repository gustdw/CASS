module mux2(
  input logic i0,i1,
  input logic sel,
  output logic o
);
assign o = sel? i1:i0;
endmodule

module mux3(
  input logic i0,i1,i2,
  input logic[1:0] op,
  output logic o
);
 always_comb
  case (op) 
    2'b00 : o = i0;
    2'b01 : o = i1;
    2'b10 : o = i2;
    2'b11 : o = 0; // should not happen
  endcase
endmodule

module one_bit_adder(
  input logic a,b,CarryIn,
  output logic Sum,CarryOut
);
  // TODO: Complete the implementation of this module
endmodule

module one_bit_ALU(
  input logic a, b, CarryIn, Ainvert, Binvert,
  input logic[1:0] Operation,
  output logic Result, CarryOut
);
  // TODO: Complete the implementation of this module based on Fig A.5.9
endmodule

module eight_bit_ALU(
  input logic[7:0] a, b, 
  input logic[3:0] Operation,
  output logic[7:0] Result,
  output logic isZero
);
  // TODO: Complete the implementation of this module so it passes the tests
endmodule

module eight_bit_ALU_spec(
  input logic[7:0] a, b, 
  input logic[3:0] Operation,
  output logic[7:0] Result,
  output logic isZero
);
    always_comb 
        case (Operation)
            4'b0000: Result = a & b;
            4'b0001: Result = a | b;
            4'b0010: Result = a + b;
            4'b0110: Result = a - b;
            default: Result = 32'b0; // should not happen
        endcase
    assign isZero = ~|Result;   
endmodule

module testbench;
  logic[7:0] a, b, Result, Expected;
  logic isZero, isZeroExpected;
  logic[3:0] Operation;

  eight_bit_ALU f(a, b, Operation, Result, isZero);
  eight_bit_ALU_spec fspec(a, b, Operation, Expected, isZeroExpected);

initial begin
    // $dumpfile("final_8_bit_ALU.vcd");   // instruct simulator to dump signals in file final_8_bit_ALU.vcd
    // $dumpvars(0,testbench);     // dump ALL signals in that file

    for (logic[15:0] i = 0; i < 16'hffff; i++) begin
            #1;
            a = i[7:0];
            b = i[15:8];
            Operation = 4'b0000; // AND
            #1;
            assert ((Result ===  Expected) && (isZero == isZeroExpected)) 
            else   $display("Test failed for oper %h:  a=%h, b=%h, resulted in %h, but should be %h", Operation, a, b, Result, Expected);
            Operation = 4'b0001; // OR
            #1;
            assert ((Result ===  Expected) && (isZero == isZeroExpected)) 
            else   $display("Test failed for oper %h:  a=%h, b=%h, resulted in %h, but should be %h", Operation, a, b, Result, Expected);
            Operation = 4'b0010; // ADD
            #1;
            assert ((Result ===  Expected) && (isZero == isZeroExpected)) 
            else   $display("Test failed for oper %h:  a=%h, b=%h, resulted in %h, but should be %h", Operation, a, b, Result, Expected);
            Operation = 4'b0110; // SUB
            #1;
            assert ((Result ===  Expected) && (isZero == isZeroExpected)) 
            else   $display("Test failed for oper %h:  a=%h, b=%h, resulted in %h, but should be %h", Operation, a, b, Result, Expected);
    end
end
endmodule