`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2020 07:38:13 PM
// Design Name: 
// Module Name: not_p
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


module not_p(in,out);
    parameter N = 32;
    input [(N-1):0] in;
    output [(N-1):0] out;
    genvar i;
    generate
        for(i = 0; i < N; i = i + 1) begin
           assign out[i] = ~in[i];
        end
    endgenerate
endmodule
