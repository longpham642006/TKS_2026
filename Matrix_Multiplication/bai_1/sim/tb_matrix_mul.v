`timescale 1ns/1ps

module tb_matrix_mul;
    parameter C = 8;
    parameter R = 8;
    parameter DATA_WIDTH = 16;
    parameter ACC_WIDTH = 40;

    reg clk;
    reg rst_n;
    reg start;
    wire done;

    wire [ACC_WIDTH-1:0] y0, y1, y2, y3, y4, y5, y6, y7;
    wire [ACC_WIDTH-1:0] actual_y [R-1:0];

    assign actual_y[0] = y0;
    assign actual_y[1] = y1;
    assign actual_y[2] = y2;
    assign actual_y[3] = y3;
    assign actual_y[4] = y4;
    assign actual_y[5] = y5;
    assign actual_y[6] = y6;
    assign actual_y[7] = y7;

    reg signed [DATA_WIDTH-1:0] x_val [C-1:0];
    reg signed [ACC_WIDTH-1:0] expected_y [R-1:0];
    reg signed [ACC_WIDTH-1:0] actual_y_val;

    integer test_count;
    integer pass_count;
    integer fail_count;

    matrix_mul_top dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .done(done),
        .y0(y0),
        .y1(y1),
        .y2(y2),
        .y3(y3),
        .y4(y4),
        .y5(y5),
        .y6(y6),
        .y7(y7)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    task generate_data;
        integer j;
        begin
            for (j = 0; j < C; j = j + 1) begin
                x_val[j] = $random;
                dut.u_sram_x.mem[j] = x_val[j];

                dut.u_sram_b1.mem[j] = $random;
                dut.u_sram_b2.mem[j] = $random;
                dut.u_sram_b3.mem[j] = $random;
                dut.u_sram_b4.mem[j] = $random;
                dut.u_sram_b5.mem[j] = $random;
                dut.u_sram_b6.mem[j] = $random;
                dut.u_sram_b7.mem[j] = $random;
                dut.u_sram_b8.mem[j] = $random;
            end

            expected_y[0] = (dut.u_sram_b1.mem[0] * x_val[0]) +
                            (dut.u_sram_b1.mem[1] * x_val[1]) +
                            (dut.u_sram_b1.mem[2] * x_val[2]) +
                            (dut.u_sram_b1.mem[3] * x_val[3]) +
                            (dut.u_sram_b1.mem[4] * x_val[4]) +
                            (dut.u_sram_b1.mem[5] * x_val[5]) +
                            (dut.u_sram_b1.mem[6] * x_val[6]) +
                            (dut.u_sram_b1.mem[7] * x_val[7]);

            expected_y[1] = (dut.u_sram_b2.mem[0] * x_val[0]) +
                            (dut.u_sram_b2.mem[1] * x_val[1]) +
                            (dut.u_sram_b2.mem[2] * x_val[2]) +
                            (dut.u_sram_b2.mem[3] * x_val[3]) +
                            (dut.u_sram_b2.mem[4] * x_val[4]) +
                            (dut.u_sram_b2.mem[5] * x_val[5]) +
                            (dut.u_sram_b2.mem[6] * x_val[6]) +
                            (dut.u_sram_b2.mem[7] * x_val[7]);

            expected_y[2] = (dut.u_sram_b3.mem[0] * x_val[0]) +
                            (dut.u_sram_b3.mem[1] * x_val[1]) +
                            (dut.u_sram_b3.mem[2] * x_val[2]) +
                            (dut.u_sram_b3.mem[3] * x_val[3]) +
                            (dut.u_sram_b3.mem[4] * x_val[4]) +
                            (dut.u_sram_b3.mem[5] * x_val[5]) +
                            (dut.u_sram_b3.mem[6] * x_val[6]) +
                            (dut.u_sram_b3.mem[7] * x_val[7]);

            expected_y[3] = (dut.u_sram_b4.mem[0] * x_val[0]) +
                            (dut.u_sram_b4.mem[1] * x_val[1]) +
                            (dut.u_sram_b4.mem[2] * x_val[2]) +
                            (dut.u_sram_b4.mem[3] * x_val[3]) +
                            (dut.u_sram_b4.mem[4] * x_val[4]) +
                            (dut.u_sram_b4.mem[5] * x_val[5]) +
                            (dut.u_sram_b4.mem[6] * x_val[6]) +
                            (dut.u_sram_b4.mem[7] * x_val[7]);

            expected_y[4] = (dut.u_sram_b5.mem[0] * x_val[0]) +
                            (dut.u_sram_b5.mem[1] * x_val[1]) +
                            (dut.u_sram_b5.mem[2] * x_val[2]) +
                            (dut.u_sram_b5.mem[3] * x_val[3]) +
                            (dut.u_sram_b5.mem[4] * x_val[4]) +
                            (dut.u_sram_b5.mem[5] * x_val[5]) +
                            (dut.u_sram_b5.mem[6] * x_val[6]) +
                            (dut.u_sram_b5.mem[7] * x_val[7]);

            expected_y[5] = (dut.u_sram_b6.mem[0] * x_val[0]) +
                            (dut.u_sram_b6.mem[1] * x_val[1]) +
                            (dut.u_sram_b6.mem[2] * x_val[2]) +
                            (dut.u_sram_b6.mem[3] * x_val[3]) +
                            (dut.u_sram_b6.mem[4] * x_val[4]) +
                            (dut.u_sram_b6.mem[5] * x_val[5]) +
                            (dut.u_sram_b6.mem[6] * x_val[6]) +
                            (dut.u_sram_b6.mem[7] * x_val[7]);

            expected_y[6] = (dut.u_sram_b7.mem[0] * x_val[0]) +
                            (dut.u_sram_b7.mem[1] * x_val[1]) +
                            (dut.u_sram_b7.mem[2] * x_val[2]) +
                            (dut.u_sram_b7.mem[3] * x_val[3]) +
                            (dut.u_sram_b7.mem[4] * x_val[4]) +
                            (dut.u_sram_b7.mem[5] * x_val[5]) +
                            (dut.u_sram_b7.mem[6] * x_val[6]) +
                            (dut.u_sram_b7.mem[7] * x_val[7]);

            expected_y[7] = (dut.u_sram_b8.mem[0] * x_val[0]) +
                            (dut.u_sram_b8.mem[1] * x_val[1]) +
                            (dut.u_sram_b8.mem[2] * x_val[2]) +
                            (dut.u_sram_b8.mem[3] * x_val[3]) +
                            (dut.u_sram_b8.mem[4] * x_val[4]) +
                            (dut.u_sram_b8.mem[5] * x_val[5]) +
                            (dut.u_sram_b8.mem[6] * x_val[6]) +
                            (dut.u_sram_b8.mem[7] * x_val[7]);
        end
    endtask

    integer k;
    reg test_pass;

    initial begin
        start = 0;
        rst_n = 0;
        #20;
        rst_n = 1;

        test_count = 0;
        pass_count = 0;
        fail_count = 0;

        for (test_count = 0; test_count < 1000; test_count = test_count + 1) begin
            generate_data;

            @(negedge clk);
            start = 1;
            @(negedge clk);
            start = 0;

            wait(done == 1);

            test_pass = 1;
            for (k = 0; k < R; k = k + 1) begin
                actual_y_val = actual_y[k];
                if (actual_y_val !== expected_y[k]) begin
                    $display("TEST %0d FAIL | Row %0d: Expected=%0d Actual=%0d", test_count + 1, k, expected_y[k], actual_y_val);
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

            wait(done == 0);
        end

        $display("========================================");
        $display("PASS : %0d   || FAIL : %0d", pass_count, fail_count);
        $display("========================================");
        $finish;
    end

endmodule
