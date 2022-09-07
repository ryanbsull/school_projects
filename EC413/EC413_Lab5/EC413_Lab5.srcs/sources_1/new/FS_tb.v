`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2020 11:46:59 AM
// Design Name: 
// Module Name: FS_tb
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


module FS_tb;
parameter N = 32;
reg [(N-1):0] a;
reg [(N-1):0] b;
reg in;
wire [(N-1):0] diff;
wire out;
FS_p #(N) fs(
    .a(a),
    .b(b),
    .ov_in(in),
    .diff(diff),
    .ov(out)
);

initial begin
    a = 3;
    b = 1;
    in = 0;
end


endmodule
