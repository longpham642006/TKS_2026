module matrix_mul_top (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        start,
    output wire        done,

    output wire [39:0] y0,
    output wire [39:0] y1,
    output wire [39:0] y2,
    output wire [39:0] y3,
    output wire [39:0] y4,
    output wire [39:0] y5,
    output wire [39:0] y6,
    output wire [39:0] y7
);

    // Tín hiệu nội bộ
    wire       i_inc;
    wire       i_rs;
    wire       acc_en;
    wire       acc_clr;
    wire       i_last;
    wire [3:0] i;


    wire [15:0] x_data;
    wire [15:0] a0_data, a1_data, a2_data, a3_data;
    wire [15:0] a4_data, a5_data, a6_data, a7_data;

   
    controller u_controller (
        .clk     (clk),
        .rst_n   (rst_n),
        .start   (start),
        .i_last  (i_last),
        .acc_en  (acc_en),
        .acc_clr (acc_clr),
        .i_inc   (i_inc),
        .i_rs    (i_rs),
        .done    (done)
    );

    
    sram_bank_mem #(16, 4, 8) u_sram_x (
        .clk   (clk),
        .addr  (i),
        .rdata (x_data)
    );

    
    sram_bank_mem #(16, 4, 8) u_sram_b1 (.clk(clk), .addr(i), .rdata(a0_data));
    sram_bank_mem #(16, 4, 8) u_sram_b2 (.clk(clk), .addr(i), .rdata(a1_data));
    sram_bank_mem #(16, 4, 8) u_sram_b3 (.clk(clk), .addr(i), .rdata(a2_data));
    sram_bank_mem #(16, 4, 8) u_sram_b4 (.clk(clk), .addr(i), .rdata(a3_data));
    sram_bank_mem #(16, 4, 8) u_sram_b5 (.clk(clk), .addr(i), .rdata(a4_data));
    sram_bank_mem #(16, 4, 8) u_sram_b6 (.clk(clk), .addr(i), .rdata(a5_data));
    sram_bank_mem #(16, 4, 8) u_sram_b7 (.clk(clk), .addr(i), .rdata(a6_data));
    sram_bank_mem #(16, 4, 8) u_sram_b8 (.clk(clk), .addr(i), .rdata(a7_data));

  
    matrix_mul_datapath u_datapath (
        .clk     (clk),
        .rst_n   (rst_n),
        .i_inc   (i_inc),
        .i_rs    (i_rs),
        .acc_en  (acc_en),
        .acc_clr (acc_clr),

        .a0      (a0_data),
        .a1      (a1_data),
        .a2      (a2_data),
        .a3      (a3_data),
        .a4      (a4_data),
        .a5      (a5_data),
        .a6      (a6_data),
        .a7      (a7_data),
        .x       (x_data),

        .y0      (y0),
        .y1      (y1),
        .y2      (y2),
        .y3      (y3),
        .y4      (y4),
        .y5      (y5),
        .y6      (y6),
        .y7      (y7),
        .i_o     (i),
        .i_last  (i_last)
    );

endmodule