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

module myproject (
    input   [7:0] conv1d_1_input_V_data_V_dout,
    input   conv1d_1_input_V_data_V_empty_n,
    output  conv1d_1_input_V_data_V_read,
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

localparam KERNEL_SIZE = 32;
localparam NIN = 128;
localparam NOUT = 97;

localparam [7:0] weights [0:31] = {
8'h04, 8'hff, 8'hfe, 8'hf7, 8'h03, 8'hff, 8'h01, 8'hfe, 8'h02, 8'h04, 8'hf8, 8'hf9, 8'h04, 8'h08, 8'hf6, 8'h01, 8'h08, 8'hfb, 8'hf9, 8'hff, 8'h06, 8'h06, 8'h06, 8'h03, 8'hf9, 8'h08, 8'h05, 8'hf7, 8'hff, 8'hfc, 8'hf7, 8'hf9 };
localparam [7:0] biases [0:0] = {
8'hd2 };

logic [5:0] valid_in_shift_reg;
logic [7:0] num_have_output;
logic [7:0] shift_reg [0:KERNEL_SIZE-1];
logic [7:0] shift_reg_prod [0:KERNEL_SIZE-1];
logic do_shift, do_shift_regular, do_shift_filling, just_shifted;

genvar i;
assign shift_reg_prod[0] = mult(shift_reg[0], weights[0]);
for (i = 1; i < KERNEL_SIZE; i = i + 1) begin : shift_sreg
    assign shift_reg_prod[i] = mult(shift_reg[i], weights[i]);
    always_ff @(posedge ap_clk) begin
        if (do_shift) begin
            shift_reg[i] <= shift_reg[i-1];
        end
    end
end

assign do_shift_filling = (valid_in_shift_reg != KERNEL_SIZE && conv1d_1_input_V_data_V_empty_n);
assign do_shift_regular = (valid_in_shift_reg == KERNEL_SIZE && conv1d_1_input_V_data_V_empty_n && layer4_out_V_data_V_full_n);
assign do_shift = do_shift_filling || do_shift_regular;
assign conv1d_1_input_V_data_V_read = do_shift;

always_ff @(posedge ap_clk) begin
    if (ap_rst || num_have_output == NOUT) begin
        valid_in_shift_reg <= 0;
        num_have_output <= 0;
    end
    else if (do_shift) begin
        shift_reg[0] <= conv1d_1_input_V_data_V_dout;
        if (do_shift_filling) begin
            valid_in_shift_reg <= valid_in_shift_reg + 1;
        end
    end
    just_shifted <= do_shift;
end

logic [7:0] conv_sum;
logic reducer_out_valid_1;
logic reducer_out_valid_2;
logic reducer_out_valid_3;
logic reducer_out_valid_4;
logic do_output;
reduce_32_4cycles reducer (
    .clk(ap_clk),
    .in(shift_reg_prod),
    .out(conv_sum)
);
always_ff @(posedge ap_clk) begin
    reducer_out_valid_1 <= 0;
    reducer_out_valid_2 <= reducer_out_valid_1;
    reducer_out_valid_3 <= reducer_out_valid_2;
    reducer_out_valid_4 <= reducer_out_valid_3;
    if (ap_rst || num_have_output == NOUT) begin
        reducer_out_valid_1 <= 0;
        reducer_out_valid_2 <= 0;
        reducer_out_valid_3 <= 0;
        reducer_out_valid_4 <= 0;
    end
    else if (valid_in_shift_reg == KERNEL_SIZE && just_shifted) begin //possible bug
        reducer_out_valid_1 <= 1;
    end
end

assign do_output = reducer_out_valid_4 && num_have_output != NOUT;

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
assign ap_ready = num_have_output == NOUT;

always_ff @(posedge ap_clk) begin
    if (do_output) begin
        num_have_output <= num_have_output + 1;
    end
end

endmodule