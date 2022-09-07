`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 05:32:44 PM
// Design Name: 
// Module Name: ALU_verification
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
module ALU_verification(result,a,b,select,clk,z,ov,c_out);
    parameter N = 32;
    input [(N-1):0] a;
    input [(N-1):0] b;
    input [2:0] select; 
    input clk;
    output reg [(N-1):0] result;
    output z, ov, c_out;
    reg z, ov, c_out;
    
    always@(posedge clk)begin
        case(select)
        3'b000 : result = a;
        3'b001 : result = ~a;
        3'b011 : result = a&b;
        3'b100 : result = a|b;
        3'b101 : {ov,result} = a-b;
        3'b110 : {c_out,result} = a+b;
        endcase
        z = (result == 0);
    end

endmodule