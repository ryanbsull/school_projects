`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2020 01:44:11 PM
// Design Name: 
// Module Name: FA_64bit_CSA_D
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


module FA_64bit_CSA_D(
    input [63:0] a,
    input [63:0] b,
    input c_in,
    output [63:0] sum,
    output c_out
    );
    wire w;
    wire c_out1, c_out0;     //  wires to store both possible values of c_out
    wire [31:0] sum1;    //  stores possible value of the last 32-bits of sum if c_out of fa_a is 1
    wire [31:0] sum0;    //  stores possible value of the last 32-bits of sum if c_out of fa_a is 0
    //  module used to compute the first 32-bits of the sum
    FA_32bit_D fa_a(
        .a(a[31:0]),
        .b(b[31:0]),
        .c_in(c_in),
        .sum(sum[31:0]),
        .c_out(w)
    );
    //  precompute for c_out for fa_a = 0
    FA_32bit_D fa_b(
        .a(a[63:32]),
        .b(b[63:32]),
        .c_in(1'b0),
        .sum(sum0),
        .c_out(c_out0)
    );
    //  precompute for c_out for fa_a = 1
    FA_32bit_D fa_c(
        .a(a[63:32]),
        .b(b[63:32]),
        .c_in(1'b1),
        .sum(sum1),
        .c_out(c_out1)
    );
    //  check the output of c_out for fa_a and assign the second half of sum and c_out accordingly
    assign c_out = (w)?c_out1:c_out0;
    assign sum[63:32] = (w)?sum1:sum0;
    
endmodule
