/*************************************************************************

  gcc -pthread test_param1.c -o test_param -std=gnu99

 */

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define NUM_THREADS 5

/************************************************************************/
void *PrintHello(void *threadid)
{
  long tid;

  tid = (long) threadid;

  printf("PrintHello() in thread # %ld ! \n", threadid);

  pthread_exit(NULL);
}

/*************************************************************************/
int main(int argc, char *argv[])
{
  pthread_t threads[NUM_THREADS];
  int rc;
  signed char x = -1;

  printf("Hello test_param1.c\n");

  for (long t = 0; t < NUM_THREADS; t++) {
    printf("In main:  creating thread %d\n", x);
    rc = pthread_create(&threads[t], NULL, PrintHello, (void*) x);
    x++;
    if (rc) {
      printf("ERROR; return code from pthread_create() is %d\n", rc);
      exit(-1);
    }
  }

  printf("It's me MAIN -- Good Bye World!\n");

  pthread_exit(NULL);

} /* end main */
