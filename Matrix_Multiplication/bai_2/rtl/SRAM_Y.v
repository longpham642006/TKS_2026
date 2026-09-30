module sram_y #(
    parameter C = 8,
    parameter R = 8,
    parameter ACC_WIDTH = 40
)(
    input wire clk,
    input wire we,
    input wire [$clog2(R)-1:0] adr,
    input wire [ACC_WIDTH-1:0] d_in,

    input wire [$clog2(R)-1:0] rd_adr,
    output wire [ACC_WIDTH-1:0] d_out
);
    reg [ACC_WIDTH-1:0] mem [R-1:0];

    always @(posedge clk) begin
        if (we) begin
            mem[adr] <= d_in;
        end
    end
    
    // Gán dữ liệu đọc
    assign d_out = mem[rd_adr];
    
endmodule