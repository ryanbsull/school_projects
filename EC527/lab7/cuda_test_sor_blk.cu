#include "cuPrintf.cu"
#include "cuPrintf.cuh"
#include <cstdio>
#include <cstdlib>
#include <math.h>
#include <time.h>

// Assertion to check for errors
#define CUDA_SAFE_CALL(ans) { gpuAssert((ans), (char *)__FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, char *file, int line, bool abort=true)
{
  if (code != cudaSuccess)
  {
    fprintf(stderr, "CUDA_SAFE_CALL: %s %s %d\n",
                                       cudaGetErrorString(code), file, line);
    if (abort) exit(code);
  }
}

#define NUM_THREADS_2D	16
#define NUM_BLOCKS_2D	16
#define PRINT_TIME	1
#define ROW_LEN		2048
#define	TOL		0.05
#define OMEGA		1.68
#define ITERATIONS	2000

#define IMUL(a, b) __mul24(a, b)

void initArr2D(float *arr, int rowlen, int seed){
  int i;
  float randNum;
  srand(seed);

  for (i = 0; i < rowlen*rowlen; i++) {
    randNum = (float) rand();
    arr[i] = randNum;
  }
}

void cpyArr(float *src, float *dest, int rowlen){
  int i;
  for (i = 0; i < rowlen*rowlen; i++) {
    dest[i] = src[i];
  }
}

float interval(struct timespec start, struct timespec end)
{
  struct timespec temp;
  temp.tv_sec = end.tv_sec - start.tv_sec;
  temp.tv_nsec = end.tv_nsec - start.tv_nsec;
  if (temp.tv_nsec < 0) {
    temp.tv_sec = temp.tv_sec - 1;
    temp.tv_nsec = temp.tv_nsec + 1000000000;
  }
  return (((float)temp.tv_sec) + ((float)temp.tv_nsec)*1.0e-9);
}

__global__ void kernel_sor(int rowlen, float* d_x){
  const int blk_sz 	= (int) (rowlen / gridDim.x);
  const int blk_idx 	= blk_sz * blockIdx.x;
  const int blk_off 	= blk_sz * blockIdx.y;
  const int t_sz 	= (int) (blk_sz / blockDim.x);
  const int tidx	= blk_idx + t_sz * threadIdx.x;
  const int toff	= blk_off + t_sz * threadIdx.y;

  int i, j;
  double change;

  for(i = tidx; i < tidx+t_sz; i++) { 
    for(j = toff; j < toff+t_sz; j++) {
      if(i > 0 && j > 0 && i < rowlen-1 && j < rowlen-1) {
        change = d_x[i*rowlen+j] - .25 * (d_x[(i-1)*rowlen+j] +
                                          d_x[(i+1)*rowlen+j] +
                                          d_x[i*rowlen+j+1] +
                                          d_x[i*rowlen+j-1]);
        d_x[i*rowlen+j] -= change * OMEGA;
      }
    }
  }
}

