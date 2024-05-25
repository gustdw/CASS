fig_a_5_6: fig_a_5_6.sv fig_a_5_6_tb.sv
	iverilog -g2005-sv -o sim $^
	./sim 

8_bit_ALU: fig_a_5_6.sv 8_bit_ALU.sv
	iverilog -g2005-sv -o sim $^
	./sim 

fig_3_3: fig_3_3.sv fig_3_3_tb.sv
	iverilog -g2005-sv -o sim $^
	./sim 

Multiplicand: Multiplicand_tb.sv fig_3_3.sv
	iverilog -g2005-sv -o sim $^
	./sim 

fig_3_5: fig_3_5.sv 
	iverilog -g2005-sv -o sim $^
	./sim 

final_8_bit_ALU: final_8_bit_ALU.sv 
	iverilog -g2005-sv -o sim $^
	./sim 

clean:
	rm -f sim *.vcd

