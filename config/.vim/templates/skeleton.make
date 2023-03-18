appname=myapp

srcfiles=$(shell find . -name "*.cpp")
objects=$(patsubst %.cpp, %.o, $(srcfiles))

CC=g++
CFLAG=-Wall -g

all: $(appname)

$(appname): $(objects)
	$(CC) $(CFLAG) $^ -o $@

%.o: %.cpp
	$(CC) $(CFLAG) -c $<

clean:
	rm -fr *.o $(appname)

run:
	./$(appname)
