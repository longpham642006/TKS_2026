#include <stdio.h>
#include <stdlib.h>

void mul(int a[][8], int b[], int y[]) {
    for (int i = 0; i < 8; i++) {
        y[0] += a[0][i] * b[i];
        y[1] += a[1][i] * b[i];
        y[2] += a[2][i] * b[i];
        y[3] += a[3][i] * b[i];
        y[4] += a[4][i] * b[i];
        y[5] += a[5][i] * b[i];
        y[6] += a[6][i] * b[i];
        y[7] += a[7][i] * b[i];
    }
}

int main() {
    int a[8][8];
    int b[8];
    int y[8] = {0};

    // Cố định seed để vector testcase không bị thay đổi giữa các lần chạy mô phỏng
    srand(42); 

    // Khởi tạo ma trận A và vector b với giá trị ngẫu nhiên trong dải [-15, 15]
    for (int i = 0; i < 8; i++) {
        b[i] = (rand() % 31) - 15; 
        for (int j = 0; j < 8; j++) {
            a[i][j] = (rand() % 31) - 15;
        }
    }

    // Hiển thị ma trận A
    printf("Ma tran A (8x8):\n");
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%4d ", a[i][j]);
        }
        printf("\n");
    }

    // Hiển thị vector b
    printf("\nVector b (8x1):\n");
    for (int i = 0; i < 8; i++) {
        printf("b[%d] = %4d\n", i, b[i]);
    }

    // Tính toán
    mul(a, b, y);

    // Hiển thị kết quả vector y
    printf("\nKet qua vector y (8x1):\n");
    for (int i = 0; i < 8; i++) {
        printf("y[%d] = %6d\n", i, y[i]);
    }

    return 0;
}