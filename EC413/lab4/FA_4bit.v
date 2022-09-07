`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 06:23:20 PM
// Design Name: 
// Module Name: FA_4bit
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


module FA_4bit(
    input [3:0] a,
    input [3:0] b,
    input c_in,
    output [3:0] sum,
    output c_out
    );
    
    wire wa,wb,wc;
    //  each structural full adder handles a sinlge bit of the 4-bit sum and then ripples over the carry out
    FA_str fa_a(
        .c_in(c_in),
        .a(a[0]),
        .b(b[0]),
        .sum(sum[0]),
        .c_out(wa)
    );
    FA_str fa_b(
        .c_in(wa),
        .a(a[1]),
        .b(b[1]),
        .sum(sum[1]),
        .c_out(wb)
    );
    FA_str fa_c(
        .c_in(wb),
        .a(a[2]),
        .b(b[2]),
        .sum(sum[2]),
        .c_out(wc)    
    );
    FA_str fa_d(
        .c_in(wc),
        .a(a[3]),
        .b(b[3]),
        .sum(sum[3]),
        .c_out(c_out)
    );
endmodule
