module controller (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire i_last,

    output reg  acc_en,
    output reg  acc_clr,
    output reg  i_inc,
    output reg  i_rs,
    output reg  done
);

    localparam S_IDLE = 2'd0,
               S_CALC = 2'd1,
               S_DONE = 2'd2;

    reg [1:0] state, next_state;

    // Chuyển trạng thái
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Logic điều khiển
    always @(*) begin
        next_state = state;
        acc_en     = 1'b0;
        acc_clr    = 1'b0;
        i_inc      = 1'b0;
        i_rs       = 1'b0;
        done       = 1'b0;

        case (state)
            S_IDLE: begin
                i_rs = 1'b1;
                if (start) begin
                    acc_clr    = 1'b1; 
                    next_state = S_CALC;
                end
            end

            S_CALC: begin
                acc_en = 1'b1; 
                if (i_last) begin
                    i_rs       = 1'b1;
                    next_state = S_DONE;
                end else begin
                    i_inc      = 1'b1;
                end
            end

            S_DONE: begin
                done = 1'b1;
                if (!start)
                    next_state = S_IDLE;
            end

            default: next_state = S_IDLE;
        endcase
    end

endmodule