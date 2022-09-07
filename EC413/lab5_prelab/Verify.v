`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2020 06:52:53 PM
// Design Name: 
// Module Name: Verify
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


module Verify(a,b,c_in,clk,sel,q);
    parameter N = 32;
    input [(N-1):0] a;
    input [(N-1):0] b;
    input c_in;
    input clk;
    input sel;
    output reg [N:0] q;
    
    always@(posedge clk)begin
        if(sel)begin
            q = a + b + c_in;
        end else begin
            q = ~({c_in,a});
        end
    end
endmodule
