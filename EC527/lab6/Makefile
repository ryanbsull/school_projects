CC = gcc
CFLAGS = -O1 -fopenmp -lrt -o
FILES = test_omp test_omp_for test_mmm_inter_omp test_SOR test_mmm

all: $(FILES)

test_omp: test_omp.c
	$(CC) $? -lm $(CFLAGS) $@

test_omp_for: test_omp_for.c
	$(CC) $? -lm $(CFLAGS) $@

test_mmm_inter_omp: test_mmm_inter_omp.c
	$(CC) $? $(CFLAGS) $(@)

test_SOR: test_SOR.c
	$(CC) $? $(CFLAGS) $(@)

test_mmm: test_mmm.c
	$(CC) $? $(CFLAGS) $(@)
clean:
	rm -rf $(FILES)
