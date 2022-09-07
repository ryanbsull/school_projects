`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 08:42:20 PM
// Design Name: 
// Module Name: FS_str_tb
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


module FS_str_tb;
reg a, b, in;
wire diff, out;
FS_str fs(
    .a(a),
    .b(b),
    .ov_in(in),
    .diff(diff),
    .ov_out(out)
);

initial begin
    a = 3;
    b = 1;
    in = 0;
end


endmodule
