CC = gcc
CFLAGS = -pthread -std=gnu99 -o

all: test_generic test_create test_join test_param test_param2 test_param3 test_sync test_barrier test_sync2 test_crit test_sor

test_generic: test_generic.c
	$(CC) $? -std=gnu99 -o $@

test_create: test_create.c
	$(CC) $(?) $(CFLAGS) $@

test_join: test_join.c
	$(CC) $(?) $(CFLAGS) $@

test_param: test_param1.c
	$(CC) $(?) $(CFLAGS) $@

test_param2: test_param2.c
	$(CC) $(?) $(CFLAGS) $@

test_param3: test_param3.c
	$(CC) $(?) $(CFLAGS) $@

test_sync: test_sync1.c
	$(CC) $(?) $(CFLAGS) $@

test_barrier: test_barrier.c
	$(CC) $(?) $(CFLAGS) $@

test_sync2: test_sync2.c
	$(CC) $(?) $(CFLAGS) $@

test_crit: test_crit.c
	$(CC) $(?) $(CFLAGS) $@

test_sor: test_sor.c
	$(CC) $(?) $(CFLAGS) $@

clean: test_generic test_create test_join test_param test_param2 test_param3 test_sync test_barrier test_sync2 test_crit test_sor
	rm -rf $?
