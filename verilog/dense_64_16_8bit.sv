`timescale 1 ns / 1 ps 

module reduce_2_1cycle (
    input clk,
    input signed [7:0] a,
    input signed [7:0] b,
    output signed [7:0] out
);
    logic signed [7:0] a_reg;
    logic signed [7:0] b_reg;
    always_ff @(posedge clk) begin
        a_reg <= a;
        b_reg <= b;
    end

    assign out = a_reg + b_reg;
endmodule

module reduce_4_1cycle (
    input clk,
    input [7:0] in [0:3],
    output [7:0] out
);
    logic [7:0] lvl1 [0:3];
    always_ff @(posedge clk) begin
        lvl1 <= in;
    end

    assign out = lvl1[0] + lvl1[1] + lvl1[2] + lvl1[3];
endmodule


module reduce_8_2cycles (
    input clk,
    input rst,
    input [7:0] in [0:7],
    output [7:0] out
);
    logic [7:0] lvl1 [0:7];
    logic [7:0] lvl2 [0:1];
    always_ff @(posedge clk) begin
        if (rst) begin
            lvl1 <= '{default: '0};
        end
        else begin
            lvl1 <= in;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            lvl2 <= '{default: '0};
        end
        else begin
            lvl2[0] <= lvl1[0] + lvl1[1] + lvl1[2] + lvl1[3];
            lvl2[1] <= lvl1[4] + lvl1[5] + lvl1[6] + lvl1[7];
        end
    end

    assign out = lvl2[0] + lvl2[1];
endmodule

module reduce_16_2cycles (
    input clk,
    input rst,
    input [7:0] in [0:15],
    output [7:0] out
);
    logic [7:0] lvl1 [0:15];
    logic [7:0] lvl2 [0:3];
    always_ff @(posedge clk) begin
        if (rst) begin
            lvl1 <= '{default: '0};
        end
        else begin
            lvl1 <= in;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            lvl2 <= '{default: '0};
        end
        else begin
            lvl2[0] <= lvl1[0] + lvl1[1] + lvl1[2] + lvl1[3];
            lvl2[1] <= lvl1[4] + lvl1[5] + lvl1[6] + lvl1[7];
            lvl2[2] <= lvl1[8] + lvl1[9] + lvl1[10] + lvl1[11];
            lvl2[3] <= lvl1[12] + lvl1[13] + lvl1[14] + lvl1[15];
        end
    end

    assign out = lvl2[0] + lvl2[1] + lvl2[2] + lvl2[3];
endmodule

module mult_8bit(
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] res);
    logic [15:0] m = ($signed(a) * $signed(b));
    assign res = m[12:5];
endmodule

module myproject (
        input ap_clk,
        input ap_rst,
        input ap_start,
        output ap_done,
        output ap_idle,
        output ap_ready,
        input dense_1_input_V_ap_vld,
        input [511:0] dense_1_input_V,
        output [7:0] ap_return_0,
        output [7:0] ap_return_1,
        output [7:0] ap_return_2,
        output [7:0] ap_return_3,
        output [7:0] ap_return_4,
        output [7:0] ap_return_5,
        output [7:0] ap_return_6,
        output [7:0] ap_return_7,
        output [7:0] ap_return_8,
        output [7:0] ap_return_9,
        output [7:0] ap_return_10,
        output [7:0] ap_return_11,
        output [7:0] ap_return_12,
        output [7:0] ap_return_13,
        output [7:0] ap_return_14,
        output [7:0] ap_return_15,
        output dense_1_input_V_blk_n
);

function automatic logic [7:0] mult(input logic [7:0] a, input logic [7:0] b);
    logic [15:0] res = $signed(a) * $signed(b);
    return res[12:5];
endfunction
    
function automatic logic [7:0] relu(input logic [7:0] a);
    return ($signed(a) > 0) ? a : 0;
endfunction
    
localparam N_IN = 64;
localparam N_OUT = 16;
localparam NUM_PARALLEL_COLS = 16;
localparam LAST_CURR_COL = 48;

localparam [7:0] weights [0:1023] = {
8'hff, 8'h04, 8'hfe, 8'hfc, 8'hfa, 8'hfb, 8'h04, 8'h03, 8'h00, 8'h06, 8'hfd, 8'h04, 8'hfa, 8'h04, 8'hfb, 8'hfc, 8'hfe, 8'h06, 8'h00, 8'h01, 8'hf9, 8'h02, 8'hfa, 8'hff, 8'hff, 8'hfe, 8'h02, 8'h01, 8'hfc, 8'h02, 8'hfe, 8'h03, 8'h01, 8'h00, 8'h01, 8'hfc, 8'h03, 8'h05, 8'h00, 8'hfb, 8'hfa, 8'hfe, 8'hff, 8'hfb, 8'hfc, 8'h05, 8'h00, 8'h06, 8'h03, 8'hfd, 8'hfc, 8'hfb, 8'h02, 8'hfa, 8'hfc, 8'hfc, 8'h02, 8'hfe, 8'h00, 8'hfc, 8'hf9, 8'h01, 8'h03, 8'h05, 8'h00, 8'h04, 8'h01, 8'h05, 8'h05, 8'h03, 8'h03, 8'hfa, 8'hfa, 8'hfb, 8'h06, 8'hfd, 8'hfc, 8'hfc, 8'hfa, 8'h05, 8'hfc, 8'h05, 8'h05, 8'hfa, 8'hfc, 8'hff, 8'hfe, 8'hfc, 8'h02, 8'hfd, 8'hfe, 8'h04, 8'h05, 8'h00, 8'hfe, 8'h04, 8'hfc, 8'hfc, 8'hff, 8'h06, 8'hfa, 8'hfb, 8'hfe, 8'h00, 8'h06, 8'h04, 8'h00, 8'h02, 8'hfd, 8'hfd, 8'h03, 8'h05, 8'h03, 8'hfb, 8'hfe, 8'h04, 8'h05, 8'hfb, 8'hfd, 8'h05, 8'h05, 8'h03, 8'h01, 8'h06, 8'hfa, 8'h06, 8'hfc, 8'hfa, 8'h04, 8'hff, 8'h02, 8'hfb, 8'h03, 8'h00, 8'hfa, 8'hf9, 8'h03, 8'h02, 8'h02, 8'h00, 8'hfc, 8'h00, 8'hfb, 8'h05, 8'hff, 8'hfb, 8'hfa, 8'h04, 8'hfa, 8'hfe, 8'hfb, 8'h04, 8'hfb, 8'hfe, 8'h05, 8'hfc, 8'hfa, 8'h01, 8'h04, 8'hfa, 8'hf9, 8'h06, 8'h04, 8'h04, 8'h02, 8'h03, 8'hf9, 8'h06, 8'hfd, 8'hf9, 8'h04, 8'hf9, 8'h06, 8'h04, 8'h02, 8'hfe, 8'h06, 8'h01, 8'hfe, 8'hff, 8'hfd, 8'hfc, 8'hfd, 8'h02, 8'hfc, 8'h03, 8'h04, 8'hfe, 8'hfe, 8'h03, 8'h01, 8'h01, 8'h03, 8'h05, 8'h06, 8'hfa, 8'hfb, 8'hfd, 8'hfd, 8'h03, 8'h02, 8'h03, 8'h01, 8'hfe, 8'hff, 8'h00, 8'h05, 8'h01, 8'hfa, 8'h02, 8'h05, 8'h00, 8'h06, 8'h06, 8'hfe, 8'h04, 8'hff, 8'h05, 8'hf9, 8'h01, 8'h02, 8'hff, 8'h02, 8'h06, 8'h05, 8'h05, 8'hff, 8'h04, 8'h04, 8'h01, 8'hf9, 8'hff, 8'h05, 8'h06, 8'hff, 8'hfd, 8'hf9, 8'h00, 8'hfb, 8'hfe, 8'h02, 8'h03, 8'hff, 8'h03, 8'hfe, 8'h06, 8'h05, 8'hff, 8'hfe, 8'h06, 8'h06, 8'h01, 8'h04, 8'h02, 8'hfd, 8'h03, 8'hf9, 8'h02, 8'hfb, 8'h01, 8'h01, 8'h01, 8'h03, 8'h03, 8'h00, 8'h00, 8'hf9, 8'h06, 8'h06, 8'h03, 8'h05, 8'hf9, 8'h04, 8'h00, 8'h06, 8'hfa, 8'hfd, 8'hfc, 8'hfe, 8'hfd, 8'h05, 8'h02, 8'h03, 8'h02, 8'hfe, 8'hfb, 8'hfb, 8'h06, 8'hfb, 8'hfa, 8'hff, 8'h03, 8'hfc, 8'hf9, 8'hff, 8'h04, 8'hfe, 8'h01, 8'hfe, 8'h05, 8'h04, 8'h04, 8'h04, 8'hf9, 8'h06, 8'hfa, 8'h04, 8'hfd, 8'h03, 8'hfe, 8'h06, 8'hfe, 8'hfc, 8'hfd, 8'h01, 8'h01, 8'h01, 8'hff, 8'h04, 8'hff, 8'hfa, 8'h03, 8'h05, 8'h03, 8'hfc, 8'hfa, 8'h05, 8'hf9, 8'hff, 8'h00, 8'hf9, 8'h04, 8'h03, 8'hfd, 8'hfb, 8'h05, 8'h02, 8'h04, 8'hfc, 8'h04, 8'h05, 8'hff, 8'h06, 8'h04, 8'hfc, 8'h01, 8'hff, 8'h05, 8'hfc, 8'h06, 8'hfb, 8'h01, 8'hf9, 8'hff, 8'h04, 8'h01, 8'hfc, 8'hfd, 8'h05, 8'h03, 8'hfc, 8'hfc, 8'hff, 8'hfb, 8'hfb, 8'hfb, 8'h04, 8'hfa, 8'hfd, 8'hfc, 8'h03, 8'hff, 8'hff, 8'hfc, 8'h00, 8'h02, 8'h03, 8'hff, 8'h00, 8'h03, 8'h05, 8'h03, 8'hf9, 8'h02, 8'hfc, 8'h02, 8'h05, 8'h03, 8'h00, 8'hfd, 8'h06, 8'h03, 8'h04, 8'hfd, 8'hfb, 8'h04, 8'h00, 8'h00, 8'hfd, 8'h06, 8'h06, 8'hfc, 8'h03, 8'h06, 8'hfb, 8'hff, 8'hf9, 8'h03, 8'hff, 8'h05, 8'hff, 8'hfa, 8'h03, 8'hfc, 8'hfb, 8'h06, 8'h06, 8'hff, 8'h05, 8'h00, 8'hfb, 8'h02, 8'hfb, 8'hfb, 8'h04, 8'hfe, 8'h04, 8'hfa, 8'hff, 8'h04, 8'hf9, 8'h00, 8'hfa, 8'h02, 8'h05, 8'hfa, 8'h02, 8'h00, 8'hfe, 8'hfe, 8'hfd, 8'hfc, 8'h04, 8'hf9, 8'h05, 8'hfd, 8'h00, 8'hfc, 8'h01, 8'hf9, 8'h05, 8'h01, 8'hfd, 8'hfb, 8'h04, 8'h00, 8'h01, 8'h01, 8'hfd, 8'h03, 8'hfd, 8'hfd, 8'hfb, 8'hff, 8'h00, 8'hf9, 8'hfe, 8'h01, 8'hfe, 8'h00, 8'h06, 8'hfc, 8'h03, 8'h01, 8'h00, 8'hfd, 8'hf9, 8'hfd, 8'h03, 8'h02, 8'hfd, 8'hfe, 8'hfa, 8'hff, 8'h04, 8'h02, 8'h01, 8'hfb, 8'hfb, 8'hfc, 8'hfc, 8'hfc, 8'hfc, 8'hfa, 8'h01, 8'hfb, 8'h01, 8'h00, 8'hfb, 8'h04, 8'h03, 8'hf9, 8'h02, 8'hff, 8'hfe, 8'hfb, 8'hfb, 8'hfd, 8'h06, 8'hfa, 8'h05, 8'hff, 8'hfd, 8'hfb, 8'hfc, 8'hfd, 8'hfa, 8'h05, 8'h05, 8'h06, 8'hfa, 8'h05, 8'h04, 8'hfb, 8'hfa, 8'hfb, 8'h00, 8'hfd, 8'hff, 8'hfc, 8'h05, 8'hfb, 8'h03, 8'h01, 8'h00, 8'hfa, 8'h01, 8'hfa, 8'h06, 8'h02, 8'h06, 8'h01, 8'hfc, 8'hfc, 8'h05, 8'hfb, 8'h05, 8'h03, 8'hfb, 8'h02, 8'h01, 8'hf9, 8'h01, 8'h01, 8'h04, 8'h04, 8'h05, 8'hfc, 8'h06, 8'hfa, 8'h04, 8'h01, 8'h05, 8'hf9, 8'h05, 8'hfc, 8'hfa, 8'hff, 8'h06, 8'h00, 8'hfe, 8'h03, 8'hfd, 8'h04, 8'hff, 8'h00, 8'h00, 8'h02, 8'hf9, 8'h05, 8'hfc, 8'h06, 8'hfd, 8'hfe, 8'h02, 8'hf9, 8'h06, 8'h04, 8'hfa, 8'hff, 8'h05, 8'hfa, 8'h00, 8'hfe, 8'h04, 8'hf9, 8'h03, 8'h02, 8'h01, 8'h04, 8'hfb, 8'h01, 8'hfa, 8'h03, 8'h02, 8'h03, 8'hfc, 8'h06, 8'hfb, 8'hfe, 8'hfb, 8'hff, 8'hfd, 8'hfd, 8'h03, 8'h06, 8'h05, 8'h03, 8'h02, 8'hfa, 8'hfc, 8'h01, 8'hfc, 8'h06, 8'h06, 8'hfa, 8'h00, 8'hfe, 8'h02, 8'h04, 8'h04, 8'hff, 8'hfb, 8'hff, 8'h00, 8'h02, 8'h03, 8'hfb, 8'hff, 8'h06, 8'hfe, 8'hfd, 8'hf9, 8'h04, 8'h06, 8'h06, 8'h05, 8'hfe, 8'hfa, 8'h00, 8'h04, 8'hfc, 8'h04, 8'h04, 8'h05, 8'hfd, 8'h02, 8'h05, 8'hff, 8'hfc, 8'h01, 8'h00, 8'hfb, 8'hfc, 8'hfb, 8'hfe, 8'h01, 8'h05, 8'hff, 8'hfd, 8'hfa, 8'h03, 8'hfa, 8'hff, 8'hf9, 8'h03, 8'h06, 8'hfd, 8'h01, 8'h02, 8'h02, 8'hfb, 8'h06, 8'hfe, 8'hfc, 8'hff, 8'hfb, 8'hfc, 8'h01, 8'hff, 8'hfc, 8'hfb, 8'h03, 8'hfe, 8'h00, 8'hfb, 8'h05, 8'hff, 8'h01, 8'hfb, 8'hfe, 8'h06, 8'h04, 8'h01, 8'h01, 8'hfe, 8'h06, 8'h03, 8'h03, 8'hfd, 8'h05, 8'h04, 8'hfb, 8'hfc, 8'hfc, 8'hfe, 8'h00, 8'h00, 8'h02, 8'h05, 8'hfe, 8'h00, 8'h01, 8'hfe, 8'hfc, 8'hfc, 8'hfe, 8'h06, 8'hfb, 8'h00, 8'hfe, 8'hfb, 8'hfa, 8'h00, 8'hf9, 8'hfc, 8'h00, 8'hfb, 8'hfa, 8'hff, 8'hfc, 8'hfd, 8'hfe, 8'h06, 8'h06, 8'h03, 8'h04, 8'hf9, 8'hff, 8'h04, 8'hfe, 8'h00, 8'h02, 8'hfa, 8'h02, 8'hff, 8'hfb, 8'h05, 8'hff, 8'h05, 8'hfe, 8'hfb, 8'h03, 8'hfc, 8'hfa, 8'hfa, 8'h02, 8'h05, 8'h06, 8'h02, 8'h04, 8'h05, 8'h03, 8'hfb, 8'h04, 8'hfd, 8'h00, 8'hfe, 8'hf9, 8'hf9, 8'hff, 8'h01, 8'hfe, 8'hfa, 8'hf9, 8'h06, 8'h02, 8'hfc, 8'hfa, 8'hfd, 8'hfd, 8'h05, 8'h01, 8'hff, 8'hfd, 8'hfb, 8'hf9, 8'hf9, 8'h04, 8'hf9, 8'hff, 8'h06, 8'h05, 8'h02, 8'hfa, 8'h00, 8'h03, 8'hff, 8'hf9, 8'hfd, 8'hfd, 8'hf9, 8'hfd, 8'h06, 8'h01, 8'hfa, 8'h02, 8'hff, 8'h02, 8'hfb, 8'hfe, 8'hff, 8'hfa, 8'h04, 8'h02, 8'h02, 8'hf9, 8'h03, 8'hfc, 8'h02, 8'h03, 8'hfd, 8'hfa, 8'hfb, 8'h05, 8'h01, 8'h02, 8'h03, 8'hfb, 8'h00, 8'h06, 8'hfa, 8'h00, 8'hfe, 8'hfa, 8'h03, 8'hfb, 8'h04, 8'h02, 8'h04, 8'h06, 8'hfb, 8'h05, 8'h02, 8'h01, 8'hfb, 8'h02, 8'h03, 8'hfb, 8'h03, 8'hfe, 8'hfc, 8'h04, 8'h02, 8'hfe, 8'h04, 8'h03, 8'hfb, 8'hfc, 8'h02, 8'h02, 8'h05, 8'h05, 8'hfa, 8'h00, 8'h01, 8'h02, 8'h05, 8'hfa, 8'hfb, 8'hfb, 8'hfa, 8'h03, 8'h02, 8'hfb, 8'h01, 8'h00, 8'h01, 8'h02, 8'h05, 8'h04, 8'h01, 8'hf9, 8'hfb, 8'h02, 8'h01, 8'hfc, 8'hfe, 8'hfa, 8'h05, 8'h04, 8'hf9, 8'hfb, 8'hf9, 8'hfa, 8'hfa, 8'hf9, 8'hfc, 8'h06, 8'hfc, 8'h00, 8'h01, 8'hfa, 8'h06, 8'hfa, 8'hff, 8'h06, 8'hfb, 8'hf9, 8'hfe, 8'h05, 8'hfc, 8'hff, 8'h00, 8'h06, 8'h05, 8'h03, 8'h05, 8'h05, 8'h03, 8'h01, 8'hf9, 8'hff, 8'h02, 8'h01, 8'hfa, 8'hfd, 8'hfd, 8'hfa, 8'h06, 8'hf9, 8'h01, 8'h00, 8'hfa, 8'h05, 8'hfb, 8'h01, 8'h06, 8'hfc, 8'hfc, 8'h01, 8'h01, 8'h00, 8'h06, 8'h02, 8'hf9, 8'hff, 8'hfe, 8'h03, 8'hfe, 8'hf9, 8'hfa, 8'hfa, 8'h06, 8'h01, 8'hfb, 8'hfe, 8'h03, 8'hfd, 8'h02, 8'h01, 8'hf9, 8'h01, 8'hfe, 8'h00, 8'h06, 8'h01, 8'h01, 8'hfe, 8'hfc, 8'hfa, 8'hfc, 8'hfa, 8'h02, 8'hfc, 8'hfa, 8'h03, 8'h01, 8'h05, 8'hfa, 8'hfc, 8'hfb, 8'hfb, 8'hfa, 8'hff, 8'hfa, 8'h00, 8'hfd, 8'h01, 8'h02, 8'hf9, 8'h00, 8'h02, 8'h03, 8'h00, 8'hf9, 8'hfa, 8'h06, 8'hff, 8'h00, 8'hf9, 8'h03, 8'h04, 8'h00, 8'hfc, 8'h02, 8'h04, 8'hfe, 8'hfb, 8'h01, 8'hfa, 8'hfa, 8'h00, 8'hfd };
localparam [7:0] biases [0:15] = {
8'hf9, 8'h09, 8'hf2, 8'h0b, 8'h02, 8'hfe, 8'h03, 8'h07, 8'h06, 8'hfb, 8'hf7, 8'h01, 8'hfd, 8'hf7, 8'hfe, 8'h07 };

logic [7:0] data_in [0:N_IN-1];
genvar i;
for (i = 0; i < N_IN; i = i + 1) begin : assign_input
    localparam j = (8*(i+1)) - 1;
    localparam k = 8*(i);
    assign data_in[i] = dense_1_input_V[j:k];
end

typedef enum logic [2:0] {
    IDLE,
    BUSY,
    REDUCING1,
    REDUCING2,
    DONE
  } StateType;

StateType current_state;
StateType next_state;

logic [7:0] acc [0:N_OUT-1];
logic [6:0] curr_col = 0;
logic [7:0] prod[0:N_OUT-1][0:NUM_PARALLEL_COLS-1];
genvar r;
genvar c;
for (r = 0; r < N_OUT; r = r + 1) begin : mult_rows
    for (c = 0; c < NUM_PARALLEL_COLS; c = c + 1) begin : mult_cols
        mult_8bit mult_module (.a(weights[(c+curr_col)*N_OUT + r]), .b(data_in[c+curr_col]), .res(prod[r][c]));
    end
end

logic reducer_out_valid_1;
logic reducer_out_valid;
always_ff @(posedge ap_clk) begin
    reducer_out_valid <= reducer_out_valid_1;
    if (ap_rst) begin
        reducer_out_valid <= 0;
        reducer_out_valid_1 <= 0;
    end
    else if (current_state == BUSY) begin
        reducer_out_valid_1 <= 1;
    end
    else begin
        reducer_out_valid_1 <= 0;
    end
end

logic [7:0] reduced [0:N_OUT-1];
genvar o;
for (o = 0; o < N_OUT; o = o + 1) begin : assign_acc
    reduce_16_2cycles reduce (
        .clk(ap_clk),
        .in((prod[o][0:15])),
        .out(reduced[o])
    );
    always_ff @(posedge ap_clk) begin
        if (ap_start) begin
            acc[o] <= biases[o];
        end
        else if (reducer_out_valid) begin
            acc[o] <= acc[o] + reduced[o]; 
        end
    end
end
    
always_ff @(posedge ap_clk) begin
    if (ap_rst || ap_start) begin
        curr_col <= 0;
    end
    else if (current_state == BUSY) begin
        curr_col <= curr_col + NUM_PARALLEL_COLS;
    end
end

always_comb begin
    if (ap_rst) begin
        next_state = IDLE;
    end else begin
        case (current_state)
            IDLE: next_state = (ap_start) ? BUSY : IDLE;
            BUSY: next_state = (curr_col == LAST_CURR_COL) ? REDUCING1 : BUSY;
            REDUCING1: next_state = REDUCING2;
            REDUCING2: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
end

always_ff @(posedge ap_clk) begin
    current_state <= next_state;
end

assign ap_done = (current_state == DONE);
assign ap_idle = (current_state == IDLE) && !ap_start;
assign ap_ready = ap_start;
assign ap_return_0 = relu(acc[0]);
assign ap_return_1 = relu(acc[1]);
assign ap_return_2 = relu(acc[2]);
assign ap_return_3 = relu(acc[3]);
assign ap_return_4 = relu(acc[4]);
assign ap_return_5 = relu(acc[5]);
assign ap_return_6 = relu(acc[6]);
assign ap_return_7 = relu(acc[7]);
assign ap_return_8 = relu(acc[8]);
assign ap_return_9 = relu(acc[9]);
assign ap_return_10 = relu(acc[10]);
assign ap_return_11 = relu(acc[11]);
assign ap_return_12 = relu(acc[12]);
assign ap_return_13 = relu(acc[13]);
assign ap_return_14 = relu(acc[14]);
assign ap_return_15 = relu(acc[15]);
assign dense_1_input_V_blk_n = 1;

endmodule