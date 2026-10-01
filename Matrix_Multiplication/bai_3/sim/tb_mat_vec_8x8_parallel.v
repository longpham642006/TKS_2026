`timescale 1ns/1ps

module tb_mat_vec_8x8_parallel;
    parameter C = 8;
    parameter R = 8;
    parameter DATA_WIDTH = 16;
    parameter ACC_WIDTH = 40;

    reg clk;

    reg signed [DATA_WIDTH-1:0] a_val [0:R-1][0:C-1];
    reg signed [DATA_WIDTH-1:0] x_val [0:C-1];
    reg signed [ACC_WIDTH-1:0] expected_y [0:R-1];
    reg signed [ACC_WIDTH-1:0] actual_y;

    wire signed [ACC_WIDTH-1:0] y_out [0:R-1];

    integer test_count;
    integer pass_count;
    integer fail_count;

    mat_vec_8x8_parallel #(
        .DATA_WIDTH(DATA_WIDTH),
        .ACC_WIDTH(ACC_WIDTH)
    ) dut (
        .A00(a_val[0][0]), .A01(a_val[0][1]), .A02(a_val[0][2]), .A03(a_val[0][3]),
        .A04(a_val[0][4]), .A05(a_val[0][5]), .A06(a_val[0][6]), .A07(a_val[0][7]),

        .A10(a_val[1][0]), .A11(a_val[1][1]), .A12(a_val[1][2]), .A13(a_val[1][3]),
        .A14(a_val[1][4]), .A15(a_val[1][5]), .A16(a_val[1][6]), .A17(a_val[1][7]),

        .A20(a_val[2][0]), .A21(a_val[2][1]), .A22(a_val[2][2]), .A23(a_val[2][3]),
        .A24(a_val[2][4]), .A25(a_val[2][5]), .A26(a_val[2][6]), .A27(a_val[2][7]),

        .A30(a_val[3][0]), .A31(a_val[3][1]), .A32(a_val[3][2]), .A33(a_val[3][3]),
        .A34(a_val[3][4]), .A35(a_val[3][5]), .A36(a_val[3][6]), .A37(a_val[3][7]),

        .A40(a_val[4][0]), .A41(a_val[4][1]), .A42(a_val[4][2]), .A43(a_val[4][3]),
        .A44(a_val[4][4]), .A45(a_val[4][5]), .A46(a_val[4][6]), .A47(a_val[4][7]),

        .A50(a_val[5][0]), .A51(a_val[5][1]), .A52(a_val[5][2]), .A53(a_val[5][3]),
        .A54(a_val[5][4]), .A55(a_val[5][5]), .A56(a_val[5][6]), .A57(a_val[5][7]),

        .A60(a_val[6][0]), .A61(a_val[6][1]), .A62(a_val[6][2]), .A63(a_val[6][3]),
        .A64(a_val[6][4]), .A65(a_val[6][5]), .A66(a_val[6][6]), .A67(a_val[6][7]),

        .A70(a_val[7][0]), .A71(a_val[7][1]), .A72(a_val[7][2]), .A73(a_val[7][3]),
        .A74(a_val[7][4]), .A75(a_val[7][5]), .A76(a_val[7][6]), .A77(a_val[7][7]),

        .X0(x_val[0]), .X1(x_val[1]), .X2(x_val[2]), .X3(x_val[3]),
        .X4(x_val[4]), .X5(x_val[5]), .X6(x_val[6]), .X7(x_val[7]),

        .Y0(y_out[0]), .Y1(y_out[1]), .Y2(y_out[2]), .Y3(y_out[3]),
        .Y4(y_out[4]), .Y5(y_out[5]), .Y6(y_out[6]), .Y7(y_out[7])
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    task generate_data;
        integer i, j;
        begin
            for (j = 0; j < C; j = j + 1) begin
                x_val[j] = $random;
            end

            for (i = 0; i < R; i = i + 1) begin
                for (j = 0; j < C; j = j + 1) begin
                    a_val[i][j] = $random;
                end

                expected_y[i] = (a_val[i][0] * x_val[0]) +
                                (a_val[i][1] * x_val[1]) +
                                (a_val[i][2] * x_val[2]) +
                                (a_val[i][3] * x_val[3]) +
                                (a_val[i][4] * x_val[4]) +
                                (a_val[i][5] * x_val[5]) +
                                (a_val[i][6] * x_val[6]) +
                                (a_val[i][7] * x_val[7]);
            end
        end
    endtask

    integer k;
    reg test_pass;

    initial begin
        test_count = 0;
        pass_count = 0;
        fail_count = 0;

        for (test_count = 0; test_count < 1000; test_count = test_count + 1) begin
            generate_data;

            @(negedge clk);
            #1;

            test_pass = 1;
            for (k = 0; k < R; k = k + 1) begin
                actual_y = y_out[k];
                if (actual_y !== expected_y[k]) begin
                    $display("TEST %0d FAIL | Row %0d: Expected=%0d Actual=%0d", test_count + 1, k, expected_y[k], actual_y);
                    test_pass = 0;
                end
            end

            if (test_pass == 1) begin
                pass_count = pass_count + 1;
                if (test_count % 100 == 0)
                    $display("TEST %0d PASS", test_count + 1);
            end else begin
                fail_count = fail_count + 1;
            end
        end

        $display("========================================");
        $display("PASS : %0d   || FAIL : %0d", pass_count, fail_count);
        $display("========================================");
        $finish;
    end

endmodule
