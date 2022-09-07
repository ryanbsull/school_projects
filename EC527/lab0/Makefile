test_clock_gettime: test_clock_gettime.c
	gcc -O0 test_clock_gettime.c -lm -lrt -o test_clock_gettime

test_timers: test_timers.c
	gcc -O0 test_timers.c -lm -o test_timers

test_psum: test_psum.c
	gcc -O1 test_psum.c -lm -lrt -o test_psum

all: test_clock_gettime test_timers
