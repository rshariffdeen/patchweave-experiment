
#include "InterfaceHeader.h"

int bar (int x) {
    return x * x;
}

int GRAFT_INTERFACE (int sum, int l, int *array) {
    goto LABEL_computeSum1;
LABEL_computeSum1 :
    if (0) {
    }
    sum = sum / l;
    l = 0;
    int $_bar_x1_1 = sum;
    return bar ($_bar_x1_1);
}

