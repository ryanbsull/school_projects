all: test_combine2d test_mmm_inter test_mmm_block test_transpose

test_combine2d: test_combine2d.c
	gcc -O1 $? -lrt -o $@

test_mmm_inter: test_mmm_inter.c
	gcc -O1 $? -lrt -o $@

test_mmm_block: test_mmm_block.c
	gcc -O1 $? -lrt -o $@

test_transpose: test_transpose.c
	gcc -O1 $? -lrt -g -o $@
 
clean: test_combine2d test_mmm_inter test_mmm_block test_transpose
	rm -rf $? mb mcs-temp
