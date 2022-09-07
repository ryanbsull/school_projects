`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 05:40:57 PM
// Design Name: 
// Module Name: NOT_p
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


module NOT_p(in,out);
    parameter N = 32;
    input [(N-1):0] in;
    output [(N-1):0] out;
    
    genvar i;
    //  generate the series of NOT gates
    generate
        for(i = 0; i < N; i = i + 1) begin
            NOT_str n0(.in(in[i]), .out(out[i]));
        end
    endgenerate
endmodule
