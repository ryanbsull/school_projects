CC = nvcc
CFLAGS = -arch sm_35 -fmad=false -o
FILES = cuda_test_lab7 gpu_info cuda_test_sor cuda_test_sor_blk

all: $(FILES)

cuda_test_lab7: cuda_test_lab7.cu
	$(CC) $? $(CFLAGS) $@

gpu_info: gpu_info.cu
	$(CC) $? $(CFLAGS) $@

cuda_test_sor: cuda_test_sor.cu
	$(CC) $? $(CFLAGS) $@

cuda_test_sor_blk: cuda_test_sor_blk.cu
	$(CC) $? $(CFLAGS) $@

clean:
	rm -rf $(FILES)
