DEBUGFLAGS = -g -W -Wall
CC = gcc

all: img2beeb

img2beeb: img2beeb.o
	$(CC) $(DEBUGFLAGS) -o img2beeb img2beeb.o -lm -lIL -lILU

clean:
	rm -f *.o
	rm -f img2beeb
