module matrix_mul_datapath (
    input wire clk,
    input wire rst_n,

    input wire i_inc,
    input wire i_rs,
    input wire acc_en,
    input wire acc_clr,

    input wire [15:0] a0,
    input wire [15:0] a1,
    input wire [15:0] a2,
    input wire [15:0] a3,
    input wire [15:0] a4,
    input wire [15:0] a5,
    input wire [15:0] a6,
    input wire [15:0] a7,
    input wire [15:0] x,

    output wire [39:0] y0,
    output wire [39:0] y1,
    output wire [39:0] y2,
    output wire [39:0] y3,
    output wire [39:0] y4,
    output wire [39:0] y5,
    output wire [39:0] y6,
    output wire [39:0] y7,
    output wire [3:0] i_o,
    output wire i_last
);
    // Index
    reg [3:0] i;
// Accumulator
    reg [39:0] y_out [7:0];
// Multiplication results
    wire [31:0] prod [7:0];

    // Sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            i <= 4'd0;
            y_out[0] <= 40'd0;
            y_out[1] <= 40'd0;
            y_out[2] <= 40'd0;
            y_out[3] <= 40'd0;
            y_out[4] <= 40'd0;
            y_out[5] <= 40'd0;
            y_out[6] <= 40'd0;
            y_out[7] <= 40'd0;
        end
        else begin
            if (i_rs)
                i <= 4'd0;
            else if (i_inc)
                i <= i + 1'b1;

            if (acc_clr) begin
                y_out[0] <= 40'd0;
                y_out[1] <= 40'd0;
                y_out[2] <= 40'd0;
                y_out[3] <= 40'd0;
                y_out[4] <= 40'd0;
                y_out[5] <= 40'd0;
                y_out[6] <= 40'd0;
                y_out[7] <= 40'd0;
            end
            else if (acc_en) begin
                y_out[0] <= y_out[0] + prod[0];
                y_out[1] <= y_out[1] + prod[1];
                y_out[2] <= y_out[2] + prod[2];
                y_out[3] <= y_out[3] + prod[3];
                y_out[4] <= y_out[4] + prod[4];
                y_out[5] <= y_out[5] + prod[5];
                y_out[6] <= y_out[6] + prod[6];
                y_out[7] <= y_out[7] + prod[7];
            end
        end
    end

    // Multipliers
    assign prod[0] = a0 * x;
    assign prod[1] = a1 * x;
    assign prod[2] = a2 * x;
    assign prod[3] = a3 * x;
    assign prod[4] = a4 * x;
    assign prod[5] = a5 * x;
    assign prod[6] = a6 * x;
    assign prod[7] = a7 * x;

    // Last index
    assign i_last = (i == 4'd7);
    assign i_o = i;

    // Outputs
    assign y0 = y_out[0];
    assign y1 = y_out[1];
    assign y2 = y_out[2];
    assign y3 = y_out[3];
    assign y4 = y_out[4];
    assign y5 = y_out[5];
    assign y6 = y_out[6];
    assign y7 = y_out[7];

endmodule