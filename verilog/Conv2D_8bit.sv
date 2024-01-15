`timescale 1 ns / 1 ps 

module reduce_4_2cycles (
    input clk,
    input [7:0] in [0:3],
    output [7:0] out
);
    logic [7:0] lvl1 [0:3];
    logic [7:0] lvl2;
    always_ff @(posedge clk) begin
        lvl1 <= in;
        lvl2 <= lvl1[0] + lvl1[1] + lvl1[2] + lvl1[3];
    end

    assign out = lvl2;
endmodule

module reduce_16_3cycles (
    input clk,
    input [7:0] in [0:15],
    output [7:0] out
);
    logic [7:0] lvl1 [0:15];
    logic [7:0] lvl2 [0:3];
    logic [7:0] lvl3;
    always_ff @(posedge clk) begin
        lvl1 <= in;
        lvl2[0] <= lvl1[0] + lvl1[1] + lvl1[2] + lvl1[3];
        lvl2[1] <= lvl1[4] + lvl1[5] + lvl1[6] + lvl1[7];
        lvl2[2] <= lvl1[8] + lvl1[9] + lvl1[10] + lvl1[11];
        lvl2[3] <= lvl1[12] + lvl1[13] + lvl1[14] + lvl1[15];

        lvl3 <= lvl2[0] + lvl2[1] + lvl2[2] + lvl2[3];
    end

    assign out = lvl3;
endmodule

module reduce_32_4cycles (
    input clk,
    input [7:0] in [0:31],
    output [7:0] out
);
    logic [7:0] lvl1 [0:31];
    logic [7:0] lvl2 [0:7];
    logic [7:0] lvl3 [0:1];
    logic [7:0] lvl4;
    always_ff @(posedge clk) begin
        lvl1 <= in;
        lvl2[0] <= lvl1[0] + lvl1[1] + lvl1[2] + lvl1[3];
        lvl2[1] <= lvl1[4] + lvl1[5] + lvl1[6] + lvl1[7];
        lvl2[2] <= lvl1[8] + lvl1[9] + lvl1[10] + lvl1[11];
        lvl2[3] <= lvl1[12] + lvl1[13] + lvl1[14] + lvl1[15];
        lvl2[4] <= lvl1[16] + lvl1[17] + lvl1[18] + lvl1[19];
        lvl2[5] <= lvl1[20] + lvl1[21] + lvl1[22] + lvl1[23];
        lvl2[6] <= lvl1[24] + lvl1[25] + lvl1[26] + lvl1[27];
        lvl2[7] <= lvl1[28] + lvl1[29] + lvl1[30] + lvl1[31];

        lvl3[0] <= lvl2[0] + lvl2[1] + lvl2[2] + lvl2[3];
        lvl3[1] <= lvl2[4] + lvl2[5] + lvl2[6] + lvl2[7];
        lvl4 <= lvl3[0] + lvl3[1];
    end

    assign out = lvl4;
endmodule

module reduce_25_4cycles (
    input clk,
    input [7:0] in [0:24],
    output [7:0] out
);
    logic [7:0] lvl1 [0:24];
    logic [7:0] lvl2 [0:7];
    logic [7:0] lvl3 [0:1];
    logic [7:0] lvl4;
    always_ff @(posedge clk) begin
        lvl1 <= in;
        lvl2[0] <= lvl1[0] + lvl1[1] + lvl1[2] + lvl1[3];
        lvl2[1] <= lvl1[4] + lvl1[5] + lvl1[6] + lvl1[7];
        lvl2[2] <= lvl1[8] + lvl1[9] + lvl1[10] + lvl1[11];
        lvl2[3] <= lvl1[12] + lvl1[13] + lvl1[14] + lvl1[15];
        lvl2[4] <= lvl1[16] + lvl1[17] + lvl1[18] + lvl1[19];
        lvl2[5] <= lvl1[20] + lvl1[21] + lvl1[22];
        lvl2[6] <= lvl1[23];
        lvl2[7] <= lvl1[24];

        lvl3[0] <= lvl2[0] + lvl2[1] + lvl2[2] + lvl2[3];
        lvl3[1] <= lvl2[4] + lvl2[5] + lvl2[6] + lvl2[7];
        lvl4 <= lvl3[0] + lvl3[1];
    end

    assign out = lvl4;
endmodule

module myproject (
    input   [7:0] conv2d_1_input_V_data_V_dout,
    input   conv2d_1_input_V_data_V_empty_n,
    output  conv2d_1_input_V_data_V_read,
    output  reg [7:0] layer4_out_V_data_V_din,
    input   layer4_out_V_data_V_full_n,
    output  reg layer4_out_V_data_V_write,
    input   ap_clk,
    input   ap_rst,
    input   ap_start,
    output  ap_done, //ignored
    output  ap_ready, //kinda weird?
    output  ap_idle, //ignored
    input   ap_continue
);

function automatic logic [7:0] mult(input logic [7:0] a, input logic [7:0] b);
    logic [15:0] res = $signed(a) * $signed(b);
    return res[12:5];
endfunction
    
function automatic logic [7:0] relu(input logic [7:0] a);
    return ($signed(a) > 0) ? a : 0;
endfunction

assign ap_done = 0;
assign ap_idle = 0;

localparam KERNEL_W = 5;
localparam KERNEL_H = 5;
localparam IN_W = 16;
localparam IN_H = 16;
localparam N_IN = IN_W*IN_H;
localparam OUTSIDE_KERNEL_W = IN_W-KERNEL_W;
localparam OUT_W = 12;
localparam OUT_H = 12;
localparam N_OUT = OUT_W*OUT_H;

localparam [7:0] weights [0:24] = {
8'h08, 8'hf7, 8'h07, 8'h05, 8'h06, 8'hfa, 8'h07, 8'h04, 8'hf7, 8'hf8, 8'h05, 8'h09, 8'h09, 8'hf8, 8'hfa, 8'hf6, 8'h05, 8'h08, 8'hfa, 8'hf7, 8'h00, 8'hfa, 8'hfc, 8'h06, 8'h03 };
localparam [7:0] biases [0:0] = {
8'hd7 };

logic [7:0] num_have_output;
logic [7:0] shift_reg_rows [0:KERNEL_H-1][0:KERNEL_W-1];
logic [7:0] shift_reg_prod [0:KERNEL_H-1][0:KERNEL_W-1];
logic [7:0] outside_kernel_rows [0:KERNEL_H-2][0:OUTSIDE_KERNEL_W-1];
logic do_shift, do_shift_regular, do_shift_filling, just_shifted;

genvar r;
genvar c;
for (r = 0; r < KERNEL_H; r = r + 1) begin : shift_sreg_rows
    for (c = 0; c < KERNEL_W-1; c = c + 1) begin : shift_sreg_cols
        assign shift_reg_prod[r][c] = mult(shift_reg_rows[r][c], weights[r*KERNEL_W+c]);
        always_ff @(posedge ap_clk) begin
            if (do_shift) begin
                shift_reg_rows[r][c] <= shift_reg_rows[r][c+1];
            end
        end
    end
    assign shift_reg_prod[r][KERNEL_W-1] = mult(shift_reg_rows[r][KERNEL_W-1], weights[r*KERNEL_W+KERNEL_W-1]);
    always_ff @(posedge ap_clk) begin
        if (do_shift) begin
            if (r == KERNEL_H - 1) begin
                shift_reg_rows[r][KERNEL_W-1] <= conv2d_1_input_V_data_V_dout;
            end else begin
                shift_reg_rows[r][KERNEL_W-1] <= outside_kernel_rows[r][0];
            end
        end
    end
end

for (r = 0; r < KERNEL_H-1; r = r + 1) begin : shift_ookernel_rows
    for (c = 0; c < OUTSIDE_KERNEL_W-1; c = c + 1) begin : shift_ookernel_cols
        always_ff @(posedge ap_clk) begin
            if (do_shift)
                outside_kernel_rows[r][c] <= outside_kernel_rows[r][c+1];
        end
    end
    always_ff @(posedge ap_clk) begin
        if (do_shift)
            outside_kernel_rows[r][OUTSIDE_KERNEL_W-1] <= shift_reg_rows[r+1][0];
    end
end

logic [7:0] next_shift_col;
logic [7:0] filling_rows_done;
logic just_shifted_regular;
assign do_shift_filling = ((filling_rows_done != KERNEL_H-1 || next_shift_col < KERNEL_W-1) && conv2d_1_input_V_data_V_empty_n);
assign do_shift_regular = (!(filling_rows_done != KERNEL_H-1 || next_shift_col < KERNEL_W-1) && conv2d_1_input_V_data_V_empty_n && layer4_out_V_data_V_full_n);
assign do_shift = do_shift_filling || do_shift_regular;
assign conv2d_1_input_V_data_V_read = do_shift;

always_ff @(posedge ap_clk) begin
    if (ap_rst || num_have_output == N_OUT) begin
        filling_rows_done <= 0;
        num_have_output <= 0;
        next_shift_col <= 0;
        just_shifted_regular <= 0;
    end
    else if (do_shift) begin
        next_shift_col <= next_shift_col + 1;
        if (next_shift_col == IN_W-1) begin
            next_shift_col <= 0;
            if (do_shift_filling)
                filling_rows_done <= filling_rows_done + 1;
        end
    end
    just_shifted_regular <= do_shift_regular;
end

logic [7:0] conv_sum;
logic reducer_out_valid_1;
logic reducer_out_valid_2;
logic reducer_out_valid_3;
logic reducer_out_valid_4;
logic do_output;
reduce_25_4cycles reducer (
    .clk(ap_clk),
    .in({shift_reg_prod[0], shift_reg_prod[1], shift_reg_prod[2], shift_reg_prod[3], shift_reg_prod[4]}),
    .out(conv_sum)
);
always_ff @(posedge ap_clk) begin
    reducer_out_valid_1 <= 0;
    reducer_out_valid_2 <= reducer_out_valid_1;
    reducer_out_valid_3 <= reducer_out_valid_2;
    reducer_out_valid_4 <= reducer_out_valid_3;
    if (ap_rst || num_have_output == N_OUT) begin
        reducer_out_valid_1 <= 0;
        reducer_out_valid_2 <= 0;
        reducer_out_valid_3 <= 0;
        reducer_out_valid_4 <= 0;
    end
    else if (just_shifted_regular) begin //possible bug
        reducer_out_valid_1 <= 1;
    end
end

assign do_output = reducer_out_valid_4 && num_have_output != N_OUT;

always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
        layer4_out_V_data_V_write <= 0;
        layer4_out_V_data_V_din <= 0;
    end
    else begin
        layer4_out_V_data_V_write <= do_output;
        layer4_out_V_data_V_din <= relu(conv_sum + biases[0]);
    end
end
assign ap_ready = num_have_output == N_OUT;

always_ff @(posedge ap_clk) begin
    if (do_output) begin
        num_have_output <= num_have_output + 1;
    end
end

endmodule