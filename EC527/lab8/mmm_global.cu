#include "cuPrintf.cu"
#include "cuPrintf.cuh"
#include <cstdio>
#include <cstdlib>
#include <math.h>
#include <time.h>

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

#define NUM_THREADS_2D 16
#define NUM_BLOCKS_2D 16
#define PRINT_TIME 1
#define ROW_LEN 1024
#define TOL 0.0001

#define IMUL(a, b) __mul24(a, b)

void initArr2D(float *arr, int rowlen, int seed)
{
    int i;
    float randNum;
    srand(seed);

    for (i = 0; i < rowlen * rowlen; i++)
    {
        randNum = (float)rand();
        arr[i] = randNum;
    }
}

void cpyArr(float *src, float *dest, int rowlen)
{
    int i;
    for (i = 0; i < rowlen * rowlen; i++)
    {
        dest[i] = src[i];
    }
}

float interval(struct timespec start, struct timespec end)
{
    struct timespec temp;
    temp.tv_sec = end.tv_sec - start.tv_sec;
    temp.tv_nsec = end.tv_nsec - start.tv_nsec;
    if (temp.tv_nsec < 0)
    {
        temp.tv_sec = temp.tv_sec - 1;
        temp.tv_nsec = temp.tv_nsec + 1000000000;
    }
    return (((float)temp.tv_sec) + ((float)temp.tv_nsec) * 1.0e-9);
}

__global__ void kernel_mmm(int rowlen, float *d_x, float *d_y, float *d_out) {
  int blk_sz = rowlen / gridDim.x;
  int t_sz = blk_sz / blockDim.x;
  int row = t_sz*(blockIdx.y*blockDim.y + threadIdx.y);
  int col = t_sz*(blockIdx.x*blockDim.x + threadIdx.x);
  float val;
  int i,j,k;

  for(i = row; i < row+t_sz; i++){
    for(j = col; j < col+t_sz; j++){
      val = 0;
      if(i < rowlen && j < rowlen) {
        for(k = 0; k < rowlen; k++) {
          val += d_x[i*rowlen + k] * d_y[k*rowlen + j];
        }
        d_out[i*rowlen + j] = val;
      }
    }
  }
}

int main(int argc, char **argv)
{
    int rowlen = ROW_LEN;

    // GPU Timing variables
    cudaEvent_t start, stop;
    float elapsed_gpu;

    // CPU Timing variable
    struct timespec time_start, time_stop;
    float time_stamp;

    // Arrays on GPU global memory
    float *d_x;
    float *d_y;
    float *d_out;

    // Arrays on host memory
    float *x;
    float *y;
    float *out;
    float *check;

    int i, j, k, errCount = 0, zeroCount = 0;

    printf("Size of the matrix = %d X %d\n", rowlen, rowlen);

    // Select GPU
    CUDA_SAFE_CALL(cudaSetDevice(0));

    // Set allocation size
    size_t allocSize = rowlen * rowlen * sizeof(float);

    // Allocate GPU memory
    CUDA_SAFE_CALL(cudaMalloc((void **)&d_x, allocSize));
    CUDA_SAFE_CALL(cudaMalloc((void **)&d_y, allocSize));
    CUDA_SAFE_CALL(cudaMalloc((void **)&d_out, allocSize));

    // Allocate arrays on host memory
    x = (float *)malloc(allocSize);
    y = (float *)malloc(allocSize);
    out = (float *)malloc(allocSize);
    check = (float *)malloc(allocSize);

    // Initialize the host arrays
    printf("\nInitializing the arrays ...");
    // Arrays are initialized with a known seed for reproducability
    initArr2D(x, rowlen, 1065);
    initArr2D(y, rowlen, 1016);

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
    CUDA_SAFE_CALL(cudaMemcpy(d_y, y, allocSize, cudaMemcpyHostToDevice));

    // init CUDA printf
    // cudaPrintfInit();

    // Setup thread structure
    dim3 threads(NUM_THREADS_2D, NUM_THREADS_2D);
    dim3 blocks(NUM_BLOCKS_2D, NUM_BLOCKS_2D);

    // Launch the kernel
    kernel_mmm<<<blocks, threads>>>(rowlen, d_x, d_y, d_out);

    // print from CUDA
    // cudaPrintfDisplay(stdout, true); cudaPrintfEnd();

    // Check for errors during launch
    CUDA_SAFE_CALL(cudaPeekAtLastError());

    // Transfer the results back to the host
    CUDA_SAFE_CALL(cudaMemcpy(out, d_out, allocSize, cudaMemcpyDeviceToHost));

#if PRINT_TIME
    // Stop and destroy the timer
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&elapsed_gpu, start, stop);
    printf("\nGPU time: %f (msec)\n", elapsed_gpu);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
#endif

    // Compute the results on the host
    float r;
    clock_gettime(CLOCK_REALTIME, &time_start);
    for (k = 0; k < rowlen; k++)
    {
        for (i = 0; i < rowlen; i++)
        {
            r = x[i * rowlen + k];
            for (j = 0; j < rowlen; j++)
            {
                check[i * rowlen + j] += r * y[k * rowlen + j];
	    }
        }
    }
    clock_gettime(CLOCK_REALTIME, &time_stop);
    time_stamp = interval(time_start, time_stop);
    printf("\nCPU time: %f (msec)\n", 1000 * time_stamp);
    // Compare the results

    for (i = 0; i < rowlen; i++) {
        for (j = 0; j < rowlen; j++) {

            float result = abs((check[i * rowlen + j] - out[i * rowlen + j]) / (out[i * rowlen + j]));
            if (result > TOL) {
                errCount++;
            }
            if (out[i * rowlen + j] == 0){
                zeroCount++;
            }
        }
    }
    printf("\033[0m");

    if (errCount > 0){
        printf("\n@ERROR: TEST FAILED: %d results did not match\n", errCount);
    }
    if (zeroCount > 0){
        printf("\n@ERROR: TEST FAILED: %d results (from GPU) are zero\n", zeroCount);
    }
    if (!errCount && !zeroCount){
        printf("\nTEST PASSED: All results matched\n");
    }

    // Free-up device and host memory
    CUDA_SAFE_CALL(cudaFree(d_x));
    CUDA_SAFE_CALL(cudaFree(d_y));
    CUDA_SAFE_CALL(cudaFree(d_out));

    free(x);
    free(y);
    free(out);

    return 0;
}
