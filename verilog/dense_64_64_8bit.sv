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
    input [7:0] in [0:7],
    output [7:0] out
);
    logic [7:0] lvl1 [0:7];
    logic [7:0] lvl2 [0:1];
    always_ff @(posedge clk) begin
        lvl1 <= in;
    end

    always_ff @(posedge clk) begin
        lvl2[0] <= lvl1[0] + lvl1[1] + lvl1[2] + lvl1[3];
        lvl2[1] <= lvl1[4] + lvl1[5] + lvl1[6] + lvl1[7];
    end

    assign out = lvl2[0] + lvl2[1];
endmodule

module reduce_8_3cycles (
    input clk,
    input [7:0] in [0:7],
    output [7:0] out
);
    logic [7:0] lvl1 [0:7];
    logic [7:0] lvl2 [0:3];
    logic [7:0] lvl3 [0:1];
    always_ff @(posedge clk) begin
        lvl1 <= in;

        lvl2[0] <= lvl1[0] + lvl1[1];
        lvl2[1] <= lvl1[2] + lvl1[3];
        lvl2[2] <= lvl1[4] + lvl1[5];
        lvl2[3] <= lvl1[6] + lvl1[7];

        lvl3[0] <= lvl2[0] + lvl2[1];
        lvl3[1] <= lvl2[2] + lvl2[3];
    end

    assign out = lvl3[0] + lvl3[1];
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

module myproject (
        input ap_clk,
        input ap_rst,
        input ap_start,
        input ap_continue,
        output ap_done,
        output ap_idle,
        output ap_ready,
        input dense_1_input_V_ap_vld,
        input [511:0] dense_1_input_V,
        output [7:0] layer4_out_0_V,
        output [7:0] layer4_out_1_V,
        output [7:0] layer4_out_2_V,
        output [7:0] layer4_out_3_V,
        output [7:0] layer4_out_4_V,
        output [7:0] layer4_out_5_V,
        output [7:0] layer4_out_6_V,
        output [7:0] layer4_out_7_V,
        output [7:0] layer4_out_8_V,
        output [7:0] layer4_out_9_V,
        output [7:0] layer4_out_10_V,
        output [7:0] layer4_out_11_V,
        output [7:0] layer4_out_12_V,
        output [7:0] layer4_out_13_V,
        output [7:0] layer4_out_14_V,
        output [7:0] layer4_out_15_V,
        output [7:0] layer4_out_16_V,
        output [7:0] layer4_out_17_V,
        output [7:0] layer4_out_18_V,
        output [7:0] layer4_out_19_V,
        output [7:0] layer4_out_20_V,
        output [7:0] layer4_out_21_V,
        output [7:0] layer4_out_22_V,
        output [7:0] layer4_out_23_V,
        output [7:0] layer4_out_24_V,
        output [7:0] layer4_out_25_V,
        output [7:0] layer4_out_26_V,
        output [7:0] layer4_out_27_V,
        output [7:0] layer4_out_28_V,
        output [7:0] layer4_out_29_V,
        output [7:0] layer4_out_30_V,
        output [7:0] layer4_out_31_V,
        output [7:0] layer4_out_32_V,
        output [7:0] layer4_out_33_V,
        output [7:0] layer4_out_34_V,
        output [7:0] layer4_out_35_V,
        output [7:0] layer4_out_36_V,
        output [7:0] layer4_out_37_V,
        output [7:0] layer4_out_38_V,
        output [7:0] layer4_out_39_V,
        output [7:0] layer4_out_40_V,
        output [7:0] layer4_out_41_V,
        output [7:0] layer4_out_42_V,
        output [7:0] layer4_out_43_V,
        output [7:0] layer4_out_44_V,
        output [7:0] layer4_out_45_V,
        output [7:0] layer4_out_46_V,
        output [7:0] layer4_out_47_V,
        output [7:0] layer4_out_48_V,
        output [7:0] layer4_out_49_V,
        output [7:0] layer4_out_50_V,
        output [7:0] layer4_out_51_V,
        output [7:0] layer4_out_52_V,
        output [7:0] layer4_out_53_V,
        output [7:0] layer4_out_54_V,
        output [7:0] layer4_out_55_V,
        output [7:0] layer4_out_56_V,
        output [7:0] layer4_out_57_V,
        output [7:0] layer4_out_58_V,
        output [7:0] layer4_out_59_V,
        output [7:0] layer4_out_60_V,
        output [7:0] layer4_out_61_V,
        output [7:0] layer4_out_62_V,
        output [7:0] layer4_out_63_V,
        output layer4_out_0_V_ap_vld,
        output layer4_out_1_V_ap_vld,
        output layer4_out_2_V_ap_vld,
        output layer4_out_3_V_ap_vld,
        output layer4_out_4_V_ap_vld,
        output layer4_out_5_V_ap_vld,
        output layer4_out_6_V_ap_vld,
        output layer4_out_7_V_ap_vld,
        output layer4_out_8_V_ap_vld,
        output layer4_out_9_V_ap_vld,
        output layer4_out_10_V_ap_vld,
        output layer4_out_11_V_ap_vld,
        output layer4_out_12_V_ap_vld,
        output layer4_out_13_V_ap_vld,
        output layer4_out_14_V_ap_vld,
        output layer4_out_15_V_ap_vld,
        output layer4_out_16_V_ap_vld,
        output layer4_out_17_V_ap_vld,
        output layer4_out_18_V_ap_vld,
        output layer4_out_19_V_ap_vld,
        output layer4_out_20_V_ap_vld,
        output layer4_out_21_V_ap_vld,
        output layer4_out_22_V_ap_vld,
        output layer4_out_23_V_ap_vld,
        output layer4_out_24_V_ap_vld,
        output layer4_out_25_V_ap_vld,
        output layer4_out_26_V_ap_vld,
        output layer4_out_27_V_ap_vld,
        output layer4_out_28_V_ap_vld,
        output layer4_out_29_V_ap_vld,
        output layer4_out_30_V_ap_vld,
        output layer4_out_31_V_ap_vld,
        output layer4_out_32_V_ap_vld,
        output layer4_out_33_V_ap_vld,
        output layer4_out_34_V_ap_vld,
        output layer4_out_35_V_ap_vld,
        output layer4_out_36_V_ap_vld,
        output layer4_out_37_V_ap_vld,
        output layer4_out_38_V_ap_vld,
        output layer4_out_39_V_ap_vld,
        output layer4_out_40_V_ap_vld,
        output layer4_out_41_V_ap_vld,
        output layer4_out_42_V_ap_vld,
        output layer4_out_43_V_ap_vld,
        output layer4_out_44_V_ap_vld,
        output layer4_out_45_V_ap_vld,
        output layer4_out_46_V_ap_vld,
        output layer4_out_47_V_ap_vld,
        output layer4_out_48_V_ap_vld,
        output layer4_out_49_V_ap_vld,
        output layer4_out_50_V_ap_vld,
        output layer4_out_51_V_ap_vld,
        output layer4_out_52_V_ap_vld,
        output layer4_out_53_V_ap_vld,
        output layer4_out_54_V_ap_vld,
        output layer4_out_55_V_ap_vld,
        output layer4_out_56_V_ap_vld,
        output layer4_out_57_V_ap_vld,
        output layer4_out_58_V_ap_vld,
        output layer4_out_59_V_ap_vld,
        output layer4_out_60_V_ap_vld,
        output layer4_out_61_V_ap_vld,
        output layer4_out_62_V_ap_vld,
        output layer4_out_63_V_ap_vld
);

function automatic logic [7:0] mult(input logic [7:0] a, input logic [7:0] b);
    logic [15:0] res = $signed(a) * $signed(b);
    return res[12:5];
endfunction
    
function automatic logic [7:0] relu(input logic [7:0] a);
    return ($signed(a) > 0) ? a : 0;
endfunction
    
localparam N_IN = 64;
localparam N_OUT = 64;
localparam NUM_PARALLEL_COLS = 8;
localparam LAST_CURR_COL = 56;

