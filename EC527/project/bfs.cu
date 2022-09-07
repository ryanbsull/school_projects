#include "cuPrintf.cu"
#include "cuPrintf.cuh"
#include <cstdio>
#include <cstdlib>
#include <time.h>
#include <math.h>

// Assertion to check for errors
#define CUDA_SAFE_CALL(ans)                           \
    {                                                 \
        gpuAssert((ans), (char *)__FILE__, __LINE__); \
    }
inline void gpuAssert(cudaError_t code, char *file, int line, bool abort = true)
{
    if (code != cudaSuccess)
    {
        fprintf(stderr, "CUDA_SAFE_CALL: %s %s %d\n",
                cudaGetErrorString(code), file, line);
        if (abort)
            exit(code);
    }
}

#define NODES		32768
#define THREADS		8

typedef struct {
  long int *data; 
  long int len;
  long int size;
} queue;

int push(queue *q, long int val){
  if(q->size == q->len-1)
    return 0;
  q->data[q->size++] = val;
  return 1;
}

long int pop(queue *q){
  if(q->size == 0)
    return -1;
  long int val = q->data[0];
  long int i = 0;
  for(; i < q->size; i++)
    q->data[i] = q->data[i+1];
  q->size--;
  return val;
}

double interval(struct timespec start, struct timespec end)
{
  struct timespec temp;
  temp.tv_sec = end.tv_sec - start.tv_sec;
  temp.tv_nsec = end.tv_nsec - start.tv_nsec;
  if (temp.tv_nsec < 0) {
    temp.tv_sec = temp.tv_sec - 1;
    temp.tv_nsec = temp.tv_nsec + 1000000000;
  }
  return (((double)temp.tv_sec) + ((double)temp.tv_nsec)*1.0e-9);
}

int get_child_right(int parent){
  return 2*parent + 1;
}

int get_child_left(int parent){
  return 2*parent + 2;
}

void init_tree(long int *t, long int len){
  long int i = 0;
  for(; i < len; i++)
    t[i] = (long int) random();
}

int bfs_serial(long int *tree, long int val, long int len){
  int visited[NODES];
  long int node = 0;
  visited[node] = 1;
  queue *q = (queue*)malloc(sizeof(queue));
  q->len = len; q->size = 0; q->data = (long int *)malloc(sizeof(long int)*len);
  
  push(q, get_child_left(node));
  push(q, get_child_right(node));

  int ret = 0;

  while(q->size > 0){
    node = pop(q);
    // printf("CHECKING NODE: %d\n", node);
    if(visited[node] == 1)
      continue;
    visited[node] = 1;
    if(tree[node] == val){
      ret = 1;
      goto done;
    }
    int l = get_child_left(node), r = get_child_right(node);
    if(l < len)
      push(q, l);
    if(r < len)
      push(q, r);
  }

done:
  free(q);
  return ret;
}

__global__ void kernel_bfs(long int *tree, long int val, long int len, int *detected){
  int visited[NODES];
  int blk_y = (len / gridDim.y);
  int blk_x = (blk_y / gridDim.x);
  int blk_pos = (blk_y * blockIdx.y) + (blk_x * blockIdx.x);
  int t_blk = (blk_x)/(blockDim.x);
  int n = blk_pos + (threadIdx.x*t_blk + (threadIdx.y * (t_blk/blockDim.y)));
  int q[NODES];
  int q_len = 0, q_head = 0, q_tail = 0, cycles = 0;
 
  // cuPrintf("THREAD STARTING AT NODE : \t%d\tNODES PER THREAD: \t%d\n", n, t_blk);

  if(n < len)
    visited[n] = 1;
  else
    return;  

  if(tree[n] == val){
    *detected = 1;
    return;
  }
  
  int l_child = 2*n + 2;
  int r_child = 2*n + 1;
  
  if(l_child < len && !visited[l_child]){
    q[q_tail] = l_child;
    q_tail = (q_tail + 1) % blk_x;
    q_len++; 
  }

  if(r_child < len && !visited[r_child]){
    q[q_tail] = r_child;
    q_tail = (q_tail + 1) % blk_x;
    q_len++; 
  }
  
  while(q_len > 0){
    cycles++;
    n = q[q_head++];
    q_len--;
    
    // cuPrintf("CHECKING NODE : %d\n", n);
    if(tree[n] == val){
      // cuPrintf("%d DETECTED AT NODE : %d\n", val, n);
      *detected = 1;
       break;
    }

    if(visited[n])
      continue;
    
    visited[n] = 1;
    
    l_child = 2*n + 2;
    r_child = 2*n + 1;

    if(l_child < len && !visited[l_child]){ //&& cycles < t_blk){
      q[q_tail] = l_child;
      q_tail = (q_tail + 1) % blk_x;
      q_len++; 
    } 

    if(r_child < len && !visited[r_child]){// && cycles < t_blk){
      q[q_tail] = r_child;
      q_tail = (q_tail + 1) % blk_x;
      q_len++; 
    }
    
  }
}

int main(){
  cudaEvent_t start, stop;
  float elapsed_gpu;
  struct timespec time_start, time_stop;
  long int *d_tree;
  long int *tree;
  int detected = 0;
  int *det;
  float measurement;
  size_t allocSize = sizeof(long int) * NODES;

  printf("TREE SIZE: \t%d NODES\n", NODES);

  CUDA_SAFE_CALL(cudaSetDevice(0));
  
  tree = (long int*)malloc(allocSize);

  CUDA_SAFE_CALL(cudaMalloc((void **)&d_tree, allocSize));
  CUDA_SAFE_CALL(cudaMalloc((void **)&det, sizeof(int)));
  
  printf("\nInitializing tree ...");
  init_tree(tree, NODES);
  printf("\t... done\n");

/* 
  int i = 0;
  for(; i < NODES; i++)
    tree[i] = i;
*/

  long int val = tree[NODES-1];


  CUDA_SAFE_CALL(cudaMemcpy(d_tree, tree, allocSize, cudaMemcpyHostToDevice));
  CUDA_SAFE_CALL(cudaMemcpy(det, &detected, sizeof(int), cudaMemcpyHostToDevice));

  // init CUDA printf
  // cudaPrintfInit();

  int blk = sqrt(NODES / (THREADS * THREADS));
  printf("BLOCKS: %d X %d\n", blk, blk);
  dim3 threads(THREADS, THREADS);
  dim3 blocks(blk,blk);

  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  cudaEventRecord(start, 0);
 
  kernel_bfs<<<blocks, threads>>>(d_tree, val, NODES, det);

  cudaEventRecord(stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime(&elapsed_gpu, start, stop);

  CUDA_SAFE_CALL(cudaPeekAtLastError());

  // print from CUDA
  // cudaPrintfDisplay(stdout, true); cudaPrintfEnd();

  CUDA_SAFE_CALL(cudaMemcpy(&detected, det, sizeof(int), cudaMemcpyDeviceToHost));

  printf("\nGPU time: %f (msec)\n", elapsed_gpu);
  cudaEventDestroy(start);
  cudaEventDestroy(stop);

  clock_gettime(CLOCK_REALTIME, &time_start);
  bfs_serial(tree, val, NODES);
  clock_gettime(CLOCK_REALTIME, &time_stop);
  measurement = interval(time_start, time_stop);

  printf("\nSERIAL time: %f (msec)\n", 1000*measurement);

  return 0;
}
