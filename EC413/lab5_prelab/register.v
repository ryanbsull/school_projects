`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2020 06:06:22 PM
// Design Name: 
// Module Name: register_32bit
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


module register(d,clk,q);
    parameter N = 32;
    input [(N-1):0] d;
    input clk;
    output [(N-1):0] q;
    genvar i;
    
    generate
        for(i = 0; i < N; i = i + 1) begin
            dff d0(.q(q[i]), .d(d[i]), .clk(clk));
        end
    endgenerate
endmodule