localparam [7:0] weights [0:4095] = {
8'h01, 8'hf9, 8'hf9, 8'hfe, 8'h01, 8'hfa, 8'hff, 8'h03, 8'h04, 8'h05, 8'h02, 8'h03, 8'hfe, 8'hf9, 8'hfe, 8'hff, 8'hfd, 8'h05, 8'h00, 8'hfb, 8'hfa, 8'h00, 8'h02, 8'hf9, 8'hfc, 8'hfa, 8'h01, 8'h00, 8'hf9, 8'h04, 8'h00, 8'hfc, 8'hf9, 8'h01, 8'hf9, 8'hfe, 8'hf9, 8'h03, 8'h01, 8'hf9, 8'hfe, 8'h05, 8'hfd, 8'h03, 8'h06, 8'h06, 8'h05, 8'hff, 8'hfe, 8'hfb, 8'hff, 8'h02, 8'hff, 8'h00, 8'h00, 8'hfe, 8'hfe, 8'h04, 8'hfb, 8'hfe, 8'hf9, 8'hfd, 8'h04, 8'h01, 8'hfc, 8'hfa, 8'hfd, 8'h01, 8'hfe, 8'h04, 8'hfa, 8'hfb, 8'h03, 8'h02, 8'h04, 8'hfd, 8'hfc, 8'hf9, 8'hfe, 8'hfd, 8'h04, 8'hf9, 8'h06, 8'h02, 8'h04, 8'hfd, 8'hfd, 8'hff, 8'hfd, 8'h04, 8'hfa, 8'hfd, 8'hfb, 8'hfd, 8'h06, 8'h06, 8'hfa, 8'hfc, 8'h03, 8'h03, 8'h02, 8'hfb, 8'h04, 8'h05, 8'h00, 8'h06, 8'hfd, 8'hfa, 8'h04, 8'h00, 8'hfb, 8'hf9, 8'hff, 8'h04, 8'hff, 8'h02, 8'h04, 8'hff, 8'hfc, 8'hf9, 8'hfe, 8'hfe, 8'h01, 8'hfb, 8'h05, 8'h03, 8'h02, 8'hff, 8'h05, 8'h05, 8'hfe, 8'h04, 8'h03, 8'hff, 8'h00, 8'hff, 8'hff, 8'h02, 8'hfe, 8'h03, 8'h05, 8'h04, 8'h06, 8'h02, 8'h05, 8'h04, 8'hfc, 8'hf9, 8'h05, 8'hfc, 8'h00, 8'hfd, 8'hf9, 8'hfc, 8'h06, 8'h02, 8'hfd, 8'hf9, 8'h00, 8'h01, 8'h03, 8'h04, 8'hfa, 8'h03, 8'h03, 8'h01, 8'h04, 8'h01, 8'hfe, 8'hfa, 8'hff, 8'h02, 8'h01, 8'h04, 8'h03, 8'hfe, 8'h00, 8'h03, 8'hfc, 8'h02, 8'hfb, 8'hfa, 8'hfc, 8'h01, 8'h03, 8'hfb, 8'h06, 8'hfd, 8'hfb, 8'hfe, 8'hf9, 8'h06, 8'hfa, 8'hfa, 8'h02, 8'h06, 8'h01, 8'hf9, 8'hff, 8'hfa, 8'hfa, 8'hfc, 8'h06, 8'h03, 8'hfb, 8'h05, 8'h04, 8'hfe, 8'hfe, 8'hfd, 8'hfc, 8'h03, 8'hfd, 8'h04, 8'h04, 8'h02, 8'hfd, 8'h01, 8'h05, 8'hff, 8'hfe, 8'hfc, 8'h01, 8'h04, 8'h06, 8'hfe, 8'hfc, 8'h02, 8'h05, 8'h01, 8'h03, 8'hff, 8'hfb, 8'hfb, 8'hfe, 8'h05, 8'h03, 8'hfc, 8'hfc, 8'h03, 8'hff, 8'hfd, 8'h02, 8'hfe, 8'h06, 8'h03, 8'hfe, 8'h06, 8'hfb, 8'hff, 8'h05, 8'h05, 8'hff, 8'h02, 8'h00, 8'hf9, 8'h02, 8'h03, 8'hfc, 8'hfb, 8'h03, 8'h02, 8'hfd, 8'hfa, 8'h05, 8'h00, 8'hfd, 8'h00, 8'hfd, 8'h02, 8'hfd, 8'hfb, 8'hfc, 8'h04, 8'hfe, 8'h04, 8'hfe, 8'h02, 8'hfe, 8'hfb, 8'hfc, 8'hfc, 8'hfb, 8'hfb, 8'hf9, 8'h04, 8'hfc, 8'h04, 8'h03, 8'h05, 8'hff, 8'hfa, 8'h01, 8'h02, 8'h04, 8'h00, 8'hfa, 8'hfe, 8'h06, 8'h05, 8'h02, 8'hfc, 8'h02, 8'hfa, 8'hfd, 8'h06, 8'h01, 8'h00, 8'h04, 8'hff, 8'h05, 8'h05, 8'h01, 8'hfa, 8'h04, 8'h06, 8'h04, 8'h06, 8'hfa, 8'hfb, 8'hfe, 8'hfe, 8'hfe, 8'h00, 8'h06, 8'hff, 8'h05, 8'hfe, 8'hfa, 8'hfb, 8'h06, 8'h06, 8'h06, 8'hfd, 8'h02, 8'hf9, 8'h05, 8'h04, 8'h06, 8'hfe, 8'hfa, 8'h04, 8'h00, 8'hfc, 8'h05, 8'hfd, 8'hfe, 8'hfc, 8'hfe, 8'h04, 8'hff, 8'hf9, 8'h03, 8'hfe, 8'h04, 8'h04, 8'h00, 8'hfa, 8'h02, 8'hfe, 8'h01, 8'h01, 8'h01, 8'hfa, 8'h01, 8'h01, 8'h06, 8'h04, 8'hfb, 8'h00, 8'hfc, 8'h00, 8'hfc, 8'hfa, 8'h01, 8'h04, 8'h01, 8'hfc, 8'hff, 8'h03, 8'hfd, 8'h06, 8'h01, 8'hf9, 8'hfb, 8'h02, 8'h05, 8'h04, 8'hfe, 8'hff, 8'hfd, 8'hf9, 8'h01, 8'h02, 8'h06, 8'h02, 8'h00, 8'h03, 8'hfd, 8'h05, 8'hfb, 8'hfd, 8'h02, 8'hfe, 8'hf9, 8'h04, 8'h03, 8'hfa, 8'hfd, 8'h04, 8'h00, 8'h05, 8'hff, 8'h04, 8'h03, 8'hfc, 8'hfc, 8'hfa, 8'hfa, 8'hfb, 8'hff, 8'hf9, 8'hfd, 8'h01, 8'hfc, 8'h06, 8'h01, 8'h02, 8'h04, 8'h04, 8'hfc, 8'h04, 8'hfc, 8'hf9, 8'hfb, 8'h01, 8'hfd, 8'hfe, 8'h05, 8'hfd, 8'hfb, 8'hf9, 8'hfb, 8'h03, 8'hfb, 8'hfa, 8'h01, 8'h00, 8'h03, 8'hff, 8'hfe, 8'hf9, 8'hfe, 8'hff, 8'h01, 8'h04, 8'hf9, 8'hfb, 8'h02, 8'hfc, 8'h01, 8'h00, 8'h02, 8'h02, 8'hff, 8'h05, 8'hf9, 8'hfb, 8'hf9, 8'h06, 8'hf9, 8'hfd, 8'h03, 8'h03, 8'hfd, 8'h04, 8'hfb, 8'hfe, 8'hfa, 8'h06, 8'hfe, 8'h03, 8'hfd, 8'h03, 8'hfa, 8'h01, 8'hfa, 8'hfe, 8'h06, 8'hf9, 8'hfe, 8'hfb, 8'h06, 8'h03, 8'hfd, 8'h02, 8'hff, 8'hfa, 8'h05, 8'h03, 8'h01, 8'hfe, 8'h06, 8'hf9, 8'hfd, 8'h02, 8'hfb, 8'h01, 8'hfe, 8'hfd, 8'hfa, 8'h05, 8'h03, 8'h01, 8'hff, 8'h00, 8'h04, 8'h05, 8'hf9, 8'h00, 8'hfa, 8'h01, 8'hfd, 8'hfd, 8'hff, 8'h01, 8'h05, 8'hfc, 8'hf9, 8'h01, 8'h00, 8'hff, 8'hff, 8'h02, 8'hff, 8'h04, 8'hfd, 8'hfb, 8'h06, 8'hf9, 8'hf9, 8'h02, 8'h02, 8'hff, 8'hff, 8'h05, 8'h01, 8'h06, 8'h03, 8'h01, 8'h03, 8'h06, 8'h00, 8'h01, 8'h01, 8'h05, 8'hfd, 8'h05, 8'hfb, 8'hfd, 8'h00, 8'hf9, 8'h05, 8'h06, 8'hff, 8'hfe, 8'h00, 8'h03, 8'h02, 8'hfc, 8'h03, 8'h01, 8'h03, 8'hfd, 8'hfd, 8'hfe, 8'hff, 8'h06, 8'hfa, 8'hfa, 8'hfe, 8'hfc, 8'h04, 8'h05, 8'h02, 8'h01, 8'hfe, 8'hfe, 8'h06, 8'h05, 8'hfa, 8'hff, 8'hfc, 8'h01, 8'h02, 8'hfc, 8'h05, 8'h00, 8'hfb, 8'h06, 8'hfd, 8'h02, 8'h03, 8'hfa, 8'h05, 8'hfa, 8'hfd, 8'hfe, 8'hfe, 8'hff, 8'h06, 8'h03, 8'h06, 8'h04, 8'hf9, 8'h05, 8'hfc, 8'hfb, 8'h00, 8'hff, 8'hfd, 8'h01, 8'h06, 8'h03, 8'hfa, 8'h02, 8'h06, 8'h01, 8'h05, 8'hff, 8'h01, 8'h00, 8'h03, 8'h03, 8'h04, 8'hfd, 8'h04, 8'hff, 8'h01, 8'h05, 8'h05, 8'h03, 8'hfe, 8'h01, 8'h03, 8'h06, 8'h00, 8'h01, 8'h06, 8'hff, 8'hfb, 8'hff, 8'h04, 8'hff, 8'hfe, 8'h03, 8'hfc, 8'h00, 8'h02, 8'hfb, 8'hf9, 8'h01, 8'hfa, 8'hf9, 8'hfe, 8'hff, 8'h03, 8'h00, 8'h04, 8'h02, 8'hfe, 8'hfb, 8'hfc, 8'h02, 8'h06, 8'hfc, 8'hfe, 8'hfd, 8'hff, 8'h03, 8'hfd, 8'hff, 8'hfe, 8'hfe, 8'h03, 8'hfc, 8'hfd, 8'h00, 8'h05, 8'hfb, 8'hf9, 8'hff, 8'h03, 8'hfd, 8'hfd, 8'hfd, 8'h04, 8'hfa, 8'hff, 8'h04, 8'h03, 8'h06, 8'h04, 8'hfb, 8'hfb, 8'hfe, 8'hfd, 8'hfe, 8'hfc, 8'h01, 8'h00, 8'h06, 8'hfe, 8'h03, 8'hfb, 8'hfe, 8'h04, 8'hfa, 8'h02, 8'h01, 8'hff, 8'h04, 8'hfe, 8'hf9, 8'hfa, 8'h06, 8'hfd, 8'hff, 8'h04, 8'h04, 8'hfd, 8'hfa, 8'hfc, 8'h00, 8'h06, 8'h04, 8'hfc, 8'h04, 8'hfb, 8'hf9, 8'h04, 8'hfe, 8'hfd, 8'h03, 8'hf9, 8'hfc, 8'hfd, 8'hfe, 8'hfa, 8'hfb, 8'h04, 8'h01, 8'hff, 8'hfb, 8'h01, 8'h05, 8'hfd, 8'hfe, 8'hfd, 8'hff, 8'hff, 8'h00, 8'h00, 8'h04, 8'hfb, 8'h00, 8'hfc, 8'hfe, 8'h02, 8'h03, 8'hfb, 8'hfd, 8'h06, 8'h06, 8'h03, 8'h02, 8'hfb, 8'hf9, 8'hfe, 8'h04, 8'h04, 8'h05, 8'hfd, 8'h02, 8'hfc, 8'h02, 8'hfd, 8'h02, 8'hf9, 8'h06, 8'h05, 8'h04, 8'h06, 8'hf9, 8'hfd, 8'hfe, 8'hfc, 8'h05, 8'h05, 8'h06, 8'h05, 8'h06, 8'hfe, 8'hf9, 8'hff, 8'hfd, 8'hfe, 8'h05, 8'hfe, 8'h01, 8'hfa, 8'h06, 8'hfb, 8'h02, 8'hfd, 8'h04, 8'hfd, 8'h03, 8'hff, 8'hfc, 8'hf9, 8'hfc, 8'hfa, 8'hfd, 8'h02, 8'hfb, 8'h05, 8'hfd, 8'hfa, 8'h03, 8'hfc, 8'hfe, 8'h03, 8'hf9, 8'h02, 8'hff, 8'hff, 8'hfb, 8'hf9, 8'hfc, 8'hf9, 8'hfa, 8'h05, 8'h02, 8'hf9, 8'h06, 8'h04, 8'h01, 8'hfa, 8'hfa, 8'hfb, 8'hfb, 8'hfa, 8'hfb, 8'hf9, 8'hf9, 8'h03, 8'h01, 8'h02, 8'hfe, 8'h06, 8'hfe, 8'h02, 8'h00, 8'h00, 8'h04, 8'hfc, 8'hfe, 8'h03, 8'h06, 8'hfe, 8'h05, 8'h04, 8'h00, 8'h03, 8'h04, 8'h00, 8'h03, 8'hff, 8'hfa, 8'h05, 8'h00, 8'hf9, 8'h05, 8'h06, 8'hfd, 8'hfb, 8'h00, 8'hff, 8'h04, 8'hfe, 8'h02, 8'h00, 8'h06, 8'h01, 8'h05, 8'h02, 8'hfd, 8'h02, 8'h04, 8'hfc, 8'h03, 8'hfd, 8'h06, 8'h05, 8'hfa, 8'h04, 8'h05, 8'h02, 8'h05, 8'hff, 8'h04, 8'h02, 8'hfa, 8'h02, 8'hfe, 8'h02, 8'h03, 8'h05, 8'h06, 8'hfa, 8'hfa, 8'h01, 8'h00, 8'hf9, 8'h05, 8'hf9, 8'hfa, 8'hf9, 8'hff, 8'h04, 8'h01, 8'h01, 8'hfc, 8'h06, 8'hfa, 8'h00, 8'h02, 8'h01, 8'h03, 8'h04, 8'hfb, 8'hfd, 8'hfe, 8'h00, 8'h03, 8'hfc, 8'h05, 8'h05, 8'h01, 8'hfb, 8'h04, 8'h00, 8'hfd, 8'h03, 8'hfd, 8'h04, 8'h04, 8'hfd, 8'hfc, 8'hfc, 8'h03, 8'hfe, 8'h03, 8'h06, 8'h02, 8'h03, 8'h00, 8'hff, 8'hf9, 8'hf9, 8'hfd, 8'hfb, 8'hfc, 8'hfc, 8'hfa, 8'h04, 8'h06, 8'h04, 8'hfc, 8'h04, 8'h00, 8'hfe, 8'h03, 8'hfe, 8'hf9, 8'h04, 8'h04, 8'hf9, 8'h05, 8'hfe, 8'hfb, 8'hfe, 8'h02, 8'h05, 8'h06, 8'h00, 8'h01, 8'h01, 8'hfe, 8'h00, 8'hfa, 8'hfa, 8'h00, 8'h00, 8'hf9, 8'h02, 8'h02, 8'hfb, 8'hfc, 8'hf9, 8'h05, 8'h03, 8'hf9, 8'h02, 8'h05, 8'h04, 8'h06, 8'hf9, 8'h04, 8'hfa, 8'hff, 8'h04, 8'hfd, 8'h01, 8'h04, 8'hfa, 8'hfb, 8'h03, 8'h04, 8'h06, 8'hff, 8'hfa, 8'h00, 8'hfb, 8'h01, 8'hfc, 8'h01, 8'hfb, 8'h00, 8'h03, 8'hff, 8'h04, 8'hfc, 8'hfb, 8'hfa, 8'h00, 8'hfa, 8'h06, 8'h01, 8'hfa, 8'h06, 8'hfe, 8'h01, 8'h02, 8'h02, 8'hfe, 8'h01, 8'h00, 8'h06, 8'h05, 8'hfa, 8'h00, 8'hfe, 8'h02, 8'h00, 8'hfb, 8'hfb, 8'h01, 8'h04, 8'hfa, 8'h01, 8'hfd, 8'hff, 8'h00, 8'h00, 8'h00, 8'hff, 8'hfa, 8'h04, 8'h05, 8'hfb, 8'h02, 8'hfa, 8'h04, 8'hff, 8'hfb, 8'hf9, 8'h05, 8'h06, 8'h02, 8'hfd, 8'hfd, 8'hff, 8'hfe, 8'hff, 8'hfb, 8'h05, 8'hfc, 8'hfd, 8'h05, 8'hf9, 8'h01, 8'hfd, 8'h03, 8'h02, 8'h06, 8'h06, 8'h05, 8'h03, 8'hfd, 8'hfd, 8'h05, 8'h02, 8'hfc, 8'hfc, 8'hfe, 8'h06, 8'h03, 8'h03, 8'h01, 8'h00, 8'hfd, 8'hfc, 8'h05, 8'h01, 8'h04, 8'h00, 8'hfe, 8'h01, 8'h05, 8'h05, 8'h02, 8'h00, 8'h03, 8'h02, 8'hf9, 8'h06, 8'h00, 8'h05, 8'hfd, 8'h02, 8'h00, 8'hf9, 8'h00, 8'hfe, 8'hfb, 8'hff, 8'hf9, 8'h02, 8'h06, 8'h03, 8'hfb, 8'h05, 8'h06, 8'h00, 8'h02, 8'hfc, 8'h06, 8'hff, 8'h06, 8'hfa, 8'hfd, 8'h01, 8'h04, 8'hfc, 8'h06, 8'h04, 8'hf9, 8'hff, 8'h06, 8'h02, 8'hf9, 8'h01, 8'hff, 8'hf9, 8'h04, 8'hfe, 8'h05, 8'h06, 8'hfd, 8'hfc, 8'hfe, 8'h04, 8'hfb, 8'h03, 8'h00, 8'hfc, 8'hfa, 8'h04, 8'h06, 8'h06, 8'hfd, 8'h01, 8'h03, 8'hfc, 8'h02, 8'hff, 8'h06, 8'hfe, 8'h00, 8'h01, 8'hfd, 8'hfc, 8'h03, 8'hff, 8'hfc, 8'h06, 8'h01, 8'hff, 8'hff, 8'hfa, 8'h03, 8'hfe, 8'h06, 8'h04, 8'hfc, 8'hfd, 8'h01, 8'hfe, 8'hfe, 8'hfa, 8'h05, 8'h06, 8'hfe, 8'hfc, 8'h01, 8'hfc, 8'h06, 8'hfe, 8'h03, 8'h02, 8'hfc, 8'hff, 8'h05, 8'hfb, 8'h01, 8'h00, 8'hfb, 8'h04, 8'h06, 8'h01, 8'hfe, 8'h06, 8'h04, 8'hff, 8'h05, 8'h03, 8'hfc, 8'hfc, 8'h00, 8'h04, 8'h03, 8'h04, 8'hfa, 8'hfc, 8'h02, 8'hf9, 8'hfe, 8'h01, 8'hfa, 8'hfb, 8'h01, 8'hff, 8'hfb, 8'h06, 8'hfe, 8'hfd, 8'h01, 8'h06, 8'h02, 8'h04, 8'hfb, 8'hfe, 8'hf9, 8'hf9, 8'h04, 8'hfc, 8'h02, 8'hfe, 8'h06, 8'hfa, 8'h03, 8'hff, 8'h01, 8'h04, 8'hfe, 8'hfe, 8'h00, 8'hfc, 8'h00, 8'h06, 8'hfb, 8'hfa, 8'hfb, 8'h03, 8'hff, 8'hf9, 8'hfc, 8'h04, 8'h00, 8'hfc, 8'h01, 8'h06, 8'h03, 8'hfc, 8'h03, 8'hfd, 8'h02, 8'h06, 8'h02, 8'hfc, 8'hfd, 8'hfb, 8'hfa, 8'hfb, 8'hf9, 8'hfc, 8'h00, 8'hf9, 8'h05, 8'h06, 8'hfe, 8'hfe, 8'h00, 8'hf9, 8'h00, 8'h03, 8'hfa, 8'h01, 8'h02, 8'h02, 8'hf9, 8'hfd, 8'h05, 8'hfe, 8'h03, 8'hfa, 8'h05, 8'hfe, 8'hf9, 8'hfa, 8'hfb, 8'hfe, 8'h05, 8'h05, 8'h00, 8'hff, 8'hff, 8'hfb, 8'hfd, 8'hf9, 8'h01, 8'hfb, 8'h01, 8'hfc, 8'hf9, 8'hfe, 8'hfd, 8'h03, 8'hf9, 8'hfd, 8'h04, 8'hfe, 8'h02, 8'hf9, 8'h02, 8'h05, 8'hfb, 8'hff, 8'hf9, 8'h02, 8'hf9, 8'hfe, 8'h01, 8'hfb, 8'h04, 8'hff, 8'hfe, 8'h01, 8'hfd, 8'hfc, 8'h03, 8'hfa, 8'hfb, 8'hf9, 8'hff, 8'hfe, 8'hfb, 8'h00, 8'hfa, 8'h03, 8'h00, 8'h01, 8'h02, 8'hfd, 8'h01, 8'hf9, 8'h05, 8'h04, 8'h05, 8'hfd, 8'h03, 8'hfd, 8'h00, 8'hfb, 8'h06, 8'h00, 8'h03, 8'h04, 8'hff, 8'h03, 8'hfb, 8'hff, 8'hfd, 8'h05, 8'hff, 8'h02, 8'h00, 8'hfb, 8'hfb, 8'h03, 8'hfe, 8'h01, 8'h00, 8'hfb, 8'hf9, 
8'h06, 8'hfe, 8'hfa, 8'hfb, 8'hff, 8'hfc, 8'h06, 8'hfe, 8'h00, 8'h03, 8'h04, 8'hfe, 8'h02, 8'h02, 8'h04, 8'hfd, 8'h02, 8'h04, 8'h05, 8'hfc, 8'h05, 8'hfb, 8'hfd, 8'hfa, 8'hf9, 8'h06, 8'hfc, 8'hfd, 8'h02, 8'hfe, 8'hfd, 8'hfd, 8'hfc, 8'hfa, 8'hfd, 8'hfe, 8'h01, 8'hf9, 8'hfe, 8'hfb, 8'h02, 8'hfb, 8'h00, 8'hfe, 8'h06, 8'h00, 8'h03, 8'h06, 8'hfe, 8'h01, 8'hfc, 8'hfa, 8'h06, 8'hfe, 8'hf9, 8'h00, 8'hfb, 8'hfd, 8'hfa, 8'h03, 8'h06, 8'hf9, 8'h01, 8'h05, 8'h04, 8'hfb, 8'hff, 8'h01, 8'h04, 8'h05, 8'hfe, 8'h03, 8'h05, 8'h01, 8'h01, 8'h04, 8'h04, 8'h00, 8'h05, 8'h02, 8'h05, 8'hf9, 8'hfe, 8'h01, 8'hfd, 8'hfe, 8'hfb, 8'h01, 8'h01, 8'hf9, 8'hff, 8'hfe, 8'hfa, 8'hfd, 8'hfb, 8'hfa, 8'h06, 8'hfb, 8'h06, 8'hfa, 8'h00, 8'hfc, 8'hf9, 8'hfb, 8'h06, 8'hfd, 8'hf9, 8'hfd, 8'hfc, 8'hff, 8'h01, 8'hf9, 8'h02, 8'h01, 8'h02, 8'hf9, 8'hfc, 8'h04, 8'hfd, 8'hfc, 8'hfd, 8'h04, 8'h02, 8'h05, 8'hff, 8'hfe, 8'h00, 8'hf9, 8'hfa, 8'h00, 8'h06, 8'hff, 8'hff, 8'h03, 8'hfb, 8'hfe, 8'h06, 8'h03, 8'h04, 8'hfe, 8'hfe, 8'hfe, 8'hff, 8'hfa, 8'hfc, 8'hff, 8'h00, 8'h06, 8'h05, 8'h02, 8'h04, 8'hfd, 8'hfb, 8'hfd, 8'h05, 8'hfd, 8'hfc, 8'h04, 8'h04, 8'hf9, 8'h00, 8'hf9, 8'hff, 8'h01, 8'hfc, 8'h01, 8'h03, 8'hfd, 8'h02, 8'hfe, 8'h06, 8'h03, 8'hfe, 8'h03, 8'hfc, 8'hff, 8'hff, 8'hfd, 8'hff, 8'hfe, 8'h03, 8'h00, 8'hfa, 8'h03, 8'hfd, 8'h05, 8'h02, 8'hfb, 8'hfd, 8'h00, 8'hf9, 8'h04, 8'hfd, 8'h04, 8'hf9, 8'hfb, 8'h02, 8'h01, 8'hfb, 8'hfd, 8'hfc, 8'hfc, 8'h01, 8'hfa, 8'hf9, 8'h01, 8'hfc, 8'hfb, 8'hfa, 8'h06, 8'h00, 8'hff, 8'h06, 8'hfa, 8'h00, 8'h01, 8'h06, 8'hf9, 8'hf9, 8'h00, 8'h06, 8'hff, 8'h05, 8'hf9, 8'h04, 8'hfc, 8'h03, 8'h05, 8'h00, 8'hf9, 8'hfa, 8'h01, 8'h03, 8'h05, 8'h01, 8'h00, 8'hfc, 8'hfa, 8'hfe, 8'hfa, 8'h05, 8'h06, 8'h04, 8'h04, 8'hfe, 8'h06, 8'h02, 8'hfb, 8'h05, 8'h02, 8'hfd, 8'h01, 8'hfb, 8'h04, 8'hff, 8'hfb, 8'h00, 8'hfe, 8'h06, 8'hfe, 8'hfa, 8'hfb, 8'h05, 8'h04, 8'hff, 8'h06, 8'hfb, 8'h00, 8'h00, 8'h03, 8'hfe, 8'hfd, 8'h01, 8'h03, 8'h05, 8'hfd, 8'h05, 8'hfe, 8'h05, 8'hff, 8'hff, 8'h01, 8'hfa, 8'hfe, 8'h06, 8'hfd, 8'h04, 8'h03, 8'hff, 8'hff, 8'h02, 8'h00, 8'h03, 8'h06, 8'h04, 8'hfe, 8'h00, 8'hfb, 8'hfd, 8'h00, 8'h05, 8'hfa, 8'hfd, 8'hfb, 8'h05, 8'h04, 8'h04, 8'h03, 8'h02, 8'hff, 8'h06, 8'h02, 8'hfc, 8'h05, 8'h01, 8'hfe, 8'hff, 8'h01, 8'h05, 8'h04, 8'hff, 8'h02, 8'h02, 8'h00, 8'h03, 8'h04, 8'hfc, 8'hf9, 8'h06, 8'hf9, 8'h00, 8'hfc, 8'h00, 8'h03, 8'h01, 8'hf9, 8'h02, 8'h03, 8'hfd, 8'hfc, 8'hfb, 8'hff, 8'h06, 8'hfb, 8'h02, 8'h06, 8'hfc, 8'h00, 8'hfd, 8'h05, 8'hfc, 8'hfa, 8'hfc, 8'hfc, 8'h06, 8'hfa, 8'hfb, 8'h02, 8'h01, 8'h02, 8'hfc, 8'h06, 8'hfb, 8'h00, 8'hfd, 8'h04, 8'hfe, 8'h04, 8'h05, 8'hfe, 8'h05, 8'hfc, 8'h03, 8'hfc, 8'hfd, 8'h02, 8'hfb, 8'h02, 8'hfa, 8'hfb, 8'hff, 8'hfb, 8'hf9, 8'h03, 8'hfb, 8'h02, 8'h06, 8'hfb, 8'hff, 8'h04, 8'h02, 8'h06, 8'h04, 8'hfb, 8'h06, 8'h00, 8'h05, 8'h02, 8'hfe, 8'h01, 8'h03, 8'hfd, 8'h02, 8'h00, 8'hfb, 8'hfb, 8'hff, 8'h02, 8'hfc, 8'h00, 8'h03, 8'h00, 8'hfa, 8'h02, 8'h01, 8'h01, 8'hfc, 8'h03, 8'h03, 8'h03, 8'h04, 8'hff, 8'h06, 8'h05, 8'h00, 8'h00, 8'hff, 8'h01, 8'hff, 8'hfa, 8'h05, 8'hfa, 8'hf9, 8'hff, 8'hfd, 8'h03, 8'hfe, 8'hfe, 8'hfd, 8'hff, 8'h04, 8'h03, 8'h01, 8'hfd, 8'h03, 8'h02, 8'h01, 8'hfc, 8'hfc, 8'h04, 8'h03, 8'hfc, 8'h06, 8'hfa, 8'h06, 8'hfd, 8'hfe, 8'hfa, 8'hff, 8'hfb, 8'hfd, 8'h01, 8'hfd, 8'h00, 8'h03, 8'hfb, 8'h02, 8'h03, 8'h02, 8'h05, 8'h04, 8'h00, 8'hf9, 8'h00, 8'hfc, 8'hf9, 8'h04, 8'h02, 8'h00, 8'hff, 8'h04, 8'hfc, 8'hff, 8'hfe, 8'hfb, 8'hf9, 8'hf9, 8'h03, 8'h05, 8'h03, 8'hff, 8'h01, 8'hff, 8'hfa, 8'h06, 8'h01, 8'h06, 8'h05, 8'h05, 8'hff, 8'hfe, 8'hff, 8'h00, 8'h06, 8'hf9, 8'hff, 8'h02, 8'h00, 8'hfe, 8'h00, 8'hfb, 8'hfb, 8'hfc, 8'hfd, 8'hfe, 8'hff, 8'hfd, 8'h03, 8'hf9, 8'h05, 8'h00, 8'h03, 8'h05, 8'h05, 8'hff, 8'hf9, 8'hf9, 8'h05, 8'h02, 8'hfa, 8'h00, 8'h04, 8'h00, 8'hfb, 8'h00, 8'h02, 8'hfe, 8'hfc, 8'hff, 8'h05, 8'h00, 8'h02, 8'hfa, 8'h02, 8'h02, 8'h05, 8'hff, 8'h00, 8'h01, 8'h05, 8'h00, 8'hfb, 8'h02, 8'hff, 8'h05, 8'h03, 8'h02, 8'h04, 8'h02, 8'h05, 8'h00, 8'hfc, 8'h04, 8'hfb, 8'h03, 8'h04, 8'hfc, 8'h03, 8'h02, 8'hfb, 8'hfb, 8'h04, 8'h00, 8'hfb, 8'h01, 8'hf9, 8'h01, 8'h03, 8'hfe, 8'h00, 8'hfa, 8'h00, 8'h04, 8'h06, 8'h06, 8'h01, 8'h04, 8'h04, 8'hfd, 8'h05, 8'hfb, 8'hfd, 8'h05, 8'hfa, 8'hff, 8'hf9, 8'hfb, 8'h04, 8'hfc, 8'hf9, 8'hfd, 8'h04, 8'h04, 8'h06, 8'hfa, 8'hfa, 8'hf9, 8'h00, 8'h05, 8'h04, 8'hfc, 8'h05, 8'hfa, 8'hff, 8'h04, 8'hff, 8'h06, 8'h03, 8'hfa, 8'hfb, 8'h01, 8'hff, 8'hfd, 8'hfe, 8'h04, 8'h01, 8'h04, 8'h00, 8'hfc, 8'h02, 8'h03, 8'h01, 8'h04, 8'h03, 8'hfc, 8'h04, 8'hfe, 8'hfc, 8'h04, 8'hfa, 8'hff, 8'h05, 8'h03, 8'hfa, 8'h06, 8'h01, 8'hff, 8'hff, 8'hff, 8'h06, 8'hf9, 8'h01, 8'hfe, 8'hfd, 8'hff, 8'hfb, 8'h02, 8'h01, 8'h06, 8'hfb, 8'hfb, 8'h00, 8'h05, 8'hfa, 8'h00, 8'h05, 8'h06, 8'h03, 8'h06, 8'hfd, 8'hfb, 8'hf9, 8'hfe, 8'hff, 8'hfc, 8'h03, 8'hf9, 8'hf9, 8'h05, 8'h01, 8'h04, 8'hfd, 8'h01, 8'h00, 8'hfe, 8'h04, 8'hfa, 8'hfc, 8'h05, 8'h01, 8'hff, 8'h01, 8'h05, 8'h05, 8'h03, 8'h01, 8'hfa, 8'h01, 8'h02, 8'hf9, 8'h04, 8'h05, 8'h01, 8'hfc, 8'hfe, 8'hff, 8'h06, 8'h04, 8'h01, 8'hfc, 8'h00, 8'h01, 8'h01, 8'h03, 8'hf9, 8'hfc, 8'h06, 8'h05, 8'hfd, 8'h05, 8'h05, 8'h03, 8'hfa, 8'h02, 8'h03, 8'hfd, 8'h06, 8'h05, 8'h06, 8'hff, 8'h03, 8'h03, 8'hfd, 8'hfc, 8'h04, 8'h05, 8'hf9, 8'h02, 8'hfe, 8'h06, 8'hfb, 8'h00, 8'h05, 8'hfa, 8'hfa, 8'hfb, 8'hfa, 8'hfb, 8'hff, 8'hfa, 8'hfd, 8'h01, 8'hfd, 8'hfc, 8'h04, 8'h03, 8'h06, 8'h03, 8'h03, 8'hfd, 8'hff, 8'h03, 8'hff, 8'h03, 8'hfb, 8'hff, 8'h03, 8'h04, 8'hfa, 8'hfb, 8'h03, 8'hfe, 8'hfe, 8'h02, 8'h05, 8'hfa, 8'hfb, 8'hff, 8'h00, 8'h05, 8'hfd, 8'hff, 8'h06, 8'h03, 8'h04, 8'hfa, 8'h01, 8'hff, 8'hff, 8'h00, 8'hfb, 8'hfe, 8'h03, 8'h04, 8'hf9, 8'hf9, 8'h00, 8'h05, 8'h05, 8'h02, 8'h04, 8'hf9, 8'hfd, 8'hfd, 8'hff, 8'hfa, 8'h02, 8'h02, 8'h06, 8'hfe, 8'h06, 8'h03, 8'hff, 8'h03, 8'hfa, 8'hfc, 8'hfc, 8'h03, 8'h01, 8'hf9, 8'hfc, 8'hfb, 8'hfb, 8'h01, 8'h02, 8'hfe, 8'h04, 8'hfc, 8'h05, 8'h01, 8'h02, 8'hfa, 8'hfe, 8'h05, 8'hfb, 8'hfc, 8'h02, 8'h05, 8'h04, 8'h03, 8'h05, 8'hfe, 8'h02, 8'hfa, 8'h00, 8'h00, 8'hf9, 8'h05, 8'h04, 8'hff, 8'h06, 8'h06, 8'hfd, 8'hfb, 8'h05, 8'hff, 8'hfd, 8'hfa, 8'hff, 8'h00, 8'hfe, 8'hff, 8'hf9, 8'h00, 8'h00, 8'hfc, 8'hfa, 8'hfa, 8'h05, 8'hfa, 8'hff, 8'hff, 8'h03, 8'hfb, 8'hfb, 8'hfa, 8'hff, 8'h04, 8'h04, 8'h05, 8'hfb, 8'h03, 8'hfe, 8'hfa, 8'hff, 8'h00, 8'h06, 8'h04, 8'h03, 8'h05, 8'h06, 8'h02, 8'h01, 8'h05, 8'hf9, 8'h06, 8'h00, 8'h03, 8'h02, 8'hfd, 8'h01, 8'hfd, 8'hfd, 8'h05, 8'hfe, 8'h04, 8'hf9, 8'h00, 8'hfc, 8'h00, 8'hfc, 8'h05, 8'h05, 8'h02, 8'hfd, 8'h02, 8'h04, 8'h02, 8'h03, 8'hf9, 8'h05, 8'hfd, 8'h04, 8'h04, 8'h05, 8'hfc, 8'hfa, 8'h00, 8'hfb, 8'h02, 8'h00, 8'h01, 8'hfd, 8'hfe, 8'hfc, 8'hfa, 8'hfd, 8'h04, 8'hfc, 8'h01, 8'h03, 8'hfa, 8'hfe, 8'h00, 8'h01, 8'hfb, 8'h01, 8'h01, 8'hfe, 8'hf9, 8'h04, 8'h01, 8'h02, 8'hfe, 8'h03, 8'h06, 8'hf9, 8'h06, 8'hfc, 8'hfa, 8'hff, 8'h04, 8'hfd, 8'h01, 8'h00, 8'h02, 8'h00, 8'h01, 8'hfb, 8'h04, 8'h02, 8'hfd, 8'h02, 8'h06, 8'h03, 8'h04, 8'h05, 8'hfc, 8'hfd, 8'h01, 8'hfa, 8'h06, 8'h04, 8'hfa, 8'hfb, 8'h03, 8'h05, 8'hfa, 8'hfc, 8'hfb, 8'h02, 8'h01, 8'hfa, 8'hf9, 8'h06, 8'hfc, 8'hff, 8'h05, 8'h03, 8'h05, 8'hfd, 8'hfa, 8'h00, 8'hfa, 8'h03, 8'h03, 8'hfa, 8'h00, 8'hfd, 8'hfd, 8'h03, 8'h04, 8'h01, 8'h04, 8'hfd, 8'hff, 8'hff, 8'hfd, 8'hf9, 8'hfd, 8'h02, 8'h03, 8'h04, 8'hfb, 8'h05, 8'h06, 8'hfe, 8'h01, 8'hfb, 8'h06, 8'hfd, 8'h05, 8'hff, 8'hfc, 8'h06, 8'h02, 8'hfe, 8'hfa, 8'hfc, 8'hfa, 8'h04, 8'h01, 8'hfa, 8'hfe, 8'hfc, 8'hfd, 8'hfb, 8'hff, 8'hfa, 8'hfc, 8'hfc, 8'hf9, 8'h04, 8'hfa, 8'h00, 8'hfe, 8'hfd, 8'hfb, 8'h03, 8'hfb, 8'h05, 8'hfa, 8'h03, 8'hff, 8'hf9, 8'h03, 8'hf9, 8'hfe, 8'h05, 8'hfb, 8'h05, 8'hf9, 8'hff, 8'h06, 8'h00, 8'hfc, 8'hff, 8'h00, 8'h04, 8'h00, 8'hf9, 8'h01, 8'hfd, 8'hf9, 8'hfb, 8'h05, 8'hfc, 8'hff, 8'h06, 8'hfe, 8'h03, 8'h04, 8'hfe, 8'hfa, 8'h06, 8'h02, 8'hfe, 8'h02, 8'h00, 8'h01, 8'hfc, 8'hfa, 8'hfa, 8'h01, 8'h06, 8'hfa, 8'hfe, 8'hfa, 8'h05, 8'h06, 8'hfb, 8'h03, 8'hfc, 8'h03, 8'h05, 8'h04, 8'h04, 8'hfe, 8'h06, 8'h05, 8'h03, 8'hfc, 8'h02, 8'h05, 8'hfc, 8'hfa, 8'h01, 8'hfe, 8'h01, 8'hff, 8'h00, 8'h06, 8'hfc, 8'h01, 8'hf9, 8'h01, 8'hfc, 8'hfc, 8'hfd, 8'hf9, 8'hfa, 8'h06, 8'h04, 8'hfe, 8'hfd, 8'h00, 8'h04, 8'hfe, 8'h06, 8'h06, 8'hfc, 8'h05, 8'h01, 8'hfb, 8'hfb, 8'h06, 8'hfa, 8'hfd, 8'h05, 8'h06, 8'h02, 8'h05, 8'hfc, 8'h02, 8'hfa, 8'h01, 8'h03, 8'h01, 8'hfb, 8'h04, 8'h01, 8'h06, 8'hfa, 8'hfd, 8'hfe, 8'h00, 8'h06, 8'h05, 8'hfc, 8'h01, 8'hfe, 8'hfc, 8'h04, 8'h05, 8'hfd, 8'hff, 8'hfd, 8'h01, 8'hfb, 8'h06, 8'hfa, 8'hfa, 8'hf9, 8'h06, 8'h03, 8'h04, 8'h02, 8'h02, 8'h00, 8'h02, 8'h01, 8'h06, 8'h02, 8'h06, 8'hff, 8'hfc, 8'h03, 8'h04, 8'h01, 8'hfa, 8'hfa, 8'h01, 8'hfb, 8'h04, 8'h02, 8'hf9, 8'h02, 8'h04, 8'hf9, 8'h05, 8'hf9, 8'hfc, 8'h03, 8'h06, 8'hfd, 8'hfe, 8'h05, 8'h05, 8'h03, 8'hfb, 8'h02, 8'hfc, 8'h05, 8'h01, 8'hfd, 8'hfa, 8'h04, 8'h01, 8'hfe, 8'h05, 8'hfd, 8'hfd, 8'h01, 8'hfb, 8'hfd, 8'hfd, 8'h03, 8'hfc, 8'h06, 8'h01, 8'h02, 8'hff, 8'hfd, 8'hff, 8'h03, 8'hfa, 8'hff, 8'h04, 8'hfb, 8'h01, 8'h02, 8'h03, 8'hfe, 8'h04, 8'hf9, 8'hfb, 8'h03, 8'h02, 8'h06, 8'h05, 8'hfd, 8'h03, 8'hfa, 8'h06, 8'h00, 8'hfb, 8'h00, 8'h03, 8'h03, 8'hfb, 8'hfc, 8'hfb, 8'hff, 8'h06, 8'h04, 8'h02, 8'hfe, 8'h02, 8'h02, 8'hfc, 8'h06, 8'h06, 8'h05, 8'h01, 8'h00, 8'h06, 8'h03, 8'h01, 8'hfa, 8'h04, 8'h02, 8'hff, 8'h05, 8'h04, 8'hfb, 8'hfb, 8'hff, 8'h00, 8'h02, 8'h04, 8'h05, 8'hfb, 8'hfe, 8'hfd, 8'h01, 8'h04, 8'h05, 8'h00, 8'hfe, 8'h05, 8'h02, 8'h03, 8'h03, 8'h04, 8'hfa, 8'h02, 8'h01, 8'h06, 8'h05, 8'h02, 8'hfa, 8'h01, 8'hf9, 8'hf9, 8'h01, 8'h06, 8'h00, 8'h02, 8'h06, 8'hfb, 8'hfe, 8'h03, 8'hff, 8'h03, 8'hfe, 8'hfd, 8'h03, 8'hfa, 8'hfb, 8'h01, 8'hfb, 8'h03, 8'h01, 8'h05, 8'h02, 8'h01, 8'hfd, 8'h00, 8'h04, 8'h06, 8'hf9, 8'h05, 8'h01, 8'hff, 8'h02, 8'hfc, 8'h02, 8'hfa, 8'hfd, 8'hfe, 8'h05, 8'hff, 8'h02, 8'h06, 8'hf9, 8'hfb, 8'hfe, 8'h06, 8'hfb, 8'h06, 8'h01, 8'h03, 8'hfc, 8'hfe, 8'hfd, 8'hfb, 8'hf9, 8'h00, 8'hfd, 8'h02, 8'h06, 8'hfd, 8'hfa, 8'h04, 8'hf9, 8'hfa, 8'h01, 8'hfc, 8'h02, 8'h06, 8'hfb, 8'hfa, 8'h05, 8'h03, 8'h05, 8'h00, 8'hf9, 8'h04, 8'hfb, 8'hf9, 8'h06, 8'h03, 8'h02, 8'hf9, 8'h05, 8'h02, 8'h06, 8'hfa, 8'hfd, 8'hfc, 8'hff, 8'h04, 8'h01, 8'hfa, 8'h03, 8'h03, 8'h04, 
8'h00, 8'hfa, 8'h05, 8'h01, 8'h02, 8'hfb, 8'hfc, 8'h05, 8'hfd, 8'hfe, 8'h01, 8'hf9, 8'h03, 8'h01, 8'hfa, 8'hfd, 8'hfb, 8'h03, 8'h02, 8'h02, 8'h05, 8'h01, 8'h02, 8'h05, 8'h01, 8'hfa, 8'h05, 8'hfb, 8'h01, 8'h05, 8'h00, 8'h05, 8'h05, 8'hff, 8'hfb, 8'hfc, 8'hfa, 8'h00, 8'hfa, 8'hfb, 8'h02, 8'h04, 8'hfa, 8'hfd, 8'hfa, 8'hff, 8'hfa, 8'h06, 8'hfa, 8'hf9, 8'hfc, 8'h06, 8'h01, 8'hfe, 8'hfe, 8'h03, 8'h00, 8'hfa, 8'h04, 8'hfc, 8'hfa, 8'h02, 8'hfa, 8'h00, 8'h03, 8'h06, 8'h04, 8'hfb, 8'h02, 8'h05, 8'hff, 8'hfe, 8'h03, 8'hfd, 8'h01, 8'hf9, 8'hfe, 8'h05, 8'hfa, 8'h03, 8'hfb, 8'h06, 8'hfe, 8'hfe, 8'h03, 8'h06, 8'h04, 8'h00, 8'h03, 8'h01, 8'h00, 8'hfc, 8'hff, 8'hfe, 8'h06, 8'hfe, 8'h05, 8'hfa, 8'hfa, 8'h00, 8'hfd, 8'hfa, 8'h05, 8'hfa, 8'hfd, 8'h04, 8'h00, 8'h06, 8'hfa, 8'hfc, 8'h06, 8'hfa, 8'hfb, 8'h03, 8'h02, 8'hfe, 8'h05, 8'hfa, 8'h01, 8'hf9, 8'h04, 8'hff, 8'hf9, 8'hfb, 8'h03, 8'hfb, 8'h02, 8'hfc, 8'h02, 8'hfe, 8'hfd, 8'hfe, 8'hfd, 8'hfa, 8'hfa, 8'hfe, 8'hff, 8'h03, 8'h03, 8'h04, 8'h04, 8'hf9, 8'h00, 8'h04, 8'hfd, 8'h04, 8'hf9, 8'hf9, 8'hf9, 8'hfa, 8'hfc, 8'h03, 8'h00, 8'hfa, 8'h06, 8'h02, 8'h05, 8'h02, 8'hff, 8'h05, 8'hfc, 8'h04, 8'h03, 8'hfb, 8'hfb, 8'hfd, 8'h05, 8'hfe, 8'h06, 8'h06, 8'h00, 8'h01, 8'hfa, 8'h03, 8'h00, 8'h00, 8'hfe, 8'hff, 8'h02, 8'h00, 8'h05, 8'h03, 8'h00, 8'hfc, 8'hfd, 8'hfd, 8'h01, 8'h01, 8'h04, 8'hfb, 8'hfb, 8'h01, 8'h02, 8'hfa, 8'hfa, 8'hfe, 8'hfe, 8'hfc, 8'h00, 8'h02, 8'h04, 8'hfa, 8'hfd, 8'h06, 8'hfd, 8'h01, 8'hff, 8'hfd, 8'hfb, 8'h05, 8'hfe, 8'hfd, 8'hfe, 8'hfd, 8'hf9, 8'h00, 8'hfb, 8'hfb, 8'hfb, 8'hfa, 8'hfb, 8'hff, 8'hfa, 8'hfa, 8'h00, 8'h05, 8'h04, 8'h05, 8'h04, 8'h03, 8'h00, 8'hfc, 8'h05, 8'h02, 8'hfc, 8'hf9, 8'h02, 8'hfc, 8'hfb, 8'hf9, 8'h06, 8'h01, 8'hfd, 8'hff, 8'h05, 8'h00, 8'h01, 8'h05, 8'hfe, 8'hfc, 8'h06, 8'h03, 8'h06, 8'h04, 8'h02, 8'hfb, 8'hfa, 8'hfa, 8'h01, 8'hfc, 8'h06, 8'hf9, 8'h01, 8'hfe, 8'hfd, 8'h03, 8'h02, 8'hff, 8'hfc, 8'hfd, 8'h03, 8'hf9, 8'h02, 8'h00, 8'h00, 8'h06, 8'hfe, 8'hfb, 8'h06, 8'h02, 8'h05, 8'hfe, 8'h04, 8'hfc, 8'hfe, 8'hff, 8'hf9, 8'hff, 8'hfe, 8'hfe, 8'hf9, 8'hff, 8'h01, 8'h01, 8'h03, 8'hf9, 8'h04, 8'h04, 8'h04, 8'hfc, 8'hfe, 8'hfe, 8'h01, 8'h05, 8'h01, 8'h05, 8'h01, 8'h05, 8'hfa, 8'hfc, 8'hff, 8'h05, 8'hfe, 8'h04, 8'hfd, 8'h01, 8'h06, 8'h02, 8'hfe, 8'h01, 8'hfa, 8'hfc, 8'hfe, 8'h00, 8'h02, 8'hfc, 8'hf9, 8'hfe, 8'hff, 8'hff, 8'hff, 8'hfd, 8'hfe, 8'hfd, 8'h02, 8'h04, 8'hfa, 8'hf9, 8'hff, 8'h05, 8'hfa, 8'h02, 8'h02, 8'hfa, 8'h06, 8'hfd, 8'h04, 8'hff, 8'h06, 8'h05, 8'hff, 8'h06, 8'hfc, 8'hfd, 8'hf9, 8'h04, 8'h01, 8'h00, 8'hfc, 8'hfe, 8'h05, 8'hfa, 8'hfa, 8'hff, 8'h03, 8'h02, 8'hfe, 8'hfe, 8'h05, 8'hfd, 8'hfa, 8'h01, 8'h06, 8'hff, 8'h05, 8'h06, 8'h01, 8'h01, 8'hfa, 8'hfd, 8'hfe, 8'hfd, 8'h05, 8'h01, 8'hfa, 8'hff, 8'hfe, 8'hfa, 8'hf9, 8'hf9, 8'h02, 8'h02, 8'hfc, 8'hfd, 8'h02, 8'h00, 8'h06, 8'hfa, 8'h01, 8'h06, 8'hfa, 8'hfd, 8'h05, 8'h03, 8'h00, 8'hfc, 8'h06, 8'h04, 8'h05, 8'h04, 8'hfc, 8'hfd, 8'h00, 8'h05, 8'hfa, 8'hfa, 8'h01, 8'h05, 8'hfe, 8'h05, 8'h05, 8'h03, 8'hfe, 8'hfd, 8'h06, 8'h06, 8'h06, 8'h02, 8'h06, 8'h01, 8'h03, 8'hfc, 8'hfd, 8'hff, 8'hfc, 8'h05, 8'hf9, 8'h01, 8'h02, 8'hfb, 8'h04, 8'h00, 8'hfa, 8'h05, 8'h03, 8'hfc, 8'hfc, 8'h06, 8'hfa, 8'h04, 8'hf9, 8'hfe, 8'h00, 8'hfd, 8'h02, 8'h01, 8'hf9, 8'h05, 8'hfd, 8'h01, 8'hfa, 8'hfa, 8'h02, 8'hf9, 8'hff, 8'hff, 8'hfc, 8'h05, 8'hff, 8'h03, 8'hfc, 8'h00, 8'hfc, 8'h02, 8'hfe, 8'h03, 8'hff, 8'hfb, 8'hfb, 8'h03, 8'hfe, 8'h02, 8'h04, 8'hfe, 8'hfd, 8'hfe, 8'h04, 8'h06, 8'hfc, 8'h03, 8'hfb, 8'h00, 8'hfb, 8'hfd, 8'h04, 8'h06, 8'hfc, 8'h04, 8'h06, 8'h02, 8'h04, 8'h04, 8'hfb, 8'h01, 8'h02, 8'h01, 8'h00, 8'hfc, 8'h02, 8'hff, 8'hff, 8'hf9, 8'hfe, 8'hfe, 8'h03, 8'h06, 8'h02, 8'hfb, 8'h00, 8'h06, 8'h05, 8'hfc, 8'hf9, 8'hfc, 8'hfa, 8'h03, 8'hfb, 8'h04, 8'hfc, 8'hfa, 8'hff, 8'h01, 8'hfb, 8'hfd, 8'hfa, 8'hfc, 8'h04, 8'hfd, 8'h04, 8'h06, 8'hf9, 8'hfe, 8'h05, 8'h02, 8'hfe, 8'hf9, 8'hfe, 8'h05, 8'h04, 8'h01, 8'hfe, 8'h06, 8'hfd, 8'h03, 8'hff, 8'h03, 8'hfa, 8'h01, 8'hfe, 8'hfe, 8'h03, 8'h01, 8'h02, 8'hfa, 8'h01, 8'h04, 8'hfe, 8'hfa, 8'h04, 8'h04, 8'hfe, 8'hfe, 8'hfe, 8'h00, 8'h05, 8'h05, 8'hfc, 8'hfb, 8'h02, 8'h01, 8'hff, 8'h00, 8'h05, 8'h01, 8'hfe, 8'h06, 8'hfe, 8'h06, 8'hfa, 8'h05, 8'hfa, 8'hfe, 8'h04, 8'h01, 8'h02, 8'hf9, 8'hfe, 8'hf9, 8'h02, 8'h03, 8'h05, 8'hfe, 8'hff, 8'hfe, 8'hf9, 8'h01, 8'h05, 8'h05, 8'h03, 8'h05, 8'hfc, 8'h01, 8'hfd, 8'h03, 8'hfb, 8'h00, 8'hfb, 8'h04, 8'hfd, 8'hfc, 8'hfc, 8'hf9, 8'hfd, 8'hfb, 8'h00, 8'h01, 8'hf9, 8'h01, 8'h00, 8'h04, 8'hfa, 8'h04, 8'h06, 8'hf9, 8'hff, 8'h02, 8'hfc, 8'hfe, 8'hf9, 8'hfa, 8'hfc, 8'hfb, 8'h04, 8'h06, 8'hfa, 8'h04, 8'h05, 8'h00, 8'h06, 8'h06, 8'h05, 8'hfc, 8'h05, 8'h00, 8'hfb, 8'h05, 8'h00, 8'hfe, 8'h01, 8'h06, 8'hfe, 8'h03, 8'h00, 8'hfb, 8'hf9, 8'h02, 8'hfe, 8'h03, 8'hff, 8'h04, 8'h00, 8'h03, 8'hfb, 8'hfe, 8'hf9, 8'hfb, 8'hfd, 8'hfe, 8'hfb, 8'hfc, 8'hff, 8'hfe, 8'h02, 8'h06, 8'h04, 8'h00, 8'hfd, 8'h01, 8'hfc, 8'h04, 8'h02, 8'h05, 8'hfd, 8'hff, 8'h01, 8'h03, 8'h06, 8'h04, 8'h04, 8'hfd, 8'h03, 8'hfb, 8'h04, 8'hfe, 8'hfc, 8'hfb, 8'hfc, 8'h06, 8'h04, 8'h01, 8'hfc, 8'h00, 8'h06, 8'hfb, 8'hf9, 8'hfe, 8'hff, 8'hfc, 8'h00, 8'h06, 8'h04, 8'hfc, 8'h00, 8'hff, 8'hf9, 8'hfa, 8'h03, 8'h00, 8'h04, 8'hfb, 8'hfa, 8'h04, 8'h00, 8'h06, 8'hfc, 8'hfe, 8'h06, 8'hfe, 8'h06, 8'hff, 8'h00, 8'hfe, 8'h01, 8'hfc, 8'h04, 8'hfb, 8'h01, 8'h05, 8'h03, 8'hfe, 8'h05, 8'h05, 8'hfc, 8'h06, 8'h04, 8'h04, 8'h05, 8'h00, 8'hfd, 8'hff, 8'h06, 8'hf9, 8'h02, 8'hfe, 8'h04, 8'hfc, 8'hff, 8'h03, 8'hfe, 8'h04, 8'h04, 8'h03, 8'h06, 8'h02, 8'h02, 8'hff, 8'hfb, 8'hff, 8'h03, 8'hfc, 8'hfc, 8'hf9, 8'h03, 8'hff, 8'h03, 8'hfe, 8'hfe, 8'hfa, 8'hfa, 8'hf9, 8'h00, 8'hfe, 8'h00, 8'hfc, 8'hfd, 8'h01, 8'h02, 8'h00, 8'h01, 8'hfe, 8'hf9, 8'h06, 8'hf9, 8'hfb, 8'hfe, 8'h00, 8'hfc, 8'h05, 8'h06, 8'h06, 8'h02, 8'hff, 8'h02, 8'h03, 8'hff, 8'h03, 8'h05, 8'hfb, 8'hfe, 8'hf9, 8'hfd, 8'hf9, 8'h00, 8'h04, 8'hfa, 8'hfa, 8'hfa, 8'hfc, 8'h00, 8'hfd, 8'hfc, 8'hfb, 8'hfd, 8'h03, 8'h00, 8'hfa, 8'h01, 8'hfa, 8'hfe, 8'h06, 8'h06, 8'hff, 8'hf9, 8'hf9, 8'hf9, 8'h02, 8'hfc, 8'hfd, 8'hf9, 8'hff, 8'hfb, 8'hfe, 8'hf9, 8'hfe, 8'hff, 8'h06, 8'h04, 8'h01, 8'hfe, 8'hfa, 8'hfd, 8'h04, 8'hf9, 8'h00, 8'h01, 8'hfd, 8'hfe, 8'hfe, 8'h00, 8'h04, 8'h02, 8'h03, 8'h02, 8'hff, 8'h02, 8'h01, 8'h01, 8'hfa, 8'hff, 8'h06, 8'hff, 8'hfc, 8'hf9, 8'h06, 8'h04, 8'hfa, 8'h05, 8'h05, 8'h04, 8'hfb, 8'hfb, 8'hfd, 8'h05, 8'h03, 8'h04, 8'h00, 8'hfe, 8'h00, 8'h05, 8'h05, 8'hfc, 8'h05, 8'h06, 8'hff, 8'hf9, 8'h04, 8'hfe, 8'h04, 8'h06, 8'h06, 8'h04, 8'h03, 8'hfc, 8'h05, 8'hfd, 8'h00, 8'hfa, 8'h00, 8'hfb, 8'h00, 8'hfd, 8'h05, 8'h03, 8'hfe, 8'hfe, 8'h02, 8'hfa, 8'h05, 8'h06, 8'h03, 8'hfe, 8'h04, 8'hfd, 8'h00, 8'h02, 8'h00, 8'h06, 8'hfe, 8'hfd, 8'hfb, 8'h06, 8'hfb, 8'hff, 8'hf9, 8'hfc, 8'h05, 8'h03, 8'hfb, 8'hf9, 8'h06, 8'hfe, 8'hff, 8'hfd, 8'hfc, 8'hfa, 8'h02, 8'h05, 8'h06, 8'hf9, 8'h04, 8'hff, 8'h00, 8'hfb, 8'hfb, 8'h05, 8'hff, 8'h00, 8'hfc, 8'h06, 8'hfb, 8'hf9, 8'hfb, 8'hfc, 8'h05, 8'hfc, 8'h05, 8'h00, 8'h03, 8'hfc, 8'h06, 8'hfa, 8'h03, 8'h05, 8'h00, 8'hfb, 8'hf9, 8'h04, 8'h05, 8'hfd, 8'h06, 8'hfa, 8'hff, 8'hfd, 8'h02, 8'hf9, 8'h04, 8'hfb, 8'h01, 8'h06, 8'hf9, 8'h04, 8'h00, 8'h06, 8'h00, 8'h02, 8'hfc, 8'hff, 8'hfe, 8'h06, 8'hfe, 8'h05, 8'hfc, 8'hfa, 8'h03, 8'h02, 8'hfa, 8'h03, 8'h05, 8'h01, 8'hf9, 8'hf9, 8'hfb, 8'h02, 8'h04, 8'hff, 8'hfa, 8'hfb, 8'h02, 8'hfc, 8'h03, 8'hfa, 8'hff, 8'hfb, 8'hf9, 8'hfc, 8'h00, 8'hfc, 8'h01, 8'h02, 8'hfe, 8'h05, 8'hfa, 8'hfb, 8'h03, 8'h05, 8'hfd, 8'h03, 8'h06, 8'hf9, 8'h05, 8'hf9, 8'hf9, 8'hff, 8'hfd, 8'h01, 8'h01, 8'hfa, 8'h03, 8'h00, 8'hfe, 8'hfc, 8'hf9, 8'hff, 8'hfa, 8'hff, 8'hfd, 8'hf9, 8'h05, 8'hf9, 8'hfb, 8'h01, 8'hf9, 8'hfb, 8'hfd, 8'h02, 8'h05, 8'hff, 8'h03, 8'h00, 8'hfc, 8'h05, 8'h00, 8'h06, 8'h00, 8'hf9, 8'hf9, 8'hff, 8'h00, 8'hfb, 8'h01, 8'h03, 8'hfd, 8'hfc, 8'hf9, 8'h04, 8'hfd, 8'h03, 8'hfb, 8'hfd, 8'h05, 8'h04, 8'h06, 8'hfa, 8'hfd, 8'hfd, 8'hfd, 8'h05, 8'h05, 8'hfe, 8'h02, 8'hfa, 8'h03, 8'hfe, 8'hfd, 8'hf9, 8'hfe, 8'h02, 8'h03, 8'h04, 8'h01, 8'h04, 8'h01, 8'h03, 8'hfe, 8'h00, 8'h03, 8'h02, 8'h01, 8'hfc, 8'h03, 8'h01, 8'hfc, 8'h05, 8'h04, 8'h03, 8'hfc, 8'h00, 8'hfc, 8'h03, 8'h00, 8'hff, 8'h01, 8'h02, 8'hff, 8'h03, 8'h06, 8'h01, 8'hff, 8'hfe, 8'hfb, 8'h01, 8'h02, 8'hfe, 8'h01, 8'hfb, 8'hfd, 8'hfd, 8'h00, 8'h02, 8'h01, 8'hfc, 8'h06, 8'h02, 8'h01, 8'hfc, 8'hfd, 8'hfa, 8'h01, 8'hfa, 8'h03, 8'hf9, 8'h06, 8'h05, 8'h04, 8'hfe, 8'hfd, 8'h04, 8'h04, 8'h03, 8'h02, 8'hfe, 8'hfb, 8'hfc, 8'h03, 8'h01, 8'h01, 8'hfa, 8'hff, 8'hff, 8'hfa, 8'h04, 8'h05, 8'h01, 8'hfd, 8'hfe, 8'h05, 8'hf9, 8'hfd, 8'hff, 8'hfc, 8'h04, 8'h02, 8'hfa, 8'h04, 8'h02, 8'h01, 8'h02, 8'h06, 8'hfa, 8'hfc, 8'h06, 8'h01, 8'h00, 8'hfc, 8'hff, 8'h06, 8'hfb, 8'hfb, 8'hff, 8'hfb, 8'h00, 8'hfd, 8'h00, 8'hfe, 8'h06, 8'hfa, 8'h02, 8'hff, 8'h00, 8'hfe, 8'hfb, 8'h01, 8'h02, 8'hfd, 8'hfd, 8'hff, 8'hfe, 8'h04, 8'hfc, 8'hfd, 8'h01, 8'h05
 };
