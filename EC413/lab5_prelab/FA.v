`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2020 06:11:35 PM
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


module FA(a,b,c_in,sum,c_out);
    parameter N = 32;
    input [(N-1):0] a;
    input [(N-1):0] b;
    input c_in;
    output c_out;
    output [(N-1):0] sum;
    wire [N:0] c_int;   //  internal carrys
    genvar i;
    assign c_int[0] = c_in;
    generate
        for(i = 0; i < N; i = i + 1) begin
            FA_str a0(.c_out(c_int[i+1]), .sum(sum[i]), .a(a[i]), .b(b[i]), .c_in(c_int[i]));
        end
    endgenerate
    assign c_out = c_int[N];   //  final internal carry = c_out
endmodule
