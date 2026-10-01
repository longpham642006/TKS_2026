`timescale 1ns/1ps

module tb_top_P2;
    parameter C = 8;
    parameter R = 8;
    parameter DATA_WIDTH = 16;
    parameter ACC_WIDTH = 40;
    
    reg clk;
    reg rst_n;
    reg start;
    wire done;

    reg signed [DATA_WIDTH-1:0] x_val [C-1:0];
    reg signed [ACC_WIDTH-1:0] expected_y [R-1:0]; 
    reg signed [ACC_WIDTH-1:0] actual_y;

    integer test_count;
    integer pass_count;
    integer fail_count;

    top_P2 #(
        .C(C), .R(R), .DATA_WIDTH(DATA_WIDTH), .ACC_WIDTH(ACC_WIDTH)
    ) dut (
        .clk(clk), .rst_n(rst_n), .start(start), .done(done)
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
                dut.u_p2.x_value[j] = x_val[j];
            end
            
            for (i = 0; i < R; i = i + 1) begin
                dut.u_sram_a.bank0[i] = $random; dut.u_sram_a.bank1[i] = $random;
                dut.u_sram_a.bank2[i] = $random; dut.u_sram_a.bank3[i] = $random;
                dut.u_sram_a.bank4[i] = $random; dut.u_sram_a.bank5[i] = $random;
                dut.u_sram_a.bank6[i] = $random; dut.u_sram_a.bank7[i] = $random;

                expected_y[i] = (dut.u_sram_a.bank0[i] * x_val[0]) +
                                (dut.u_sram_a.bank1[i] * x_val[1]) +
                                (dut.u_sram_a.bank2[i] * x_val[2]) +
                                (dut.u_sram_a.bank3[i] * x_val[3]) +
                                (dut.u_sram_a.bank4[i] * x_val[4]) +
                                (dut.u_sram_a.bank5[i] * x_val[5]) +
                                (dut.u_sram_a.bank6[i] * x_val[6]) +
                                (dut.u_sram_a.bank7[i] * x_val[7]);
            end
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
                actual_y = dut.u_sram_y.mem[k]; 
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
            
            wait(done == 0);
        end
        
        $display("========================================");
        $display("PASS : %0d   || FAIL : %0d", pass_count, fail_count);
        $display("========================================");
        $finish;
    end

endmodule