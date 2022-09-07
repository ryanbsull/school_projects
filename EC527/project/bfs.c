#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#define NODES	2048

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

int bfs(long int *tree, long int *path, long int val, long int len);

int main(){
  struct timespec time_start, time_stop;
  long int *tree, *path;
  float measurement;

  tree = (long int*)malloc(sizeof(long int) * NODES);
  path = (long int*)malloc(sizeof(long int) * NODES);
  //init_tree(tree, NODES);
  int i = 0;
  for(; i < NODES; i++)
    tree[i] = i;
  clock_gettime(CLOCK_REALTIME, &time_start);
  bfs(tree, path, tree[2047], NODES);
  clock_gettime(CLOCK_REALTIME, &time_stop);
  measurement = interval(time_start, time_stop);

  printf("\nSERIAL time: %f (msec)\n", 1000*measurement);

  return 0;
}

int bfs(long int *tree, long int *path, long int val, long int len){
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
