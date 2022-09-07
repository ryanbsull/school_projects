`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 06:53:45 PM
// Design Name: 
// Module Name: FS_p
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


module FS_p(a,b,diff,ov,ov_in);
    parameter N = 32;
    input [(N-1):0] a;
    input [(N-1):0] b;
    input ov_in;
    output [(N-1):0] diff;
    output ov;
    wire [(N-1):0] inv;
    wire [(N-1):0] two_c;
    //  invert the input to be subtracted
    NOT_p #(N) in(
        .in(b),
        .out(inv)
        );
    //  add 1 to the inverted input to make the 2's complement
    FA #(N) add1(
        .a(inv),
        .b(1),
        .c_in(0),
        .sum(two_c)
        );
    //  a + (-b)
    FA #(N) sub(
        .a(a),
        .b(two_c),
        .c_in(0),
        .c_out(ov),
        .sum(diff)
    );
endmodule
