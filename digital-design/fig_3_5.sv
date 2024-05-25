module Multiplicand(
  input logic clk,load,
  input logic[31:0] a,
  output logic[31:0] y
);
  // TODO: Complete the implementation of this module
endmodule

module Adder(
  input logic [31:0] a, b,
  output logic [32:0] y
);
    assign y = a + b;
endmodule

module Product(
  input logic clk,load,write,shiftright,
  input logic[31:0] b,
  input logic[32:0] aluout,
  output logic[63:0] y,
  output logic[31:0] aluleft,
  output logic test
);
  // TODO: Complete the implementation of this module
endmodule

module Control(
  input logic clk,load,test,
  output logic write,shiftright,valid
);
  // TODO: Complete the implementation of this module
endmodule

module Main(
  input logic clk,load,
  input logic[31:0] a, b,
  output logic[63:0] y,
  output logic valid
);
  logic write,shiftright,test;
  logic[31:0] aluright, aluleft;
  logic[32:0] aluout;
  
  Multiplicand Multiplicand(clk,load,a,aluright);
  Adder Adder(aluleft,aluright,aluout);
  Product Product(clk,load,write,shiftright,b,aluout,y,aluleft,test);
  Control Control(clk,load,test,write,shiftright,valid);
endmodule

module testbench;
  logic clk,load;
  initial clk = 0;
  always #5 clk = ~clk;

  logic[31:0] a, b;
  logic[63:0] Result, Expected;

  Main m(clk, load, a, b, Result, valid);

initial begin
    // $dumpfile("fig_3_5.vcd");   // instruct simulator to dump signals in file fig_3_5.vcd
    // $dumpvars(0,testbench); // dump ALL signals in that file
    // test some products of small numbers
    for (logic[7:0] i = 0; i < 8'hff; i++) begin
            @(posedge clk); // start the multiplication, note that a,b and load are synchronous signals
            a <= i[3:0];    
            b <= i[7:4];
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
    // test some products of large numbers
    for (logic[7:0] i = 0; i < 8'hff; i++) begin
            @(posedge clk); 
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

