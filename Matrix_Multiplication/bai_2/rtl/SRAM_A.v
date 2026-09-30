module sram_a #(
    parameter C = 8,
    parameter R = 8,
    parameter WIDTH_DATA = 16
)(
    input wire [2:0] adr,

    output reg signed [WIDTH_DATA-1:0] d_out0,
    output reg signed [WIDTH_DATA-1:0] d_out1,
    output reg signed [WIDTH_DATA-1:0] d_out2,
    output reg signed [WIDTH_DATA-1:0] d_out3,
    output reg signed [WIDTH_DATA-1:0] d_out4,
    output reg signed [WIDTH_DATA-1:0] d_out5,
    output reg signed [WIDTH_DATA-1:0] d_out6,
    output reg signed [WIDTH_DATA-1:0] d_out7
);
    reg signed [WIDTH_DATA-1:0] bank0 [R-1:0];
    reg signed [WIDTH_DATA-1:0] bank1 [R-1:0];
    reg signed [WIDTH_DATA-1:0] bank2 [R-1:0];
    reg signed [WIDTH_DATA-1:0] bank3 [R-1:0];
    reg signed [WIDTH_DATA-1:0] bank4 [R-1:0];
    reg signed [WIDTH_DATA-1:0] bank5 [R-1:0];
    reg signed [WIDTH_DATA-1:0] bank6 [R-1:0];
    reg signed [WIDTH_DATA-1:0] bank7 [R-1:0];



    always @(*) begin
        d_out0 = bank0[adr];
        d_out1 = bank1[adr];
        d_out2 = bank2[adr];
        d_out3 = bank3[adr];
        d_out4 = bank4[adr];
        d_out5 = bank5[adr];
        d_out6 = bank6[adr];
        d_out7 = bank7[adr];
    end 
endmodule