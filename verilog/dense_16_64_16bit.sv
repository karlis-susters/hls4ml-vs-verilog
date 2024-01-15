`timescale 1 ns / 1 ps 

module reduce_2_1cycle (
    input clk,
    input signed [15:0] a,
    input signed [15:0] b,
    output signed [15:0] out
);
    logic signed [15:0] a_reg;
    logic signed [15:0] b_reg;
    always_ff @(posedge clk) begin
        a_reg <= a;
        b_reg <= b;
    end

    assign out = a_reg + b_reg;
endmodule

module reduce_8_3cycles (
    input clk,
    input rst,
    input signed [15:0] in [0:7],
    output signed [15:0] out
);
    logic signed [15:0] lvl1 [0:7];
    logic signed [15:0] lvl2 [0:1];
    always_ff @(posedge clk) begin
        if (rst) begin
            lvl1 <= '{default: '0};
        end
        lvl1 <= in;
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

module myproject (
        input ap_clk,
        input ap_rst,
        input ap_start,
        output ap_done,
        output ap_idle,
        output ap_ready,
        input dense_1_input_V_ap_vld,
        input [255:0] dense_1_input_V,
        output [15:0] ap_return_0,
        output [15:0] ap_return_1,
        output [15:0] ap_return_2,
        output [15:0] ap_return_3,
        output [15:0] ap_return_4,
        output [15:0] ap_return_5,
        output [15:0] ap_return_6,
        output [15:0] ap_return_7,
        output [15:0] ap_return_8,
        output [15:0] ap_return_9,
        output [15:0] ap_return_10,
        output [15:0] ap_return_11,
        output [15:0] ap_return_12,
        output [15:0] ap_return_13,
        output [15:0] ap_return_14,
        output [15:0] ap_return_15,
        output [15:0] ap_return_16,
        output [15:0] ap_return_17,
        output [15:0] ap_return_18,
        output [15:0] ap_return_19,
        output [15:0] ap_return_20,
        output [15:0] ap_return_21,
        output [15:0] ap_return_22,
        output [15:0] ap_return_23,
        output [15:0] ap_return_24,
        output [15:0] ap_return_25,
        output [15:0] ap_return_26,
        output [15:0] ap_return_27,
        output [15:0] ap_return_28,
        output [15:0] ap_return_29,
        output [15:0] ap_return_30,
        output [15:0] ap_return_31,
        output [15:0] ap_return_32,
        output [15:0] ap_return_33,
        output [15:0] ap_return_34,
        output [15:0] ap_return_35,
        output [15:0] ap_return_36,
        output [15:0] ap_return_37,
        output [15:0] ap_return_38,
        output [15:0] ap_return_39,
        output [15:0] ap_return_40,
        output [15:0] ap_return_41,
        output [15:0] ap_return_42,
        output [15:0] ap_return_43,
        output [15:0] ap_return_44,
        output [15:0] ap_return_45,
        output [15:0] ap_return_46,
        output [15:0] ap_return_47,
        output [15:0] ap_return_48,
        output [15:0] ap_return_49,
        output [15:0] ap_return_50,
        output [15:0] ap_return_51,
        output [15:0] ap_return_52,
        output [15:0] ap_return_53,
        output [15:0] ap_return_54,
        output [15:0] ap_return_55,
        output [15:0] ap_return_56,
        output [15:0] ap_return_57,
        output [15:0] ap_return_58,
        output [15:0] ap_return_59,
        output [15:0] ap_return_60,
        output [15:0] ap_return_61,
        output [15:0] ap_return_62,
        output [15:0] ap_return_63,
        output dense_1_input_V_blk_n
);

function automatic logic [15:0] mult(input logic [15:0] a, input logic [15:0] b);
    logic [31:0] res = $signed(a) * $signed(b);
    return res[25:10];
endfunction
    
function automatic logic [15:0] relu(input logic [15:0] a);
    return ($signed(a) > 0) ? a : 0;
endfunction
    
localparam N_IN = 16;
localparam N_OUT = 64;
localparam NUM_PARALLEL_COLS = 2;
localparam LAST_CURR_COL = 14;

localparam [15:0] weights [0:1023] = {
    16'h0034, 16'hffe6, 16'h0134, 16'hff98, 16'hff29, 16'h0025, 16'hff9f, 16'hff49, 16'h00c2, 16'h0016, 16'h0116, 16'h0083, 16'hffee, 16'h0175, 16'h004d, 16'h0015, 16'h015d, 16'hff67, 16'h019d, 16'hff62, 16'hfe64, 16'hff71, 16'hfef4, 16'h00bf, 16'h00be, 16'h0170, 16'hfe44, 16'hff00, 16'h017e, 16'h0140, 16'h0158, 16'hff79, 16'h0155, 16'h0070, 16'hff48, 16'hfee5, 16'hfea7, 16'hfead, 16'hfff8, 16'h0093, 16'h012d, 16'h0006, 16'hfffc, 16'hff10, 16'hfeba, 16'h00a9, 16'h00cb, 16'h0025, 16'h00b5, 16'h00f5, 16'h0098, 16'hff54, 16'hffb5, 16'h017f, 16'h017a, 16'h0113, 16'h0048, 16'h00f6, 16'h008b, 16'h0124, 16'h018e, 16'h002e, 16'h008d, 16'h019a, 16'h0006, 16'h01a9, 16'h0136, 16'h009e, 16'hff5a, 16'h0174, 16'hfe8d, 16'h00c4, 16'hfe48, 16'h004d, 16'hfee8, 16'hffdb, 16'h012d, 16'hfed5, 16'h0163, 16'hfe4c, 16'hff9b, 16'h001d, 16'hfe95, 16'h0195, 16'h00db, 16'hff90, 16'h0192, 16'h0126, 16'h00f6, 16'h00c4, 16'h0142, 16'hfe71, 16'h013d, 16'hfef5, 16'h00a1, 16'hfff1, 16'hfe4e, 16'h0124, 16'hff2e, 16'h00e1, 16'hff67, 16'h01ba, 16'h00ee, 16'h0002, 16'h0112, 16'hfff1, 16'hff0b, 16'h0054, 16'h0069, 16'h009c, 16'h004b, 16'h0160, 16'hff83, 16'h0061, 16'h0193, 16'h019b, 16'hffdb, 16'hff5e, 16'h0170, 16'h0105, 16'hffbd, 16'hfecf, 16'hff74, 16'hfef9, 16'hffb5, 16'hff3a, 16'hfe91, 16'h0072, 16'h0040, 16'h015a, 16'h0076, 16'hfea6, 16'h0081, 16'h018d, 16'h0091, 16'hffa8, 16'h002c, 16'hff12, 16'hff00, 16'hfecb, 16'h0058, 16'h0153, 16'h0106, 16'hff06, 16'hff92, 16'hfe97, 16'hff1e, 16'hfffd, 16'h0096, 16'h0056, 16'hfec3, 16'hff44, 16'h002e, 16'hfe56, 16'h017d, 16'h0109, 16'h01a2, 16'h00a2, 16'h00ff, 16'hff5a, 16'hfef5, 16'hfebb, 16'hfedc, 16'h013f, 16'h005a, 16'h00d6, 16'h0190, 16'hfea7, 16'hfed0, 16'hff51, 16'h007f, 16'h0076, 16'h011c, 16'hfe93, 16'h007b, 16'hfe61, 16'hfec0, 16'h0185, 16'hfe60, 16'hfebb, 16'hfec2, 16'hffa7, 16'h015c, 16'hff46, 16'hffff, 16'h00bf, 16'hfe53, 16'h006e, 16'h001c, 16'hff26, 16'hffb4, 16'hfef0, 16'hfea4, 16'hfee5, 16'h00c3, 16'hfee1, 16'h006d, 16'hff46, 16'h0090, 16'h0145, 16'hff9e, 16'h0161, 16'hfe48, 16'h0130, 16'hfe67, 16'h00ae, 16'h0198, 16'hfef5, 16'hffdf, 16'h0021, 16'hfff2, 16'h0191, 16'hffbd, 16'hfe86, 16'hff11, 16'hffbb, 16'hffa2, 16'hfe6c, 16'h0087, 16'hfe9a, 16'hffef, 16'h016d, 16'h007a, 16'h0066, 16'hffb8, 16'h0012, 16'hfeda, 16'hfeb8, 16'h00f9, 16'hff2d, 16'h01ad, 16'h009f, 16'hfedc, 16'h0115, 16'hffa4, 16'hff0d, 16'h0109, 16'h0096, 16'h0134, 16'h002a, 16'h00aa, 16'hfe9f, 16'hfefa, 16'h016a, 16'h0180, 16'h0052, 16'hff26, 16'hffbb, 16'hffd3, 16'h0066, 16'hfe99, 16'hffe8, 16'h00f5, 16'h0012, 16'hfe75, 16'hfee2, 16'h00c0, 16'h00f9, 16'h0071, 16'h0031, 16'hffec, 16'hff93, 16'h00b6, 16'h004e, 16'hff3f, 16'hffca, 16'h0151, 16'hfecc, 16'hff0d, 16'h0156, 16'h00f4, 16'hfff6, 16'h0054, 16'hffc1, 16'hff85, 16'hfe96, 16'hfff6, 16'hfe64, 16'hfe78, 16'h00ef, 16'h0148, 16'h0030, 16'h001d, 16'hfec5, 16'h018c, 16'h011d, 16'hff25, 16'h0080, 16'hfeca, 16'h0163, 16'h00ea, 16'hffd7, 16'hff61, 16'h016f, 16'hfe52, 16'hff4d, 16'hffc7, 16'hffcb, 16'hfe9a, 16'h00ad, 16'h0007, 16'hfecd, 16'h00d2, 16'h0054, 16'hfff6, 16'h000e, 16'h003f, 16'h0057, 16'h014d, 16'h0184, 16'hfecc, 16'h00fa, 16'h0032, 16'h0057, 16'h0059, 16'hffd9, 16'h018d, 16'h00d6, 16'h0090, 16'h00b7, 16'hff01, 16'h00fb, 16'h01a3, 16'h0144, 16'h003a, 16'hfedb, 16'hfe98, 16'h0081, 16'h0118, 16'h0148, 16'h0101, 16'hff8a, 16'h0004, 16'h01a6, 16'hff94, 16'h00bd, 16'hff64, 16'hfede, 16'h0097, 16'h01a4, 16'hfee5, 16'h00d6, 16'h001d, 16'hfe6c, 16'hff79, 16'h018c, 16'hff5f, 16'hff7f, 16'hffd1, 16'h0147, 16'h00da, 16'h011e, 16'h01ad, 16'h0150, 16'h0159, 16'h0099, 16'h00a3, 16'h0102, 16'hffc1, 16'h007e, 16'hfeab, 16'hffe4, 16'h00c4, 16'hfe7f, 16'hff39, 16'h0102, 16'hfff1, 16'h0056, 16'h0159, 16'hfefb, 16'hfeb4, 16'hfed6, 16'hfecd, 16'hfebd, 16'h0061, 16'hfeba, 16'hfe94, 16'h005f, 16'h013a, 16'hffcb, 16'h00a1, 16'h003f, 16'hfebd, 16'hfe82, 16'h00b8, 16'hff41, 16'hff24, 16'h0065, 16'hffc8, 16'h0083, 16'hfec7, 16'h00f7, 16'h0115, 16'h014c, 16'h00d6, 16'hff67, 16'h011b, 16'hffce, 16'hffeb, 16'hff02, 16'hfec3, 16'h0062, 16'hff15, 16'hfee8, 16'h0174, 16'hff8e, 16'hfe62, 16'hfee9, 16'hff5c, 16'hfe6b, 16'hfe47, 16'h0156, 16'h0101, 16'h0111, 16'hffe6, 16'hfe71, 16'hffff, 16'hff75, 16'hffb1, 16'h0137, 16'h0119, 16'h0095, 16'h007d, 16'hfe53, 16'hffd9, 16'hff22, 16'h00bf, 16'h00cf, 16'h0096, 16'hfffb, 16'hff2a, 16'h0058, 16'h0123, 16'hff2a, 16'hfff0, 16'hfe88, 16'hfec4, 16'hfe82, 16'hff73, 16'hff3f, 16'hff18, 16'hfe85, 16'hff96, 16'hfe6d, 16'hff0c, 16'h0006, 16'h006d, 16'h00cc, 16'hfe7c, 16'h0162, 16'h00d0, 16'h00d1, 16'hfe47, 16'h012c, 16'h00e7, 16'h00cb, 16'h00dd, 16'hfedd, 16'h0090, 16'hfebb, 16'h005f, 16'hff2b, 16'h008e, 16'h0167, 16'hfe4d, 16'hfefd, 16'hff32, 16'h0164, 16'h009a, 16'h00dd, 16'hfe4d, 16'h00e4, 16'h01a1, 16'hfe89, 16'hfff6, 16'h018e, 16'h0063, 16'h0088, 16'h0190, 16'h00e1, 16'hff3f, 16'h0082, 16'h00e6, 16'hff57, 16'h00e2, 16'h018a, 16'h016b, 16'h01b2, 16'hfef2, 16'h0179, 16'h0084, 16'hff55, 16'hff14, 16'hffb8, 16'hff3b, 16'hff0e, 16'h0135, 16'hffbf, 16'hfeed, 16'hff44, 16'hff9b, 16'hff66, 16'h010f, 16'h00ec, 16'h00eb, 16'hffb2, 16'h0148, 16'hff4f, 16'h01a6, 16'h01ae, 16'h007c, 16'h008c, 16'h005e, 16'hfe46, 16'h0010, 16'h009a, 16'h01a3, 16'h0069, 16'hff7f, 16'hfeb8, 16'h0151, 16'hff81, 16'h00f9, 16'h015a, 16'hfe81, 16'hfed1, 16'h0110, 16'h0103, 16'h00ef, 16'hfe6f, 16'h0022, 16'h011e, 16'hfe80, 16'hfed4, 16'hfee6, 16'hfe96, 16'hfe86, 16'h0160, 16'h01ac, 16'hfec7, 16'h0044, 16'h00e6, 16'hffa6, 16'h00a6, 16'hfffd, 16'hffca, 16'h0168, 16'h0173, 16'hff87, 16'hff98, 16'hff57, 16'hff09, 16'hff90, 16'hfeeb, 16'h006c, 16'hff34, 16'h00c3, 16'h0060, 16'h0147, 16'h01a4, 16'h0133, 16'h016a, 16'h006c, 16'hff36, 16'hff22, 16'hfea4, 16'h0041, 16'h0007, 16'h0185, 16'h0186, 16'h011d, 16'hffcc, 16'hfe9b, 16'hfec3, 16'hfe67, 16'h002e, 16'hfe89, 16'h00e4, 16'hfe80, 16'hfff5, 16'hff8e, 16'hfe87, 16'hff75, 16'hfe5b, 16'hfeb2, 16'hff10, 16'h0004, 16'h0150, 16'hfe4e, 16'h0144, 16'h0166, 16'h0040, 16'hff42, 16'hfe7e, 16'hff6e, 16'h0180, 16'h0081, 16'h0173, 16'hff65, 16'hffe9, 16'h0075, 16'hfe76, 16'h0111, 16'h0023, 16'h0128, 16'h00a1, 16'hfe60, 16'h00a2, 16'hfe86, 16'h0085, 16'h00ff, 16'h005a, 16'hff3f, 16'hfebe, 16'h002e, 16'h0120, 16'hff88, 16'hfef2, 16'hfee0, 16'h0106, 16'h0035, 16'hffbc, 16'hfffd, 16'h0090, 16'hffd2, 16'hfff4, 16'h0131, 16'hfe49, 16'h00db, 16'h0109, 16'hffdc, 16'hff39, 16'h003c, 16'hfffc, 16'hfe47, 16'hff90, 16'hffdd, 16'hff2a, 16'hfe54, 16'hffc0, 16'h0163, 16'hfeb7, 16'hfe5d, 16'hff3b, 16'hfe91, 16'hff65, 16'h0015, 16'h004f, 16'hffbc, 16'hffb2, 16'h008b, 16'hfe54, 16'h0030, 16'h016b, 16'hff7f, 16'hfef1, 16'hff80, 16'h0151, 16'hfec8, 16'hfe55, 16'h0122, 16'hfed4, 16'h016c, 16'h0163, 16'hff52, 16'hfeba, 16'hffaf, 16'h00d0, 16'h0066, 16'h00db, 16'h0160, 16'hff93, 16'hff81, 16'hff11, 16'h0168, 16'h017e, 16'h018c, 16'h0058, 16'hfff4, 16'h011d, 16'h008d, 16'hfed6, 16'h000a, 16'hffbe, 16'h001e, 16'hffcf, 16'hff7a, 16'h00ef, 16'h0118, 16'hfeae, 16'h018e, 16'h000e, 16'hfe5f, 16'h00f2, 16'h01a5, 16'h008f, 16'hff01, 16'hffbe, 16'hfff7, 16'hff05, 16'h00c3, 16'hfec7, 16'hfeed, 16'hfe68, 16'h008c, 16'hfe93, 16'hfe6e, 16'h0084, 16'hfed9, 16'hff63, 16'hff87, 16'hfec6, 16'h0055, 16'h006e, 16'hff8c, 16'h0034, 16'hff4c, 16'h00da, 16'h001d, 16'h01a6, 16'h008d, 16'hfe46, 16'hfeb4, 16'h0129, 16'hfed4, 16'hff4f, 16'h0121, 16'h018c, 16'hff46, 16'h0150, 16'h0143, 16'h0105, 16'h0004, 16'h0010, 16'h01b9, 16'hff2b, 16'h01aa, 16'hff9c, 16'hff81, 16'h0045, 16'hff61, 16'h008f, 16'h00c2, 16'hfeb9, 16'h0060, 16'hffed, 16'h00eb, 16'hfe9f, 16'hfea9, 16'hfeb9, 16'h01b9, 16'h0125, 16'hff2d, 16'h00b4, 16'h005f, 16'hfe88, 16'hfee3, 16'hfe4a, 16'h01a6, 16'hff6d, 16'hff33, 16'hff63, 16'h0184, 16'h0080, 16'h00c9, 16'h008e, 16'hffbe, 16'hff66, 16'h0012, 16'hff69, 16'hfeca, 16'hfe5b, 16'hff9f, 16'h018f, 16'h017a, 16'hff1f, 16'hfed3, 16'hfedb, 16'hfee0, 16'h0080, 16'hff59, 16'h016d, 16'hffef, 16'hff74, 16'hfec2, 16'h004a, 16'hfec2, 16'h0039, 16'hffef, 16'h015f, 16'hffd1, 16'h006c, 16'hfede, 16'h0156, 16'h0193, 16'hfe57, 16'hff06, 16'hfe98, 16'h0195, 16'hff1f, 16'h01a1, 16'hffff, 16'h0151, 16'hfeb3, 16'hfff2, 16'h01ba, 16'hff51, 16'hffa2, 16'h018e, 16'h00a5, 16'h008a, 16'hfe61, 16'h010b, 16'h0153, 16'hfebe, 16'hfe8f, 16'h0125, 16'h0117, 16'hff32, 16'hfe87, 16'h006a, 16'hfe62, 16'h00d3, 16'hfee1, 16'h0024, 16'hfe92, 16'h01b8, 16'h0015, 16'h0114, 16'hfe75, 16'h00be, 16'hffd5, 16'hfeda, 16'h0034, 16'h007f, 16'hff5e, 16'hff72, 16'h011c, 16'hff15, 16'h01aa, 16'h0117, 16'h00b2, 16'hff93, 16'hfef1, 16'hff8a, 16'hfe70, 16'hff64, 16'hffb8, 16'h0161, 16'hff4c, 16'h0042, 16'hffc4, 16'hff13, 16'hffd8, 16'h002e, 16'h0013, 16'hfff7, 16'hffd6, 16'hff98, 16'hffd2, 16'h01b1, 16'h0037, 16'h0074, 16'hfe80, 16'h012c, 16'h00eb, 16'hff8a, 16'h005e, 16'h006e, 16'hff5a, 16'hff01, 16'h000f, 16'h00fb, 16'h007e, 16'h0029, 16'h004d, 16'hfecd, 16'h01b7, 16'hfe56, 16'h0040, 16'h019e, 16'h0169, 16'hfe53, 16'h00b5, 16'hfff1, 16'hffa9, 16'h0180, 16'hfe54, 16'h0018, 16'hfe74, 16'h001d, 16'h009e, 16'h0004, 16'h008b, 16'h00c8, 16'hfec8, 16'h0027, 16'h01a8, 16'h00ef, 16'h0127, 16'h009b, 16'hff64, 16'h0171, 16'hff20, 16'h0195, 16'h011f, 16'h0186, 16'hfee5, 16'hffef, 16'h00b8, 16'hff16, 16'h00ba, 16'h00ab, 16'h014d, 16'hff3e, 16'hfe5e, 16'h0076, 16'hfe71, 16'h010b, 16'h0095, 16'h0062, 16'hff41, 16'h00eb, 16'h00c9, 16'hffb2, 16'hff59, 16'hff91, 16'hff2d, 16'hfe44, 16'hfe9f, 16'hff77, 16'h0141, 16'h00a9, 16'h0196, 16'h0027, 16'h003a, 16'hffad, 16'h01a0, 16'hfe67, 16'hff72, 16'hff84, 16'hffee, 16'hfffb, 16'h010a, 16'hfe7c, 16'hfe49, 16'hfe78, 16'hfedd, 16'hfea8, 16'h01a8, 16'hff68, 16'hff7c, 16'hfe49, 16'hffb8, 16'hfec7, 16'hfe7b, 16'h00d0, 16'h0146, 16'h004e, 16'hffb5, 16'hfef3, 16'h0078, 16'h018a, 16'h0064, 16'h0112, 16'hffc6, 16'h001c, 16'h014b, 16'h0052, 16'hffff, 16'h0047, 16'h0137, 16'hff7d, 16'h0160, 16'h0192, 16'h0182, 16'h00ec, 16'h0151, 16'hff40, 16'hfebf, 16'hfe5c, 16'hffcf, 16'hfe98, 16'hfeb2, 16'hff7b, 16'hff3d, 16'h0016, 16'h0130, 16'hffb1, 16'hff09, 16'hff8f, 16'h011b, 16'hfed8, 16'h003e, 16'h010a, 16'hffc9, 16'h005c, 16'hfe61, 
    16'hff77, 16'h004f, 16'h0155, 16'hfebe, 16'h0192, 16'h0148, 16'h00af, 16'hffa9, 16'h005a, 16'h0176, 16'hfee1, 16'hfe71, 16'hffd1, 16'hffec, 16'h00d2, 16'h00ab, 16'h0025, 16'hfee7, 16'hff0f, 16'h00f1, 16'h0128, 16'h0124, 16'hfe4f, 16'h006b, 16'hff33, 16'h015b 
    };
localparam [15:0] biases [0:63] = {
    16'hff4c, 16'h0093, 16'h0036, 16'hff8c, 16'hff60, 16'h004d, 16'h005a, 16'h00d0, 16'hffcc, 16'h009f, 16'h0026, 16'hff64, 16'h002c, 16'h0076, 16'h0042, 16'hffba, 16'h0040, 16'h009b, 16'hff97, 16'hff78, 16'hff4f, 16'h00c8, 16'h0010, 16'h002d, 16'h004a, 16'hff43, 16'hffa3, 16'h0055, 16'hff8e, 16'hff70, 16'hffb5, 16'hff5a, 16'hffd1, 16'hff2e, 16'h0096, 16'hff80, 16'h0066, 16'h0084, 16'h0090, 16'h0015, 16'h0071, 16'hff95, 16'hffb6, 16'h0007, 16'h005c, 16'hff94, 16'hff30, 16'h00db, 16'h003f, 16'hfff5, 16'hfffa, 16'hff39, 16'hff9b, 16'h0082, 16'h00ae, 16'hff6c, 16'hff6d, 16'hff72, 16'h00d3, 16'hff8a, 16'hffc9, 16'h008e, 16'h0096, 16'h00b0 
    };

logic [15:0] data_in [0:N_IN-1];
genvar i;
for (i = 0; i < N_IN; i = i + 1) begin : assign_input
    localparam j = (16*(i+1)) - 1;
    localparam k = 16*(i);
    assign data_in[i] = dense_1_input_V[j:k];
end

typedef enum logic [1:0] {
    IDLE,
    BUSY,
    REDUCING,
    DONE
  } StateType;

StateType current_state;
StateType next_state;

logic [15:0] acc [0:N_OUT-1];
logic [6:0] curr_col = 0;
logic [15:0] prod[0:N_OUT-1][0:NUM_PARALLEL_COLS-1];
genvar r;
genvar c;
for (r = 0; r < N_OUT; r = r + 1) begin : mult_rows
    for (c = 0; c < NUM_PARALLEL_COLS; c = c + 1) begin : mult_cols
        assign prod[r][c] = mult(weights[(c+curr_col)*N_OUT + r], data_in[c+curr_col]);
    end
end

logic reducer_out_valid;
always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
        reducer_out_valid <= 0;
    end
    else if (current_state == BUSY) begin
        reducer_out_valid <= 1;
    end
    else begin
        reducer_out_valid <= 0;
    end
end

logic [15:0] reduced [0:N_OUT-1];
genvar o;
for (o = 0; o < N_OUT; o = o + 1) begin : assign_acc
    reduce_2_1cycle reduce (
        .clk(ap_clk),
        .a(prod[o][0]),
        .b(prod[o][1]),
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
            BUSY: next_state = (curr_col == LAST_CURR_COL) ? REDUCING : BUSY;
            REDUCING: next_state = DONE;
            DONE: next_state = IDLE;
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
assign ap_return_16 = relu(acc[16]);
assign ap_return_17 = relu(acc[17]);
assign ap_return_18 = relu(acc[18]);
assign ap_return_19 = relu(acc[19]);
assign ap_return_20 = relu(acc[20]);
assign ap_return_21 = relu(acc[21]);
assign ap_return_22 = relu(acc[22]);
assign ap_return_23 = relu(acc[23]);
assign ap_return_24 = relu(acc[24]);
assign ap_return_25 = relu(acc[25]);
assign ap_return_26 = relu(acc[26]);
assign ap_return_27 = relu(acc[27]);
assign ap_return_28 = relu(acc[28]);
assign ap_return_29 = relu(acc[29]);
assign ap_return_30 = relu(acc[30]);
assign ap_return_31 = relu(acc[31]);
assign ap_return_32 = relu(acc[32]);
assign ap_return_33 = relu(acc[33]);
assign ap_return_34 = relu(acc[34]);
assign ap_return_35 = relu(acc[35]);
assign ap_return_36 = relu(acc[36]);
assign ap_return_37 = relu(acc[37]);
assign ap_return_38 = relu(acc[38]);
assign ap_return_39 = relu(acc[39]);
assign ap_return_40 = relu(acc[40]);
assign ap_return_41 = relu(acc[41]);
assign ap_return_42 = relu(acc[42]);
assign ap_return_43 = relu(acc[43]);
assign ap_return_44 = relu(acc[44]);
assign ap_return_45 = relu(acc[45]);
assign ap_return_46 = relu(acc[46]);
assign ap_return_47 = relu(acc[47]);
assign ap_return_48 = relu(acc[48]);
assign ap_return_49 = relu(acc[49]);
assign ap_return_50 = relu(acc[50]);
assign ap_return_51 = relu(acc[51]);
assign ap_return_52 = relu(acc[52]);
assign ap_return_53 = relu(acc[53]);
assign ap_return_54 = relu(acc[54]);
assign ap_return_55 = relu(acc[55]);
assign ap_return_56 = relu(acc[56]);
assign ap_return_57 = relu(acc[57]);
assign ap_return_58 = relu(acc[58]);
assign ap_return_59 = relu(acc[59]);
assign ap_return_60 = relu(acc[60]);
assign ap_return_61 = relu(acc[61]);
assign ap_return_62 = relu(acc[62]);
assign ap_return_63 = relu(acc[63]);
assign dense_1_input_V_blk_n = 1;

endmodule