`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2020 06:58:17 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb;
    parameter N = 8;
    reg [N-1:0] a;
    reg [(N-1):0] b;
    reg c_in;
    reg clk;
    reg sel;
    wire [(N-1):0] q;
    wire [(N-1):0] q_v;
    reg error;
    
    top #(N) t(
        .a(a),
        .b(b),
        .c_in(c_in),
        .clk(clk),
        .sel(sel),
        .q(q)
    );
    Verify #(N) v(
        .a(a),
        .b(b),
        .c_in(c_in),
        .clk(clk),
        .sel(sel),
        .q(q_v)
    );
    
    initial begin
        a = 0;
        b = 0;
        c_in = 0;
        sel = 0;
        clk = 0; 
    end
    always begin
            #6;
            a = a + 1;
            b = b + 1;
            #6;
            c_in = ~c_in;
            #2;
            sel = ~sel;
     end
     always@(posedge clk)begin
        error = (q_v != q);
     end
     
     always begin
            #5 clk = ~clk;
     end
endmodule
