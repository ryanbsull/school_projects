CC = gcc
CFLAGS = -O1 -lrt -o
CUC = nvcc
CUFLAGS = -arch sm_35 -fmad=false -o
FILES = bfs bfs_cu

all: $(FILES)

bfs: bfs.c
	$(CC) $? $(CFLAGS) $(@)

bfs_cu: bfs.cu
	$(CUC) $? $(CUFLAGS) $(@)

clean:
	rm -rf $(FILES)
