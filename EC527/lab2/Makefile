CC = gcc
CFLAGS = -O1 -lrt

all: test_combine test_dot test_branch

test_combine: test_combine1-7.c
	$(CC) $(CFLAGS) $? -o $@

test_dot: test_dot.c
	$(CC) $(CFLAGS) -g $? -o $@

test_branch: test_branch.c
	$(CC) $(CFLAGS) $? -o $@

clean: test_combine test_dot test_branch
	rm -rf $?
