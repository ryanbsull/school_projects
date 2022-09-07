#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <math.h>

#define CPNS 3.0    /* Cycles per nanosecond -- Adjust to your computer,
                       for example a 3.2 GhZ GPU, this would be 3.2 */

/* We want to test a variety of test sizes. We will generate these
   using the quadratic formula:  A x^2 + B x + C                     */
#define A    1  /* coefficient of x^2 */
#define B    2  /* coefficient of x */
#define C    1  /* constant term */

#define NUM_TESTS 20   /* Number of different sizes to test */


#define OPTIONS 2
#define IDENT 0.0
#define OP +

typedef double data_t;

/* Create abstract data type for allocated array */
typedef struct {
  long int row_len;
  data_t *data;
} array_rec, *array_ptr;

/* Prototypes of functions in this program */
array_ptr new_array(long int row_len);
int set_row_length(array_ptr v, long int row_len);
long int get_row_length(array_ptr v);
int init_array(array_ptr v, long int row_len);
data_t *get_array_start(array_ptr v);
void transpose_opt(array_ptr dst, array_ptr src);
void transpose(array_ptr dst, array_ptr src);

/* -=-=-=-=- Time measurement by clock_gettime() -=-=-=-=- */
/*
  As described in the clock_gettime manpage (type "man clock_gettime" at the
  shell prompt), a "timespec" is a structure that looks like this:
 
        struct timespec {
          time_t   tv_sec;   // seconds
          long     tv_nsec;  // and nanoseconds
        };
 */

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
/*
     This method does not require adjusting a #define constant

  How to use this method:

      struct timespec time_start, time_stop;
      clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time_start);
      // DO SOMETHING THAT TAKES TIME
      clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time_stop);
      measurement = interval(time_start, time_stop);

 */


/* -=-=-=-=- End of time measurement declarations =-=-=-=- */

/* This routine "wastes" a little time to make sure the machine gets
   out of power-saving mode (800 MHz) and switches to normal speed. */
double wakeup_delay()
{
  double meas = 0; int i, j;
  struct timespec time_start, time_stop;
  double quasi_random = 0;
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time_start);
  j = 100;
  while (meas < 1.0) {
    for (i=1; i<j; i++) {
      /* This iterative calculation uses a chaotic map function, specifically
         the complex quadratic map (as in Julia and Mandelbrot sets), which is
         unpredictable enough to prevent compiler optimisation. */
      quasi_random = quasi_random*quasi_random - 1.923432;
    }
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time_stop);
    meas = interval(time_start, time_stop);
    j *= 2; /* Twice as much delay next time, until we've taken 1 second */
  }
  return quasi_random;
}


/*****************************************************************************/
int main(int argc, char *argv[])
{
  int OPTION;
  struct timespec time_start, time_stop;
  double time_stamp[OPTIONS][NUM_TESTS+1];
  double final_answer;
  long int x, n, i, j, alloc_size;

  printf("Transpose tests\n\n");

  final_answer = wakeup_delay();

  /* declare and initialize the array structure */
  x = NUM_TESTS-1;
  alloc_size = (long)A*x*x + B*x + C;
  array_ptr v0 = new_array(alloc_size);
  init_array(v0, alloc_size);
  array_ptr v1 = new_array(alloc_size);
  init_array(v1, alloc_size);

  OPTION = 0;
  for (x=0; x<NUM_TESTS && (n = A*x*x + B*x + C, n<alloc_size); x++) {
    set_row_length(v0, n);
    set_row_length(v1,n);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time_start);
    transpose(v0, v1);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time_stop);
    time_stamp[OPTION][x] = interval(time_start, time_stop);
  }

  OPTION++;
  for (x=0; x<NUM_TESTS && (n = A*x*x + B*x + C, n<alloc_size); x++) {
    set_row_length(v0, n);
    set_row_length(v1,n);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time_start);
    transpose_opt(v0,v1);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time_stop);
    time_stamp[OPTION][x] = interval(time_start, time_stop);
  }

  printf("row_len, transpose, transpose_opt\n");
  {
    int i, j;
    for (i = 0; i < x; i++) {
      printf("%ld, ", A*i*i + B*i + C);
      for (j = 0; j < OPTIONS; j++) {
        if (j != 0) {
          printf(", ");
        }
        printf("%ld", (long int) ((double)(CPNS) * 1.0e9 * time_stamp[j][i]));
      }
      printf("\n");
    }
  }
  printf("\n");
  printf("Initial delay was calculating: %g \n", final_answer);
  
} /* end main */
/*********************************/

/* Create 2D array of specified size-per-dimension. The row_len parameter
   is both the width (row length or number of columns) and the height
   (column height or number of rows) */
array_ptr new_array(long int row_len)
{
  long int i;

  /* Allocate and declare header structure */
  array_ptr result = (array_ptr) malloc(sizeof(array_rec));
  if (!result) {
    /* Couldn't allocate storage */
    printf("\nCOULDN'T ALLOCATE %ld BYTES STORAGE\n", sizeof(result));
    exit(-1);
  }
  result->row_len = row_len;

  /* Allocate and declare array */
  if (row_len > 0) {
    data_t *data = (data_t *) calloc(row_len*row_len, sizeof(data_t));
    if (!data) {
      /* Couldn't allocate storage */
      free((void *) result);
      printf("\nCOULDN'T ALLOCATE %e BYTES STORAGE (row_len=%ld)\n",
                     (double)row_len * row_len * sizeof(data_t), row_len);
      exit(-1);
    }
    result->data = data;
  }
  else result->data = NULL;

  return result;
}

/* Set row-length of array (must already be allocated with new_array and
   size used when allocating must be big enough) */
int set_row_length(array_ptr v, long int row_len)
{
  v->row_len = row_len;
  return 1;
}

/* Return row length of array (which is also the number of columns) */
long int get_row_length(array_ptr v)
{
  return v->row_len;
}

/* initialize 2D array */
int init_array(array_ptr v, long int row_len)
{
  long int i;

  if (row_len > 0) {
    v->row_len = row_len;
    for (i = 0; i < row_len*row_len; i++) {
      v->data[i] = (data_t)(i);
    }
    return 1;
  }
  else return 0;
}

data_t *get_array_start(array_ptr v)
{
  return v->data;
}

/************************************/
void transpose(array_ptr dst, array_ptr src){
	long int i, j, len = get_row_length(src);
	data_t *v0 = get_array_start(dst);
        data_t *v1 = get_array_start(src);
	
	for(i = 0; i < len; i++){
		for(j = 0; j < len; j++){
			v0[j*len+i] = v1[i*len+j];
		}
	}
}

void transpose_opt(array_ptr dst, array_ptr src){
	long int i, j, ii, jj, blk_sz = 32, len = get_row_length(src);
	long int blks = blk_sz*(len/blk_sz);
	data_t *v0 = get_array_start(dst);
        data_t *v1 = get_array_start(src);
	
	for(i = 0; i < blks; i+=blk_sz){
		for(j = 0; j < blks; j+=blk_sz){
			for(ii = i; ii < i + blk_sz; ii++){
				for(jj = j; jj < j + blk_sz; jj++){
					v0[jj*len+ii] = v1[ii*len+jj];
				}
			}
		}
	}
}
