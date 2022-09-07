`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 06:18:09 PM
// Design Name: 
// Module Name: REG_p
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


module REG_p(clk,r1,r0,z,ov,c,ov_in,c_in);
    parameter N = 32;
    input clk;
    input [(N-1):0] r1;
    output [(N-1):0] r0;
    input c_in;
    input ov_in;
    output reg z;
    output reg ov;
    output reg c;
    
    genvar i;
    //  generate the set of DFF's
    generate
        for(i = 0; i < N; i = i + 1) begin
            dff d0(.clk(clk), .d(r1[i]), .q(r0[i]));
        end
    endgenerate
    always@(posedge clk)begin
        z = (r1 == 0);  //  check to see if the output is zero to set the zero flag
        ov = ov_in;     //  pass the overflow bit
        c = c_in;       //  pass the carry bit
    end
endmodule
