#include "InterfaceHeader.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <check.h>

/*
 * 
 */

START_TEST(test_1) {
    int myArray[5] = { 10, -20, -5, 15, -30 };
    int TransplantResult = GRAFT_INTERFACE(-30, 5, NULL /* myArray*/);
    if(TransplantResult != 36){
            ck_abort();
    }
}
END_TEST

Suite *
money_suite(void) {
    Suite *s = suite_create("GenTransSuite");
    /* Core test case */
    TCase *tc_core = tcase_create("Core");
    tcase_set_timeout(tc_core, 1);
    tcase_add_test(tc_core, test_1);
    suite_add_tcase(s, tc_core);
    return s;
}


int main(int argc, char** argv) {
    int number_failed;
    Suite *s = money_suite();
    SRunner *sr = srunner_create(s);
    srunner_run_all(sr, CK_SILENT);

    printf("\n\n");

    srunner_print(sr, CK_NORMAL);

    number_failed = srunner_ntests_failed(sr);
    srunner_free(sr);
    return (number_failed == 0) ? EXIT_SUCCESS : EXIT_FAILURE;
    //  return (EXIT_SUCCESS);
}




/*
int main () {
   
    FILE *fin = fopen ("/home/alex/NetBeansProjects/HostExample/input.in", "r");
    FILE *fout = fopen ("output.out", "w");
    
    int *arrayC;
    int length;
    fscanf (fin, "%d", & length);
    arrayC = (int *) malloc ((length + 1) * sizeof (int));
    int i;
    for (i = 0; i < length; i++) {
        fscanf (fin, "%d", & arrayC [i]);
    }
    for (i = 0; i < length; i++) {
        fprintf (fout, "%d ", arrayC [i]);
    }
    
    
    
    //result: 45 39 -104 61 7 -44 42 -20 45 -85
    int length = 10;
    int myArray[10] = { 3, 45, 1, 67, 8, 98, 12, -12, -133, 0 };
    
    
    short *TRANSPLANT_RESULT;
    TRANSPLANT_RESULT = GRAFT_INTERFACE (length, myArray, NULL, NULL);
    return (EXIT_SUCCESS);
}
*/
