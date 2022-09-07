/*************************************************************************

  gcc -pthread test_param2.c -o test_param2 -std=gnu99

 */

#include <stdio.h>
#include <stdlib.h>

#include <pthread.h>

#define NUM_THREADS 10
#define ARR_SIZE    10
int x = 0;
/********************/
void *work(void *i)
{
  //int x = (int)(pthread_self() % ARR_SIZE);
  long int k;
  int *arr = (int*)(i);  // get head of array
  
  /* busy work */
  k = 0;
  for (long j=0; j < 1000000; j++) {
    k += j;
  }
  arr[x++] = (int)(pthread_self());
  printf("Assigning array element %d to value %d\n", (x-1), (int)(pthread_self())); 
  /* printf("Hello World from %lu with value %d\n", pthread_self(), f); */
  pthread_exit(NULL);
}

/*************************************************************************/
int main(int argc, char *argv[])
{
  long k, t;
  int arr[ARR_SIZE];
  pthread_t id[NUM_THREADS];
  
  for(t = 0; t < ARR_SIZE; t++)
    arr[t] = 0;
  
  for (t = 0; t < NUM_THREADS; ++t) {
    if (pthread_create(&id[t], NULL, work, (void *)(arr))) {
      printf("ERROR creating the thread\n");
      exit(19);
    }
  }

  /* busy work */
  k = 0;
  for (long j=0; j < 100000000; j++) {
    k += j;
  }

  printf("k=%ld\n", k);
  printf("After creating the threads.  My id is %lx, t = %d\n",
                                                 (long)pthread_self(), t);
  printf("Following thread execution the array elements are:\n[");
  for(t = 0; t < ARR_SIZE-1; t++)
    printf("%d,", arr[t]);
  printf("%d]\n", arr[t]);
  return(0);

} /* end main */
