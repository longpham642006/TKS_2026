module sram_bank_mem #(
    parameter DATA_WIDTH = 16,
    parameter ADDR_WIDTH = 4,
    parameter DEPTH      = 8
)(
    input  wire                  clk,
    input  wire [ADDR_WIDTH-1:0] addr,
    output wire [DATA_WIDTH-1:0] rdata
);
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    assign rdata = mem[addr];
endmodule