int main(int argc, char **argv){
  int rowlen = ROW_LEN;

  // GPU Timing variables
  cudaEvent_t start, stop;
  float elapsed_gpu;

  // CPU Timing variable
  struct timespec time_start, time_stop;
  float time_stamp;

  // Arrays on GPU global memoryc
  float *d_x;
  
  // Arrays on host memory
  float *x;
  float *x_cpy;

  int i, j, it, errCount = 0, zeroCount = 0;

  printf("Length of the array = %d\n", rowlen*rowlen);

  // Select GPU
  CUDA_SAFE_CALL(cudaSetDevice(0));

  // Allocate GPU memory
  size_t allocSize = rowlen * rowlen * sizeof(float);
  CUDA_SAFE_CALL(cudaMalloc((void **)&d_x, allocSize));

  // Allocate arrays on host memory
  x                        = (float *) malloc(allocSize);
  x_cpy                    = (float *) malloc(allocSize);

  // Initialize the host arrays
  printf("\nInitializing the arrays ...");
  // Arrays are initialized with a known seed for reproducability
  initArr2D(x, rowlen, 2453);
  initArr2D(x_cpy, rowlen, 2453);
  //cpyArr(x, x_cpy, rowlen);
  for(i = 0; i < rowlen*rowlen; i++) {
    if (abs(x_cpy[i] - x[i]) > TOL) {
      printf("@ERROR: INACCURATE COPY\n");
      return -1; 
    }
  }
  printf("\t... done\n");

#if PRINT_TIME
  // Create the cuda events
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  // Record event on the default stream
  cudaEventRecord(start, 0);
#endif

  // Transfer the arrays to the GPU memory
  CUDA_SAFE_CALL(cudaMemcpy(d_x, x, allocSize, cudaMemcpyHostToDevice));
  
  // init CUDA printf
  // cudaPrintfInit();
  
  // Setup thread structure
  dim3 threads(NUM_THREADS_2D, NUM_THREADS_2D);
  dim3 blocks(NUM_BLOCKS_2D, NUM_BLOCKS_2D);

  // Launch the kernel
  for(it = 0; it < ITERATIONS; it++)
    kernel_sor<<<blocks, threads>>>(rowlen, d_x);

  // print from CUDA
  // cudaPrintfDisplay(stdout, true); cudaPrintfEnd();

  // Check for errors during launch
  CUDA_SAFE_CALL(cudaPeekAtLastError());

  // Transfer the results back to the host
  CUDA_SAFE_CALL(cudaMemcpy(x, d_x, allocSize, cudaMemcpyDeviceToHost));

#if PRINT_TIME
  // Stop and destroy the timer
  cudaEventRecord(stop,0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime(&elapsed_gpu, start, stop);
  printf("\nGPU time: %f (msec)\n", elapsed_gpu);
  cudaEventDestroy(start);
  cudaEventDestroy(stop);
#endif
  
  float change;
  // Compute the results on the host
  clock_gettime(CLOCK_REALTIME, &time_start);
  for(it = 0; it < ITERATIONS; it++){
    for(i = 1; i < rowlen-1; i++){
      for(j = 1; j < rowlen-1; j++){
        change = x_cpy[i*rowlen+j] - .25 * (x_cpy[(i-1)*rowlen+j] +
                                            x_cpy[(i+1)*rowlen+j] +
                                            x_cpy[i*rowlen+j+1] +
                                            x_cpy[i*rowlen+j-1]);
        x_cpy[i*rowlen+j] -= change * OMEGA;
      }
    }
  }
  clock_gettime(CLOCK_REALTIME, &time_stop);
  time_stamp = interval(time_start, time_stop);
  printf("\nCPU time: %f (msec)\n", 1000*time_stamp);
  // Compare the results
/*
  for(i = 0; i < rowlen*rowlen; i++) {
    printf("%d:\t%.8f\t%.8f\t%d\n", i, x[i], x_cpy[i], !(x[i] == x_cpy[i]));
  }
*/
  for(i = 0; i < rowlen; i++) {
    for(j = 0; j < rowlen; j++) {
      if (abs(x_cpy[i*rowlen + j] - x[i*rowlen + j])/(x_cpy[i*rowlen + j]) > TOL) {
        errCount++;
      }
      if (x[i*rowlen + j] == 0) {
        zeroCount++;
      }
    }
  }
  printf("\033[0m");

  if (errCount > 0) {
    printf("\n@ERROR: TEST FAILED: %d results did not match\n", errCount);
  }
  if (zeroCount > 0){
    printf("\n@ERROR: TEST FAILED: %d results (from GPU) are zero\n", zeroCount);
  }
  if(!errCount && !zeroCount) {
    printf("\nTEST PASSED: All results matched\n");
  }

  // Free-up device and host memory
  CUDA_SAFE_CALL(cudaFree(d_x));

  free(x);
  free(x_cpy);

  return 0;
}
