`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2020 06:59:25 PM
// Design Name: 
// Module Name: fourbit_FA_H
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


module fourbit_FA_H(
    input [3:0] a,
    input [3:0] b,
    input c_in,
    output [3:0] sum,
    output c_out
    );
    wire c_one,c_two,c_three;   //  ripples over the carry out from internal full adders
    
    FA_str fa_a(
        .a(a[0]),
        .b(b[0]),
        .c_in(c_in),
        .sum(sum[0]),
        .c_out(c_one)
    );
    FA_str fa_b(
        .a(a[1]),
        .b(b[1]),
        .c_in(c_one),
        .sum(sum[1]),
        .c_out(c_two)
    );
    FA_str fa_c(
        .a(a[2]),
        .b(b[2]),
        .c_in(c_two),
        .sum(sum[2]),
        .c_out(c_three)
    );
    FA_str fa_d(
        .a(a[3]),
        .b(b[3]),
        .c_in(c_three),
        .sum(sum[3]),
        .c_out(c_out)
    );
endmodule
