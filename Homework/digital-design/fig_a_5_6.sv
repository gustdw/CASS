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
    assign Sum = a ^ b ^ CarryIn;
    assign CarryOut = (a && b) || (a && CarryIn) || (b && CarryIn);
endmodule

module one_bit_ALU(
  input logic a, b, CarryIn,
  input logic[1:0] Operation,
  output logic Result, CarryOut
);
  // TODO: Complete the implementation of this module
    wire sumWire, andWire, orWire;

    one_bit_adder oba (a, b, CarryIn, sumWire, CarryOut);
    assign andWire = a && b;
    assign orWire = a || b;
    mux3(andWire, orWire, oba, Operation, Result);
endmodule
