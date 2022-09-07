`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 07:21:12 PM
// Design Name: 
// Module Name: Verify_64bit
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


module Verify_64bit(
    input [63:0] a,
    input [63:0] b,
    input c_in,
    output [63:0] sum,
    output c_out
    );
    
    assign {c_out,sum} = a + b + c_in;
    
endmodule
