module top_P2 #(
    parameter C = 8,
    parameter R = 8,
    parameter DATA_WIDTH = 16,
    parameter ACC_WIDTH = 40
)(
    input wire clk,
    input wire rst_n,
    input wire start,
    output wire done,
    
    // Thêm các port giao tiếp ra ngoài (Rất quan trọng)
    input wire [$clog2(R)-1:0] read_adr,
    output wire [ACC_WIDTH-1:0] read_data
);

    wire [2:0] w_adr;
    wire w_we;
    wire [ACC_WIDTH-1:0] w_y_out;
    
    wire signed [DATA_WIDTH-1:0] w_a0, w_a1, w_a2, w_a3, w_a4, w_a5, w_a6, w_a7;

    P2 #(
        .C(C), .R(R), .DATA_WIDTH(DATA_WIDTH), .ACC_WIDTH(ACC_WIDTH)
    ) u_p2 (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        
        .a0(w_a0), .a1(w_a1), .a2(w_a2), .a3(w_a3),
        .a4(w_a4), .a5(w_a5), .a6(w_a6), .a7(w_a7),
        
        .adr(w_adr),
        .done(done),
        .w_en(w_we),
        .y_out(w_y_out)
    );

    sram_a #(
        .C(C), .R(R), .WIDTH_DATA(DATA_WIDTH)
    ) u_sram_a (
        .adr(w_adr),
        .d_out0(w_a0), .d_out1(w_a1), .d_out2(w_a2), .d_out3(w_a3),
        .d_out4(w_a4), .d_out5(w_a5), .d_out6(w_a6), .d_out7(w_a7)
    );

    sram_y #(
        .C(C), .R(R), .ACC_WIDTH(ACC_WIDTH)
    ) u_sram_y (
        .clk(clk),
        .we(w_we),
        .adr(w_adr),
        .d_in(w_y_out),
        
        // Kết nối port ra ngoài
        .rd_adr(read_adr),
        .d_out(read_data)
    );

endmodule