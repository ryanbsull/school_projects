`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 05:41:53 PM
// Design Name: 
// Module Name: AND_p
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


module AND_p(in1,in2,out);
    parameter N = 32;
    input [(N-1):0] in1;
    input [(N-1):0] in2;
    output [(N-1):0] out;
    
    genvar i;
    //  generate the series of AND gates
    generate
        for(i = 0; i < N; i = i + 1) begin
            AND_str a0(.in1(in1[i]), .in2(in2[i]), .out(out[i]));
        end
    endgenerate
endmodule
