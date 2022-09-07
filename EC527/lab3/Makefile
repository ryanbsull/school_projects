CC = gcc
CFLAGS = -O1 -std=gnu99 -mavx -o
CFLAGS0 = -O0 -std=gnu99 -lrt -o
CFLAGS1 = -O1 -std=gnu99 -mavx -lrt -lm -o

all: avx_align test_align test_combine8 test_dot test_transpose test_intrinsics

avx_align: avx_align.c
	$(CC) $? $(CFLAGS) $@

test_align: test_align.c
	$(CC) $? $(CFLAGS0) $@

test_combine8: test_combine8.c
	$(CC) $? $(CFLAGS1) $@

test_dot: test_dot8.c
	$(CC) $? $(CFLAGS1) $@

test_transpose: test_transpose.c
	$(CC) $? $(CFLAGS1) $@

test_intrinsics: test_intrinsics.c
	$(CC) $? $(CFLAGS1) $@

clean: avx_align test_align test_combine8 test_dot test_transpose test_intrinsics
	rm -rf $?
