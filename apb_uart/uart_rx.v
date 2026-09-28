module uart_rx #(
    parameter DBIT = 8,     
    parameter SB_TICK = 16   
)(
    input  wire       clk,
    input  wire       rst_n,
    input  wire       rx_i,
    input  wire       s_tick,
    output reg        rx_done,
    output wire [DBIT-1:0] b_out
);
    //double sampling 
    reg rx_ff1,rx_sync;
    always @(posedge clk,negedge rst_n) begin
        if(!rst_n) begin
            rx_ff1 <= 1;
            rx_sync <= 1;
        end
        else begin
            rx_ff1 <= rx_i;
            rx_sync <= rx_ff1;
        end
    end
    // Khai báo biến
    localparam [1:0]
        IDLE  = 2'b00,
        START = 2'b01,
        DATA  = 2'b10,
        STOP  = 2'b11;
        reg [1:0] state, next_state;

        reg [DBIT-1:0]           b_reg;
        reg [$clog2(SB_TICK)-1:0] s_reg;
        reg [$clog2(DBIT)-1:0] n_reg;
    // tín hiệu điều khiển
    reg s_inc,s_clr,n_inc,n_clr,b_load;

    //datapath
    always @(posedge clk) begin
        if(s_clr) s_reg <= 0;
        else if(s_inc)  s_reg <= s_reg + 1;
        if(n_clr) n_reg <= 0;
        else if(n_inc) n_reg <= n_reg + 1;
        if(b_load) b_reg <= {rx_sync,b_reg[DBIT-1:1]};
    end
    // state flag
    wire s_mid,s_max,n_max;
    assign s_mid = (s_reg == SB_TICK/2-1);
    assign s_max = (s_reg == SB_TICK-1);
    assign n_max = (n_reg == DBIT-1);

    //FSM
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    //FSM LOGIC
    always @(*) begin
        {s_inc,s_clr,n_inc,n_clr,b_load,rx_done} = 6'b000000;
        next_state = state;
        case(state) 
        IDLE: begin
            if(!rx_sync) begin
                next_state = START;
                s_clr = 1;
            end 
        end
        START: begin
            if (s_tick) begin
                if(s_mid) begin
                    s_clr = 1;
                    n_clr = 1;
                    next_state = DATA;
                end
                else begin
                    s_inc = 1;
                end
            end
        end
        DATA: begin
            if (s_tick) begin
                if (s_max) begin 
                    s_clr = 1'b1;
                    b_load = 1'b1;
                        
                    if (n_max) begin 
                        next_state = STOP;
                    end
                    else begin
                        n_inc = 1'b1;
                    end
                end
                else begin
                    s_inc = 1'b1;
                end
            end
        end
        STOP: begin
            if(s_tick) begin
                if(s_max) begin
                    rx_done = 1;
                    next_state = IDLE;
                end
                else begin
                    s_inc = 1;
                end
            end
        end         
        endcase
    end
    assign b_out = b_reg;
endmodule