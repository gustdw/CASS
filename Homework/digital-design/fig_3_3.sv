module Multiplicand(
  input logic clk,shiftleft,load,
  input logic[31:0] a,
  output logic[63:0] y
);
  // TODO: Complete the implementation of this module
endmodule

module Adder(
  input logic [63:0] a, b,
  output logic [63:0] y
);
    assign y = a + b;
endmodule

module Multiplier(
  input logic clk,shiftright,load,
  input logic[31:0] b,
  output logic test
);
  // TODO: Complete the implementation of this module
endmodule

module Product(
  input logic clk,load,write,
  input logic[63:0] aluout,
  output logic[63:0] y
);
  // TODO: Complete the implementation of this module
endmodule

module Control(
  input logic clk,load,test,
  output logic write,shiftleft,shiftright,valid
);
  // TODO: Complete the implementation of this module
endmodule

module Main(
  input logic clk,load,
  input logic[31:0] a, b,
  output logic[63:0] y,
  output logic valid
);
  logic shiftleft,write,shiftright,test;
  logic[63:0] aluright, aluleft, aluout;
  
  Multiplicand Multiplicand(clk,shiftleft,load,a,aluright);
  Adder Adder(aluleft,aluright,aluout);
  Product Product(clk,load,write,aluout,aluleft);
  Multiplier Multiplier(clk,shiftright,load,b,test);
  Control Control(clk,load,test,write,shiftleft,shiftright,valid);
  assign y = aluleft;
endmodule
