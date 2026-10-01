#include <stdio.h>
#include <stdint.h>

int main()
{

    int16_t a[8] = {
        1, 2, 3, 4,
        5, 6, 7, 8
    };

    int16_t x[8] = {
        1, 2, 3, 4,
        5, 6, 7, 8
    };


    int64_t prod_0 = (int64_t)a[0] * x[0];
    int64_t prod_1 = (int64_t)a[1] * x[1];
    int64_t prod_2 = (int64_t)a[2] * x[2];
    int64_t prod_3 = (int64_t)a[3] * x[3];
    int64_t prod_4 = (int64_t)a[4] * x[4];
    int64_t prod_5 = (int64_t)a[5] * x[5];
    int64_t prod_6 = (int64_t)a[6] * x[6];
    int64_t prod_7 = (int64_t)a[7] * x[7];
    int64_t sum_1 = prod_0 + prod_1;
    int64_t sum_2 = prod_2 + prod_3;
    int64_t sum_3 = prod_4 + prod_5;
    int64_t sum_4 = prod_6 + prod_7;
    int64_t sum_5 = sum_1 + sum_2;
    int64_t sum_6 = sum_3 + sum_4;
    int64_t sum = sum_5 + sum_6;

}