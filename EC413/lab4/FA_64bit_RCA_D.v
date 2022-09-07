`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2020 01:43:37 PM
// Design Name: 
// Module Name: FA_64bit_RCA_D
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


module FA_64bit_RCA_D(
    input [63:0] a,
    input [63:0] b,
    input c_in,
    output [63:0] sum,
    output c_out
    );
    wire w;
    //  computes the first 32-bits of the sum
    FA_32bit_D fa_a(
        .a(a[31:0]),
        .b(b[31:0]),
        .c_in(c_in),
        .sum(sum[31:0]),
        .c_out(w)
    );
    //  computes the second 32-bits of the sum
    FA_32bit_D fa_b(
        .a(a[63:32]),
        .b(b[63:32]),
        .c_in(w),
        .sum(sum[63:32]),
        .c_out(c_out)
    );
endmodule

