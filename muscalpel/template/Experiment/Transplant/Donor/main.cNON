int computeSum (int *array, int length) {
    int sum;
    sum = 0;
    for (int i = 0; i < length; i++) {
        sum += array[i];
    }
    return sum;
}

int bar (int x) {
    return x * x;
}

int foo (int mean) {
    int result;
    result = bar (mean);
    return result;
}

void main () {
    int *array;
    int length;
    readArray (array);
    readInt (& length);
    int sum;
    sum = computeSum (array, length);
    sum = sum / length;
    int result = 0;
    if (sum > 0) {
        result = foo (sum);
    }
}

