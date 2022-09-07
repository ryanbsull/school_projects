`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 06:29:13 PM
// Design Name: 
// Module Name: FA_32bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FA_32bit(
    input [31:0] a,
    input [31:0] b,
    input c_in,
    output [31:0] sum,
    output c_out
    );
    
    wire wa,wb,wc,wd,we,wf,wg;  //  wires used to carry the ripple carry between the multiple adders
    //  each adder handles 4-bits of the 32-bit sum
    FA_4bit fa_a(
        .c_in(c_in),
        .a(a[3:0]),
        .b(b[3:0]),
        .sum(sum[3:0]),
        .c_out(wa)
    );
    FA_4bit fa_b(
        .c_in(wa),
        .a(a[7:4]),
        .b(b[7:4]),
        .sum(sum[7:4]),
        .c_out(wb)
    );
    FA_4bit fa_c(
        .c_in(wb),
        .a(a[11:8]),
        .b(b[11:8]),
        .sum(sum[11:8]),
        .c_out(wc)    
    );
    FA_4bit fa_d(
        .c_in(wc),
        .a(a[15:12]),
        .b(b[15:12]),
        .sum(sum[15:12]),
        .c_out(wd)
    );
    FA_4bit fa_e(
        .c_in(wd),
        .a(a[19:16]),
        .b(b[19:16]),
        .sum(sum[19:16]),
        .c_out(we)
    );
    FA_4bit fa_f(
        .c_in(we),
        .a(a[23:20]),
        .b(b[23:20]),
        .sum(sum[23:20]),
        .c_out(wf)
    );
    FA_4bit fa_g(
        .c_in(wf),
        .a(a[27:24]),
        .b(b[27:24]),
        .sum(sum[27:24]),
        .c_out(wg)    
    );
    FA_4bit fa_h(
        .c_in(wg),
        .a(a[31:28]),
        .b(b[31:28]),
        .sum(sum[31:28]),
        .c_out(c_out)
    );
endmodule
