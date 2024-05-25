CFLAGS= -g -Wall -O0
LDFLAGS=

EX1= ex1
EX2= ex2
EX3= ex3
EX4= ex4
EX5= ex5

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $^

$(EX1): $(EX1).o simple_bitmaps.o
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(EX2): $(EX2).o simple_bitmaps.o
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(EX3): $(EX3).o 
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(EX4): $(EX4).o 
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(EX5): $(EX5).o 
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

clean:
	rm -f *.o $(EX1) $(EX2) $(EX3) $(EX4) $(EX5)