localparam [7:0] biases [0:63] = {
8'h04, 8'h00, 8'h05, 8'h06, 8'hff, 8'hfb, 8'h03, 8'h01, 8'hf9, 8'h02, 8'hf9, 8'h00, 8'h00, 8'hfe, 8'hfb, 8'hfa, 8'hfe, 8'hfa, 8'hf9, 8'hfb, 8'h02, 8'hf9, 8'hfe, 8'h00, 8'hff, 8'h02, 8'h04, 8'hff, 8'hf9, 8'h01, 8'hfe, 8'hfb, 8'hff, 8'hfe, 8'h00, 8'hfa, 8'h04, 8'h02, 8'h00, 8'h01, 8'hfb, 8'h03, 8'h05, 8'h02, 8'h06, 8'hff, 8'h02, 8'hfd, 8'hfa, 8'h04, 8'h03, 8'hfc, 8'h06, 8'hfa, 8'h02, 8'h03, 8'hfd, 8'hfb, 8'hfc, 8'h02, 8'h04, 8'h04, 8'h04, 8'h06 };

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
logic [7:0] curr_col = 0;
logic [7:0] prod[0:N_OUT-1][0:NUM_PARALLEL_COLS-1];
genvar r;
genvar c;
for (r = 0; r < N_OUT; r = r + 1) begin : mult_rows
    for (c = 0; c < NUM_PARALLEL_COLS; c = c + 1) begin : mult_cols
        assign prod[r][c] = mult(weights[(c+curr_col)*N_OUT + r], data_in[c+curr_col]);
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
    reduce_8_2cycles reduce (
        .clk(ap_clk),
        .in((prod[o][0:7])),
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
            REDUCING1: next_state = REDUCING1;
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
assign layer4_out_0_V = relu(acc[0]);
assign layer4_out_1_V = relu(acc[1]);
assign layer4_out_2_V = relu(acc[2]);
assign layer4_out_3_V = relu(acc[3]);
assign layer4_out_4_V = relu(acc[4]);
assign layer4_out_5_V = relu(acc[5]);
assign layer4_out_6_V = relu(acc[6]);
assign layer4_out_7_V = relu(acc[7]);
assign layer4_out_8_V = relu(acc[8]);
assign layer4_out_9_V = relu(acc[9]);
assign layer4_out_10_V = relu(acc[10]);
assign layer4_out_11_V = relu(acc[11]);
assign layer4_out_12_V = relu(acc[12]);
assign layer4_out_13_V = relu(acc[13]);
assign layer4_out_14_V = relu(acc[14]);
assign layer4_out_15_V = relu(acc[15]);
assign layer4_out_16_V = relu(acc[16]);
assign layer4_out_17_V = relu(acc[17]);
assign layer4_out_18_V = relu(acc[18]);
assign layer4_out_19_V = relu(acc[19]);
assign layer4_out_20_V = relu(acc[20]);
assign layer4_out_21_V = relu(acc[21]);
assign layer4_out_22_V = relu(acc[22]);
assign layer4_out_23_V = relu(acc[23]);
assign layer4_out_24_V = relu(acc[24]);
assign layer4_out_25_V = relu(acc[25]);
assign layer4_out_26_V = relu(acc[26]);
assign layer4_out_27_V = relu(acc[27]);
assign layer4_out_28_V = relu(acc[28]);
assign layer4_out_29_V = relu(acc[29]);
assign layer4_out_30_V = relu(acc[30]);
assign layer4_out_31_V = relu(acc[31]);
assign layer4_out_32_V = relu(acc[32]);
assign layer4_out_33_V = relu(acc[33]);
assign layer4_out_34_V = relu(acc[34]);
assign layer4_out_35_V = relu(acc[35]);
assign layer4_out_36_V = relu(acc[36]);
assign layer4_out_37_V = relu(acc[37]);
assign layer4_out_38_V = relu(acc[38]);
assign layer4_out_39_V = relu(acc[39]);
assign layer4_out_40_V = relu(acc[40]);
assign layer4_out_41_V = relu(acc[41]);
assign layer4_out_42_V = relu(acc[42]);
assign layer4_out_43_V = relu(acc[43]);
assign layer4_out_44_V = relu(acc[44]);
assign layer4_out_45_V = relu(acc[45]);
assign layer4_out_46_V = relu(acc[46]);
assign layer4_out_47_V = relu(acc[47]);
assign layer4_out_48_V = relu(acc[48]);
assign layer4_out_49_V = relu(acc[49]);
assign layer4_out_50_V = relu(acc[50]);
assign layer4_out_51_V = relu(acc[51]);
assign layer4_out_52_V = relu(acc[52]);
assign layer4_out_53_V = relu(acc[53]);
assign layer4_out_54_V = relu(acc[54]);
assign layer4_out_55_V = relu(acc[55]);
assign layer4_out_56_V = relu(acc[56]);
assign layer4_out_57_V = relu(acc[57]);
assign layer4_out_58_V = relu(acc[58]);
assign layer4_out_59_V = relu(acc[59]);
assign layer4_out_60_V = relu(acc[60]);
assign layer4_out_61_V = relu(acc[61]);
assign layer4_out_62_V = relu(acc[62]);
assign layer4_out_63_V = relu(acc[63]);

assign layer4_out_0_V_ap_vld = ap_done;
assign layer4_out_1_V_ap_vld = ap_done;
assign layer4_out_2_V_ap_vld = ap_done;
assign layer4_out_3_V_ap_vld = ap_done;
assign layer4_out_4_V_ap_vld = ap_done;
assign layer4_out_5_V_ap_vld = ap_done;
assign layer4_out_6_V_ap_vld = ap_done;
assign layer4_out_7_V_ap_vld = ap_done;
assign layer4_out_8_V_ap_vld = ap_done;
assign layer4_out_9_V_ap_vld = ap_done;
assign layer4_out_10_V_ap_vld = ap_done;
assign layer4_out_11_V_ap_vld = ap_done;
assign layer4_out_12_V_ap_vld = ap_done;
assign layer4_out_13_V_ap_vld = ap_done;
assign layer4_out_14_V_ap_vld = ap_done;
assign layer4_out_15_V_ap_vld = ap_done;
assign layer4_out_16_V_ap_vld = ap_done;
assign layer4_out_17_V_ap_vld = ap_done;
assign layer4_out_18_V_ap_vld = ap_done;
assign layer4_out_19_V_ap_vld = ap_done;
assign layer4_out_20_V_ap_vld = ap_done;
assign layer4_out_21_V_ap_vld = ap_done;
assign layer4_out_22_V_ap_vld = ap_done;
assign layer4_out_23_V_ap_vld = ap_done;
assign layer4_out_24_V_ap_vld = ap_done;
assign layer4_out_25_V_ap_vld = ap_done;
assign layer4_out_26_V_ap_vld = ap_done;
assign layer4_out_27_V_ap_vld = ap_done;
assign layer4_out_28_V_ap_vld = ap_done;
assign layer4_out_29_V_ap_vld = ap_done;
assign layer4_out_30_V_ap_vld = ap_done;
assign layer4_out_31_V_ap_vld = ap_done;
assign layer4_out_32_V_ap_vld = ap_done;
assign layer4_out_33_V_ap_vld = ap_done;
assign layer4_out_34_V_ap_vld = ap_done;
assign layer4_out_35_V_ap_vld = ap_done;
assign layer4_out_36_V_ap_vld = ap_done;
assign layer4_out_37_V_ap_vld = ap_done;
assign layer4_out_38_V_ap_vld = ap_done;
assign layer4_out_39_V_ap_vld = ap_done;
assign layer4_out_40_V_ap_vld = ap_done;
assign layer4_out_41_V_ap_vld = ap_done;
assign layer4_out_42_V_ap_vld = ap_done;
assign layer4_out_43_V_ap_vld = ap_done;
assign layer4_out_44_V_ap_vld = ap_done;
assign layer4_out_45_V_ap_vld = ap_done;
assign layer4_out_46_V_ap_vld = ap_done;
assign layer4_out_47_V_ap_vld = ap_done;
assign layer4_out_48_V_ap_vld = ap_done;
assign layer4_out_49_V_ap_vld = ap_done;
assign layer4_out_50_V_ap_vld = ap_done;
assign layer4_out_51_V_ap_vld = ap_done;
assign layer4_out_52_V_ap_vld = ap_done;
assign layer4_out_53_V_ap_vld = ap_done;
assign layer4_out_54_V_ap_vld = ap_done;
assign layer4_out_55_V_ap_vld = ap_done;
assign layer4_out_56_V_ap_vld = ap_done;
assign layer4_out_57_V_ap_vld = ap_done;
assign layer4_out_58_V_ap_vld = ap_done;
assign layer4_out_59_V_ap_vld = ap_done;
assign layer4_out_60_V_ap_vld = ap_done;
assign layer4_out_61_V_ap_vld = ap_done;
assign layer4_out_62_V_ap_vld = ap_done;
assign layer4_out_63_V_ap_vld = ap_done;

endmodule