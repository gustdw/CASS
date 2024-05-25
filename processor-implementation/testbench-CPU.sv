module testbench();
    // the clock signal will be 0-1-0-1- ... with a period of 10 time units
    // the CPU asserts the done signal when it finishes (= encounters instruction add x0,x0,x0, encoded in machine code as 0x00000033)
    logic clk, done;

    CPU CPU(clk,done);

    // Initialization
    initial 
        begin
        clk = 0;      // initialize clock signal
        $readmemh("empty.machinecode", CPU.IMemory.ROM); // load instruction memory
        $readmemh("datamemory.binary", CPU.DataMemory.RAM); // initialize data memory
        $dumpfile("cpu.vcd");   // instruct simulator to dump signals in file cpu.vcd
        $dumpvars(0,testbench); // dump ALL signals in that file
        #800 $finish; // to avoid infinite loops: finish after 800 time units
        end

    always #5 clk = !clk;   // drive the clock signal: negate every 5 time units

    // At every clock cycle
    always @(posedge clk) 
        begin
            // You can choose to write debug statements here that help you debug your implementation
            $display("PC =  %h", CPU.outPC); // just some examples of debug statements
            if(CPU.MemWrite) $display("Writing %d to address %h", CPU.DataMemory.wd, CPU.DataMemory.a);
            if (done) $finish; // simulation ends when CPU asserts done signal
        end
endmodule
