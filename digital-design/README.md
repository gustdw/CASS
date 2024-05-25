# Homework assignment: Digital design in SystemVerilog

The objective of this homework is to build up some basic experience with
describing hardware in SystemVerilog. At the same time, the homework will
deepen your understanding of the design of the addition and multiplication
hardware discussed in the textbook (and in class).

## Preparation

Make sure that you have read Sections 3.1 - 3.3, and Sections A.1-A.3, A.5 and
A.7-A.8 of the textbook, and that you have attended (or watched the recording
of) the lecture(s) on synchronous digital logic.

**In particular: exercises 4 and 5 will be really hard to do without the
explanation given in the lectures**

## Exercise 1: Implement Figure A.5.6 from the textbook

Figure A.5.6 from the textbook shows a diagram for a hardware module that
implements a simple 1-bit-ALU. The objective of this exercise is to implement
this module in SystemVerilog.

The file `fig_a_5_6.sv` already contains a template of the solution, and
`fig_a_5_6_tb.sv` contains a testbench. Complete the solution by resolving all
TODO's in the template.

You can run all tests by typing: `make fig_a_5_6` in the terminal. This will
first compile your code. If there are no compilation errors, a simulation will
run all tests, and will also create a file `fig_a_5_6.vcd` containing the
waveforms of the simulation.

Make sure your solution passes all tests.

## Exercise 2: Implement an 8-bit ALU

Figure A.5.7 from the textbook shows a diagram for a hardware module that
implements a simple 32-bit-ALU. The objective of this exercise is to implement a
similar module in SystemVerilog, but we restrict to 8-bit for simplicity.
(Extending to 32-bit is straightforward, but tedious with the subset of
SystemVerilog that we cover.)

The file `8_bit_ALU.sv` already contains a template of the solution. It also
contains a testbench. Complete that solution by resolving all TODO's in the
template. You
should instantiate 8 instances of the 1-bit-ALU you implemented in the previous
exercise.

You can run all tests by typing: `make 8_bit_ALU` in the terminal. This will
first compile your code. If there are no compilation errors, a simulation will
run all tests. The testbench does not create a file with waveforms, because it
would become very big. If you want to look at a waveform for debugging, you can 
first see how to create a waveform file by inspecting the testbench of the
previous exercise, and then adapt the testbench of this exercise accordingly.

Make sure your solution passes all tests.

## Exercise 3: Extend the 8-bit ALU to support subtraction

Finally, we will extend the 8-bit ALU to support subtraction and a zero test.
This will implement all the ALU functionality that we will use in the RISC-V
processor implementation we study later in the course.

Look at the template code in `final_8_bit_ALU.sv`. The code is similar to the
code in `8_bit_ALU.sv` and `fig_a_5_6.sv`, but it should now be
modified/extended to handle subtraction and the zero test.

First make an implementation of a one bit ALU that supports subtraction, based
on the design shown in Fig A.5.9 in the textbook.

Next combine 8 of these one-bit-ALU's to make an 8-bit ALU that complies with
the behavioral specification given in module `eight_bit_ALU_spec`.

The provided testbench tests whether your implementation complies with the
specification. Typing `make final_8_bit_ALU` will run the testbench.

## Exercise 4: Implement multiplication as in Fig 3.3

We now build some stateful, sequential systems. We start with the simple but
inefficient implementation of multiplication shown in Fig. 3.3 of the textbook.

As discussed in class, the figure abstracts away the mechanisms for loading
values in the multiplier. We will assume that a client of the multiplication
hardware uses the following protocol:

- The client provides the two 32-bit numbers to be multiplied on input ports `a`
  and `b`, and asserts the `load` input signal for at least one clock cycle.
  This indicates that the multiplication algorithm should start.
- It will then take quite a few clock cycles before the multiplication is done.
  The multiplication hardware indicates that it is ready by asserting the
  `valid` signal. This indicates to the client that the result is now available
  on the `y` output port.

Study the template in `fig_3_3.sv` and `fig_3_3_tb.sv`, and make sure you
understand the provided code. It is then your job to complete the implementation
by resolving all TODO's.

It is recommended to start by implementing the `Multiplicand` module. You can
test that module in isolation with the testbench in `Multiplicand_tb.sv` by
typing `make Multiplicand`.

Once the `Multiplicand` module works, complete all other modules until the
testbench in `fig_3_3_tb.sv` no longer flags errors. You can run that testbench
by typing `make fig_3_3`.

## Exercise 5: Implement multiplication as in Fig 3.5

Finally, implement the optimized version of the multiplication hardware as shown
in Fig 3.5 of the textbook. You are again provided with template code and a
testbench in `fig_3_5.sv`. Complete the TODO's until all tests succeed. You can
run the tests with `make fig_3_5`.
