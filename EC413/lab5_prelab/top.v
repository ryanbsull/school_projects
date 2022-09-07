`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2020 06:25:55 PM
// Design Name: 
// Module Name: top
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


module top(a,b,c_in,clk,sel,q);
    parameter N = 32;
    input [N-1:0] a;
    input [N-1:0] b;
    input c_in;
    input clk;
    input sel;
    output [N:0] q;
    wire [N:0] d_bar;
    wire [N:0] d_sum;
    wire [N:0] d;
    assign d = (sel) ? d_sum : d_bar;   //  MUX: sel = 1: add / sel = 0:  end
    
    not_p #(N+1) n(
        .in({c_in,a}),
        .out(d_bar)
    );
    FA #(N) adder(
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(d_sum[(N-1):0]),
        .c_out(d_sum[N])
    );
    register #(N+1) r(
        .clk(clk),
        .d(d),
        .q(q)
    );
endmodule
