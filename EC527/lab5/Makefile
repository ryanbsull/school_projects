CC = gcc
OP = -O1
CFLAGS = -lpthread -lrt -lm -o
FILES = test_pt test_SOR_OMEGA test_SOR multi_SOR

all: $(FILES)

test_pt: test_pt.c
	$(CC) -pthread $? $(CFLAGS) $@

test_SOR_OMEGA: test_SOR_OMEGA.c
	$(CC) $(OP) $? -lm -o $@

test_SOR: test_SOR.c
	$(CC) $(OP) -std=gnu11 $? $(CFLAGS) $@

multi_SOR: multi_SOR.c
	$(CC) -pthread -g $(?) $(CFLAGS)  $(@)

clean:
	rm -rf $(FILES)

