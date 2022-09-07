#include <stdio.h>
// SOLUTION FILE

main()
{
  int var_int;                    // 2
  double var_double;
  char var_char;
  long var_long;
  short var_short;

  unsigned char uchar1, uchar2;   // 3
  signed char schar1, schar2;

  int x, y;                       // 4

  char i;                         // 5
  char shift_char;

  int a[10] = {0,10,20,30,40,50,60,70,80,90};    // 6

  int b[10], c[10];               // 7
  int *ip, *ip2;
  int j, k;

  char AString[] = "HAL";           // 8

  // 1 -- change "World" to your name
  printf("\n\n PART 1 ---------\n");

  printf("\n Hello Ryan Sullivan! \n");

  // 2 -- find sizes of the other C datatypes
  printf("\n\n PART 2 ----------\n");

  printf("\n size of data type int = %d ", sizeof(var_int));
  printf("\n size of data type double = %d ", sizeof(var_double));
  printf("\n size of data type char = %d ", sizeof(var_char));
  printf("\n size of data type long = %d ", sizeof(var_long));
  printf("\n size of data type short = %d ", sizeof(var_short));


  // 3 -- explore signed versus unsigned datatypes and their interactions
  printf("\n\n PART 3 ----------\n");

  uchar1 = 0xFF;
  uchar2 = 0xFE;
  schar1 = 0xFF;
  schar2 = 0xFE;

  printf("\n uchar1 = %d ", uchar1);
  printf("\n schar1 = %d ", schar1);
  printf("\n uchar2 = %d ", uchar2);
  printf("\n schar2 = %d ", schar2);
  if(uchar1 > schar1){
	printf("\nuchar1 > schar1");
  }
  else{
	printf("\nschar1 > uchar1");
  }
  if(uchar2 > schar2){
	printf("\nuchar2 > shcar2");
  }
  else{
	printf("\nschar2 > uchar2");
  }
  printf("\nAre schar1 and uchar1 equal? (1 = yes / 0 = no): %d", schar1==uchar1);
  printf("\nAre schar2 and uchar2 equal? (1 = yes / 0 = no): %d", schar2==uchar2);
  printf("\nschar1 + schar2 = %d ", schar1+schar2);
  printf("\nuchar1 + uchar2 = %d ", uchar1+uchar2);
  printf("\nshcar1 + uchar1 = %d ", schar1+uchar1);	

  // 4 -- Booleans
  printf("\n\n PART 4 ----------\n");

  x = 1; y = 2;
  printf("\nSize of internal Boolean type : %d", sizeof(x==y));
  printf("\nx & y = %d", x&y);
  printf("\nx && y = %d", x&&y);
  printf("\n~x = %d \n~y = %d", ~x,~y);
  printf("\n!x = %d \n!y = %d", !x,!y);


  // 5 -- shifts
  printf("\n\n PART 5 ----------\n");

  shift_char = 15;
  i = 1;
  j = 2;

  printf("\n shift_char << %d = %d", i, shift_char << i);
  printf("\n shift_char >> %d = %d", j, shift_char >> j);
  printf("\n shift_char << %d = %d", j, shift_char << j);
  printf("\n shift_char >> %d = %d", i, shift_char >> i);
  printf("\n shift_char << %d = %d", 5, shift_char << 5);
  printf("\n shift_char << %d = %d", 8, shift_char << 8);
  

  // 6 -- pointer basics
  printf("\n\n PART 6 ----------\n");

  ip = a;
//  printf("\nstart %d %d %d %d %d %d %d \n",
//	 a[0], *(ip), *(ip+1), *ip++, *ip, *(ip+3), *(ip-1));
  printf("\nstart ");
  printf("%d ", a[1]);
  printf("%d ", *(ip+1));
  printf("%d ", *(ip+2));
  printf("%d ", *++ip);
  printf("%d ", *++ip);
  printf("%d ", *(ip+3));
  printf("%d ", *(ip-1));

  printf("\nSize of integer pointer: %d", sizeof(ip));
  printf("\nip = %x", ip);
  printf("\nip + 1 = %x", ip+1);


  // 7 -- programming with pointers
  printf("\n\n PART 7 ----------\n\n");
  printf("a = {");
  for(j = 0; j < 9; j++)
  {
	printf("%d,", a[j]);
  }
  printf("%d}", a[9]);

  for(k = 0; k < 10; k++)
  {
	b[k] = a[9-k];
  }
  printf("\nb = {");
  for(j = 0; j < 9; j++)
  {
	printf("%d, ", b[j]);
  }
  printf("%d}", b[9]);

  ip = a+9;
  ip2 = c;

  for(k = 0; k < 10; k++)
  {
	*(ip2+k) = *(ip-k);
  }
  printf("\nc = {");
  for(j = 0; j < 9; j++)
  {
	printf("%d, ", *(ip2+j));
  }
  printf("%d}", *(ip2+9));
  // 8 -- strings
  printf("\n\n PART 8 ----------\n");

  printf("\n %s \n", AString);
  for(j = 0; j < 3; j++)
  {
	printf("\n%c = %d", AString[j], AString[j]);
  }
  for(j = 0; j < 3; j++)
  {
        printf("\n%c + 1 = %c", AString[j], AString[j]+1);
  }
  AString[3] = AString[3] + 60;
  printf("\n\n %s", AString);


  // 9 -- address calculation
  printf("\n\n PART 9 ----------\n");
  printf("\nFIRST LOOP:\n");
  for (k = 0; k < 10; k++)
  {
	printf("\nAddress referenced: %x", &b[k]);
	 b[k] = a[k];         // direct reference to array element
  }
  ip = a;
  ip2 = b;
  printf("\n\nSECOND LOOP:\n");
  for (k = 0; k < 10; k++)
  {
	printf("\nAddress referenced: %x", ip2);
	 *ip2++ = *ip++;     // indirect reference to array element
  }
  // all done
  printf("\n\n ALL DONE\n");
}
