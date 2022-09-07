CC = nvcc
CFLAGS = -arch sm_35 -fmad=false -o
FILES = mmm_global mmm_shared mmm_sh_unroll

all: $(FILES)

mmm_global: mmm_global.cu
	$(CC) $? $(CFLAGS) $@

mmm_shared: mmm_shared.cu
	$(CC) $? $(CFLAGS) $@

mmm_sh_unroll: mmm_sh_unroll.cu
	$(CC) $? $(CFLAGS) $@

clean:
	rm -rf $(FILES)
