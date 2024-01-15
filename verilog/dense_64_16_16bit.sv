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

module reduce_8_2cycles (
    input clk,
    input rst,
    input [15:0] in [0:7],
    output [15:0] out
);
    logic [15:0] lvl1 [0:7];
    logic [15:0] lvl2 [0:1];
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

module myproject (
        input ap_clk,
        input ap_rst,
        input ap_start,
        output ap_done,
        output ap_idle,
        output ap_ready,
        input dense_1_input_V_ap_vld,
        input [1023:0] dense_1_input_V,
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
        output dense_1_input_V_blk_n
);

function automatic logic [15:0] mult(input logic [15:0] a, input logic [15:0] b);
    logic [31:0] res = $signed(a) * $signed(b);
    return res[25:10];
endfunction
    
function automatic logic [15:0] relu(input logic [15:0] a);
    return ($signed(a) > 0) ? a : 0;
endfunction
    
localparam N_IN = 64;
localparam N_OUT = 16;
localparam NUM_PARALLEL_COLS = 8;
localparam LAST_CURR_COL = 56;

localparam [15:0] weights [0:1023] = {
    16'h009c, 16'hff7b, 16'h0010, 16'hff24, 16'hff8b, 16'hffff, 16'hff29, 16'h00ad, 16'h0035, 16'h00c4, 16'h0051, 16'h00c9, 16'hff51, 16'hffbc, 16'h007b, 16'h0037, 16'h006c, 16'h0089, 16'hfff5, 16'hff7c, 16'h0084, 16'h00b6, 16'hffee, 16'h00a6, 16'hff6e, 16'h0091, 16'h0096, 16'h0070, 16'h004d, 16'h0033, 16'hffd8, 16'h00d7, 16'hff4e, 16'h0057, 16'h0071, 16'h0094, 16'hff39, 16'h0057, 16'h008b, 16'h005c, 16'hffd2, 16'h0032, 16'h0079, 16'h00c1, 16'h0062, 16'h007e, 16'h00ab, 16'hff9e, 16'h00ae, 16'h00d2, 16'hff72, 16'hff97, 16'hff8a, 16'hff81, 16'h00d4, 16'hffe1, 16'h0090, 16'h0038, 16'h00d0, 16'h0063, 16'hff8e, 16'hff78, 16'hffec, 16'hff8f, 16'hffab, 16'hffe6, 16'hff99, 16'hff39, 16'hffb1, 16'hffdf, 16'h00d5, 16'hff31, 16'h009c, 16'h00a5, 16'hff7c, 16'h00cf, 16'hffc4, 16'hffd8, 16'h00b5, 16'hff59, 16'hffc2, 16'hffe1, 16'hffb0, 16'h0015, 16'hfff4, 16'h0041, 16'hffc0, 16'h00b4, 16'hffb5, 16'hffb2, 16'h000b, 16'hffe1, 16'hffcb, 16'h0060, 16'h0081, 16'hffd6, 16'h009e, 16'hffce, 16'hffdf, 16'hff80, 16'hff63, 16'h00c2, 16'hffa2, 16'hffc1, 16'h0027, 16'h0077, 16'h0000, 16'h004f, 16'h00da, 16'hffaf, 16'h00ca, 16'hffa1, 16'hff59, 16'h00cf, 16'hffce, 16'hffd2, 16'hfffe, 16'hfff4, 16'h005d, 16'hff53, 16'hffdd, 16'hff32, 16'h00a5, 16'h00b3, 16'hff39, 16'hffb5, 16'hff5f, 16'hff8a, 16'h008b, 16'hfff5, 16'h009b, 16'hffb4, 16'hff46, 16'hff4e, 16'hff2f, 16'h00ad, 16'h00c6, 16'h0018, 16'h00a6, 16'h00a3, 16'hff77, 16'hff88, 16'hffd3, 16'h0060, 16'hff83, 16'hff27, 16'hffbd, 16'h003e, 16'hff8f, 16'hfff2, 16'hff25, 16'h0070, 16'hff8e, 16'h0061, 16'h0094, 16'h0030, 16'hffdf, 16'h001f, 16'h0080, 16'hff64, 16'h00d7, 16'hff9c, 16'hffc1, 16'hff8a, 16'h006b, 16'h000a, 16'hfff3, 16'hff24, 16'hff5c, 16'hff72, 16'h0051, 16'h0033, 16'h0085, 16'h009a, 16'h00b2, 16'h008f, 16'h0007, 16'h00dc, 16'hff50, 16'h00c9, 16'hff81, 16'hfff6, 16'hffe6, 16'h00b6, 16'h0056, 16'hffe2, 16'hff4c, 16'hfffb, 16'h0035, 16'hffc4, 16'h0008, 16'hffe9, 16'h009e, 16'hffd8, 16'h0036, 16'hff8b, 16'h00a0, 16'h005c, 16'hff3f, 16'h000c, 16'hff74, 16'hff41, 16'hfff9, 16'hff6a, 16'h0010, 16'h009c, 16'h003f, 16'h00a5, 16'h0071, 16'hff60, 16'h000f, 16'h00ba, 16'h009a, 16'hffb3, 16'h00d6, 16'hff6e, 16'h00d3, 16'hff72, 16'h000d, 16'h0088, 16'hff35, 16'h0039, 16'h0048, 16'h0050, 16'hff9b, 16'h0033, 16'hfff3, 16'hffeb, 16'hff38, 16'hffd9, 16'h004c, 16'h00ae, 16'hffff, 16'hff87, 16'hff86, 16'hff4d, 16'hff3a, 16'h00af, 16'h0047, 16'h0033, 16'hffa9, 16'h002f, 16'h00af, 16'h00c8, 16'hffa4, 16'hff92, 16'hff47, 16'h00d9, 16'h0086, 16'h0092, 16'h0049, 16'hff98, 16'h00c1, 16'hfff4, 16'h006e, 16'h007a, 16'h0095, 16'hff4f, 16'hff59, 16'h00b0, 16'hfff3, 16'hff9d, 16'hff32, 16'h00c1, 16'h005d, 16'hff37, 16'hffd1, 16'hff59, 16'hffed, 16'h0016, 16'hff42, 16'h0006, 16'h0002, 16'hff76, 16'h001e, 16'h007d, 16'hff6f, 16'h00bc, 16'hff97, 16'hff37, 16'h007a, 16'h0015, 16'h00a1, 16'h0081, 16'h0001, 16'h0022, 16'hffcd, 16'hffc1, 16'hff54, 16'h0077, 16'hffa5, 16'h00c6, 16'hffcc, 16'h00aa, 16'hffbc, 16'hff25, 16'h00dc, 16'hff48, 16'hff75, 16'hffe6, 16'hff73, 16'h0078, 16'h003e, 16'h00a1, 16'h00cf, 16'h001d, 16'hff63, 16'h00c4, 16'hffbc, 16'h009b, 16'hff68, 16'hffc2, 16'hff30, 16'hff77, 16'hff97, 16'h0022, 16'h005a, 16'hffba, 16'hffb3, 16'h000c, 16'h00a1, 16'hff3a, 16'h0061, 16'h00c7, 16'h0071, 16'hff5e, 16'hff83, 16'h00b1, 16'h00c0, 16'hff96, 16'hff4f, 16'h00c2, 16'hffe2, 16'hffed, 16'h0053, 16'hff81, 16'hff45, 16'hff8f, 16'h0016, 16'hff94, 16'hfff1, 16'h0014, 16'hff6a, 16'hff88, 16'hffc1, 16'hffc5, 16'h0078, 16'hffff, 16'h00c8, 16'hffc8, 16'h00d5, 16'hff2e, 16'hff2c, 16'h000e, 16'hffcd, 16'h0069, 16'hff70, 16'h0069, 16'h00cd, 16'h00d9, 16'hffd5, 16'h0027, 16'hfff1, 16'hffdb, 16'h00c3, 16'h00a9, 16'hffe0, 16'h00cb, 16'hfff9, 16'hff2f, 16'h00a3, 16'hffb8, 16'h0077, 16'h0073, 16'h00bc, 16'h0032, 16'hff47, 16'h0092, 16'hffaa, 16'h009c, 16'h00b4, 16'h0063, 16'h0079, 16'h0099, 16'h00ca, 16'h008b, 16'h00ad, 16'hff30, 16'hff8a, 16'h003a, 16'hffcc, 16'hffcd, 16'hfff2, 16'h003c, 16'h008b, 16'h00b9, 16'hff75, 16'h0013, 16'h00d8, 16'hff58, 16'hffca, 16'h00a6, 16'h0096, 16'hfff9, 16'h0056, 16'h000e, 16'h0087, 16'h00d1, 16'hff79, 16'h005f, 16'h00ab, 16'h007b, 16'h0018, 16'h00ae, 16'h00c2, 16'h00a8, 16'h0003, 16'h00bf, 16'hffb9, 16'hff97, 16'hff59, 16'h00d9, 16'hffb9, 16'h009d, 16'h00b5, 16'h0001, 16'hff54, 16'hff43, 16'hfff8, 16'hff48, 16'hff99, 16'hfff5, 16'hffde, 16'hffdb, 16'hffcf, 16'h0013, 16'hff28, 16'hff92, 16'hff24, 16'hffbe, 16'hffa2, 16'h00bb, 16'h0052, 16'h00a7, 16'h0047, 16'h00b7, 16'h009e, 16'h0013, 16'h0030, 16'h0004, 16'hff5a, 16'hffe9, 16'hfff1, 16'hffd5, 16'h0011, 16'h0097, 16'h00dc, 16'hff99, 16'hff4c, 16'h0090, 16'hffd1, 16'h008c, 16'h009b, 16'hff37, 16'h0064, 16'hff9d, 16'hffd8, 16'h00a9, 16'hff25, 16'h0059, 16'hff7d, 16'h0024, 16'hffb8, 16'hffbc, 16'h0001, 16'h006e, 16'h0056, 16'hffff, 16'h00b8, 16'h000b, 16'h00bb, 16'hffd3, 16'h0013, 16'h00d5, 16'h00b6, 16'h00d1, 16'hff88, 16'h007f, 16'hffd0, 16'h000e, 16'h003a, 16'h0054, 16'h0090, 16'hff5d, 16'hffcc, 16'h00d6, 16'h0053, 16'hff93, 16'hff90, 16'hff9b, 16'hfff7, 16'hffb0, 16'h003e, 16'hff80, 16'hffe4, 16'h0062, 16'hff5f, 16'hffbb, 16'h00af, 16'hffaf, 16'h0092, 16'hff6c, 16'h00b2, 16'h0005, 16'h009d, 16'h0073, 16'h0084, 16'h00d4, 16'hff2e, 16'hff9f, 16'h0041, 16'hff3b, 16'hff27, 16'hffea, 16'h00b3, 16'hff4e, 16'hff28, 16'hff69, 16'hff4c, 16'h00a0, 16'hffd7, 16'hffd3, 16'h001b, 16'hfff4, 16'hff40, 16'hffd9, 16'h000a, 16'h00ba, 16'h0060, 16'hff6a, 16'h0095, 16'h0077, 16'hffbb, 16'h0048, 16'h006a, 16'h003c, 16'h0099, 16'hff50, 16'h0050, 16'h0025, 16'hff51, 16'hff52, 16'h00b5, 16'h0014, 16'hffd7, 16'h0098, 16'hff60, 16'h002f, 16'h0087, 16'h00cf, 16'hffdd, 16'h0075, 16'hff8d, 16'h00bd, 16'hff4d, 16'hff9d, 16'hffda, 16'h00c1, 16'hfffb, 16'hffd3, 16'h007a, 16'hff3d, 16'h00c0, 16'h001e, 16'hff79, 16'h0040, 16'h0051, 16'h003b, 16'hffd0, 16'hff2a, 16'h009d, 16'h0074, 16'hff8f, 16'h00c1, 16'hff69, 16'h0052, 16'h009c, 16'h00cf, 16'hff85, 16'h001f, 16'hff6b, 16'hff65, 16'hff24, 16'hff28, 16'hff23, 16'h0076, 16'h0086, 16'hff9c, 16'h009b, 16'hff30, 16'hfffc, 16'hffcf, 16'h00bc, 16'h00cd, 16'hff92, 16'h0016, 16'hffbc, 16'hffb1, 16'hff4d, 16'hff98, 16'h0030, 16'hffa7, 16'hff95, 16'hffef, 16'hffea, 16'hff8c, 16'h00c5, 16'hffe0, 16'h0002, 16'hffa2, 16'h0013, 16'h00c7, 16'h00c7, 16'h00c4, 16'h0035, 16'hffe8, 16'hfff6, 16'h0054, 16'h007d, 16'h00b7, 16'h00c9, 16'h007d, 16'hff40, 16'h00cb, 16'hffd9, 16'h00c1, 16'hffa1, 16'h0061, 16'h00c4, 16'h00b6, 16'hffaa, 16'hff71, 16'h00b1, 16'hff38, 16'h0076, 16'hff22, 16'h009a, 16'hff37, 16'h0081, 16'hffe7, 16'hffeb, 16'hff94, 16'hff25, 16'hff2c, 16'h0031, 16'hff86, 16'hffce, 16'hfff9, 16'h0006, 16'hfffc, 16'hffeb, 16'hff81, 16'hff3d, 16'h00c9, 16'hff27, 16'hff9a, 16'h0032, 16'h005b, 16'hffba, 16'hffe7, 16'hff8e, 16'hffc1, 16'h0000, 16'hff57, 16'hff97, 16'hffea, 16'h00c6, 16'h0017, 16'h0096, 16'hff57, 16'h0086, 16'hff24, 16'h0078, 16'hffbc, 16'h0016, 16'h009a, 16'h0097, 16'hff66, 16'hffd6, 16'hffc4, 16'h0043, 16'h00b7, 16'h006d, 16'h00b8, 16'hffea, 16'hff4d, 16'h000f, 16'hff28, 16'hffc7, 16'hff76, 16'h006a, 16'hff92, 16'hff32, 16'hff91, 16'hff83, 16'hffa2, 16'hff32, 16'hff60, 16'h00cb, 16'h00a5, 16'h00b9, 16'h00cf, 16'h0064, 16'h000a, 16'hff57, 16'h0016, 16'h0077, 16'hfff6, 16'h002b, 16'hff43, 16'h0042, 16'h0093, 16'hffee, 16'h00c6, 16'h005f, 16'h00c3, 16'h0088, 16'hffcc, 16'hff3b, 16'h002a, 16'h00d2, 16'hff65, 16'hff8a, 16'h0023, 16'hff71, 16'hffc4, 16'hffb3, 16'h00c7, 16'hff53, 16'h0097, 16'hff53, 16'hff72, 16'hff81, 16'hff6b, 16'hffcd, 16'h00d8, 16'h0015, 16'hff90, 16'hffbe, 16'hffce, 16'hfff7, 16'hfff6, 16'h0003, 16'h0081, 16'h0019, 16'hffdd, 16'h009c, 16'h00b0, 16'h00ba, 16'h007d, 16'hff9b, 16'h009d, 16'h0003, 16'hff37, 16'h00b2, 16'hffdc, 16'h006a, 16'hff90, 16'hffd7, 16'h00bd, 16'hff91, 16'hff94, 16'h00ba, 16'h006f, 16'hffe8, 16'hff96, 16'h0060, 16'hff83, 16'h001b, 16'h006b, 16'hffea, 16'hff92, 16'h0025, 16'h0004, 16'h00cf, 16'h00d7, 16'h002e, 16'hffd7, 16'hff78, 16'h0055, 16'h00d5, 16'h0042, 16'h00c3, 16'h00bb, 16'hffc7, 16'h0010, 16'hff46, 16'hff38, 16'hffb2, 16'hffd8, 16'hff28, 16'hff35, 16'hffa8, 16'h0091, 16'h00d8, 16'hffac, 16'hff99, 16'hff38, 16'h00c1, 16'h0084, 16'hff7e, 16'hfff4, 16'h0028, 16'hff79, 16'hffa0, 16'h0077, 16'hff64, 16'h002a, 16'h0027, 16'hffd2, 16'hff2a, 16'h00d5, 16'hff73, 16'hff4d, 16'hff2d, 16'h001e, 16'h003b, 16'h0008, 16'h00ce, 16'h0024, 16'hff3c, 16'hff4c, 16'h000c, 16'hff88, 16'hffb8, 16'h004d, 16'hff72, 16'hffe2, 16'h0071, 16'h009f, 16'h0089, 16'hfff3, 16'hff90, 16'h0043, 16'h00ac, 16'hff69, 16'h0013, 16'hffbe, 16'hfffd, 16'h004d, 16'hffe3, 16'hffb2, 16'h0089, 16'hffb5, 16'hffc6, 16'hffd7, 16'h0075, 16'h001e, 16'hffa4, 16'h0015, 16'hff88, 16'hff2f, 16'h0017, 16'h00c6, 16'hffa7, 16'hff31, 16'h007b, 16'hffc9, 16'hffcc, 16'h00d6, 16'hff8b, 16'h00d6, 16'hff87, 16'h00ce, 16'hffea, 16'hff47, 16'hff7a, 16'h0030, 16'hff69, 16'h0082, 16'h0062, 16'h007d, 16'hffc2, 16'hff3a, 16'hff67, 16'hff6f, 16'h0012, 16'hffba, 16'hffd5, 16'h0065, 16'h00a8, 16'h00be, 16'h0058, 16'h00a9, 16'h002d, 16'h0099, 16'h0093, 16'h0007, 16'hfffc, 16'h0047, 16'hff4a, 16'hff5d, 16'h0034, 16'hfffb, 16'hffb4, 16'h00c4, 16'h002b, 16'h0064, 16'h009a, 16'h0029, 16'h0061, 16'h006e, 16'hff70, 16'hffae, 16'hffb1, 16'h0014, 16'hffe0, 16'h0055, 16'hffb9, 16'h00ae, 16'h00cf, 16'h000c, 16'h002b, 16'hffc9, 16'h0094, 16'h00a9, 16'hffda, 16'hffed, 16'hff99, 16'h003e, 16'hff65, 16'hffef, 16'hff2a, 16'h008b, 16'h0083, 16'h001e, 16'h003f, 16'hff5c, 16'hffd6, 16'h0056, 16'hffd8, 16'hff64, 16'h0074, 16'h00d9, 16'hff4c, 16'h00a5, 16'h0001, 16'h007d, 16'h0012, 16'hfff1, 16'hfffa, 16'h0036, 16'h0082, 16'hffd6, 16'hffb4, 16'h0024, 16'hffca, 16'hfff0, 16'hffad, 16'hff70, 16'hffcd, 16'h00db, 16'hffa3, 16'hff4c, 16'hffb4, 16'hffa5, 16'hffb6, 16'hff82, 16'hffe9, 16'hfff8, 16'hffc1, 16'hffa4, 16'h0061, 16'hff4b, 16'h000a, 16'hffba, 16'hffa2, 16'hff9f, 16'h0051, 16'hff63, 16'h00bd, 16'h00c3, 16'hffaa, 16'h0027, 16'hff83, 16'h00b7, 16'h0056, 16'hffe8, 16'h000c, 16'h0068, 16'hff9a, 16'hffb9, 16'h0024, 16'h0090, 16'hff65, 16'h0033, 16'h00a9, 16'hffd3, 16'h00a7, 16'hff37, 16'hff42, 16'h000c, 16'hffb2, 16'hff3d, 16'hff91, 16'hff34, 16'h00bb, 16'h001f, 16'h008e, 16'h000e, 16'hff5e, 16'hffba, 16'hff62, 16'h0056, 16'h00c5, 16'h0066, 16'h00a6, 16'h0090, 16'hffe5, 16'h0032, 16'h0073, 16'hff8a, 16'hfff3, 16'h00c7
 };
localparam [15:0] biases [0:15] = {
    16'hff0a, 16'hfe82, 16'hff48, 16'hff43, 16'hfee5, 16'hfee2, 16'hfec1, 16'h00e3, 16'hff7f, 16'h00e3, 16'hff02, 16'h00f0, 16'h010f, 16'hff9e, 16'hfed6, 16'h015d 
 };

logic [15:0] data_in [0:N_IN-1];
genvar i;
for (i = 0; i < N_IN; i = i + 1) begin : assign_input
    localparam j = (16*(i+1)) - 1;
    localparam k = 16*(i);
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

logic [15:0] reduced [0:N_OUT-1];
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