module P2  #(
    parameter  C = 8,
    parameter  R = 8,
    parameter DATA_WIDTH = 16,
    parameter ACC_WIDTH = 40
)(
    input wire clk,
    input wire rst_n,
    input wire start,
    
    input wire signed  [DATA_WIDTH-1:0] a0,
    input wire signed  [DATA_WIDTH-1:0] a1,
    input wire signed  [DATA_WIDTH-1:0] a2,
    input wire signed  [DATA_WIDTH-1:0] a3,
    input wire signed  [DATA_WIDTH-1:0] a4,
    input wire signed  [DATA_WIDTH-1:0] a5,
    input wire signed  [DATA_WIDTH-1:0] a6,
    input wire signed  [DATA_WIDTH-1:0] a7,

    output wire [2:0] adr,
    output reg done,
    output reg w_en, 
    output wire signed [ACC_WIDTH-1:0] y_out 
);

    reg signed [15:0] x_value [7:0]; 
    
    localparam  IDLE = 2'b00,
                CALC = 2'b01,
                DONE = 2'b10;
                
    reg [1:0] state, next_state;
    reg [2:0] r;
    wire signed [ACC_WIDTH-1:0] prod_0, prod_1, prod_2, prod_3, prod_4, prod_5, prod_6, prod_7;
    wire signed [ACC_WIDTH-1:0] sum, sum_1, sum_2, sum_3, sum_4, sum_5, sum_6;
    wire r_last;

    reg r_inc, r_clr; 
    
    // Bộ đếm R
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) r <= 0;
        else if(r_clr) r <= 0;
        else if(r_inc) r <= r + 1; 
    end

    // Đường dữ liệu
    assign prod_0 = a0 * x_value[0];
    assign prod_1 = a1 * x_value[1];
    assign prod_2 = a2 * x_value[2];
    assign prod_3 = a3 * x_value[3];
    assign prod_4 = a4 * x_value[4];
    assign prod_5 = a5 * x_value[5];
    assign prod_6 = a6 * x_value[6];
    assign prod_7 = a7 * x_value[7];

    assign sum_1 = prod_0 + prod_1;
    assign sum_2 = prod_2 + prod_3;
    assign sum_3 = prod_4 + prod_5;
    assign sum_4 = prod_6 + prod_7;
    
    assign sum_5 = sum_1 + sum_2;
    assign sum_6 = sum_3 + sum_4;
    
    assign sum = sum_5 + sum_6;
    
    assign y_out = sum; 
    assign r_last = (r == R-1);
    assign adr = r;

    // FSM
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) state <= IDLE;
        else state <= next_state;
    end
    
    // Logic của FSM
    always @(state or start) begin
        next_state = state;
        r_clr = 0;
        r_inc = 0;
        w_en = 0;
        done = 0;
        
        case (state)
            IDLE: begin
                if (start) begin
                    r_clr = 1;
                    next_state = CALC;
                end
            end
            CALC: begin
                w_en = 1;   
                r_inc = 1;
                if (r_last) next_state = DONE;
            end
            DONE: begin
                done = 1;
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule