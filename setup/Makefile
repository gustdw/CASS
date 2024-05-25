test: 
# test the C compiler
	@cc -o ctest ctest.c
	@./ctest
# test iverilog
	@iverilog -g2005-sv -o sim vtest.sv
	@./sim 

clean:
	rm -f ctest sim
	
