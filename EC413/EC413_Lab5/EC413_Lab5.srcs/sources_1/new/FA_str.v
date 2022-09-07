`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 05:32:44 PM
// Design Name: 
// Module Name: FA_str
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
module FA_str(
    input a,
    input b,
    input c_in,
    output sum,
    output c_out
    );
    wire a_bar,b_bar,c_bar;
    wire sum1,sum2,sum3,sum4;
    wire c_out1,c_out2,c_out3;
    //  get ~a ~b ~c
    not not_a(a_bar,a);
    not not_b(b_bar,b);
    not not_c_in(c_bar,c_in);
    //  get sum
    and as1(sum1,a,b,c_in);
    and as2(sum2,a,b_bar,c_bar);
    and as3(sum3,a_bar,b,c_bar);
    and as4(sum4,a_bar,b_bar,c_in);
    or os(sum,sum1,sum2,sum3,sum4);
    //  get c_out
    and ca1(c_out1,a,b);
    and ca2(c_out2,a,c_in);
    and ca3(c_out3,b,c_in);
    or oc(c_out,c_out1,c_out2,c_out3);
endmodule