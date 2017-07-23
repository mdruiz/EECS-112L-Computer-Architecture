/* Example 4.12  C layer*/

#include <stdio.h>
#include <stdlib.h>
#include "svdpi.h"
#include "vpi_user.h"


int  test(
		int sel, 
		svOpenArrayHandle data_in,
		svOpenArrayHandle data_out,
		int * output
		){

    int *data_in_p = (int *)svGetArrayPtr(data_in);	
	printf("C:: The value of element %d was %d\n", sel, data_in_p[sel]);
	data_in_p[sel]++;

         *(int *)svGetArrElemPtr1(data_out, sel) = data_in_p[sel];	
	*output = data_in_p[sel]*2;
  return 0;

}

