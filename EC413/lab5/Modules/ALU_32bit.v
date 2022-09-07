`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 05:32:44 PM
// Design Name: 
// Module Name: ALU_32bit
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
module ALU_32bit(result,a,b,select,clk,z,ov,c_out);
    parameter N = 32;
    input [(N-1):0] a;
    input [(N-1):0] b;
    input [2:0] select; 
    input clk;
    output [(N-1):0] result;
    output z; 
    output ov;
    output c_out;
    wire [(N-1):0] diff; 
    wire [(N-1):0] sum;
    wire [(N-1):0] or_in;
    wire [(N-1):0] and_in;
    wire [(N-1):0] not_in;
    reg [(N-1):0] reg_in;
    wire carry; 
    wire overflow;
    reg c_in;
    reg ov_in;
    //  instantiate the constituent function modules
    OR_p #(N) or_32bit(
        .out(or_in),
        .in1(a),
        .in2(b)
        );
    AND_p #(N) and_32bit(
        .out(and_in),
        .in1(a),
        .in2(b)
        );
    NOT_p #(N) not_32bit(
        .out(not_in),
        .in(a)
        );
    FA #(N) fa_32bit(
        .a(a),
        .b(b),
        .c_in(1'b0),
        .sum(sum),
        .c_out(carry)
        );
    FS_p #(N) fs_32bit(
        .a(a),
        .b(b),
        .diff(diff),
        .ov(overflow)
        );
    //  instantiate the register
    REG_p #(N) reg_32bit(
            .r1(reg_in),
            .r0(result),
            .clk(clk),
            .ov_in(ov_in),
            .ov(ov),
            .c_in(c_in),
            .c(c_out),
            .z(z)
        );
    //  create the MUX
    always@(*)begin
        case(select)
        3'b000 : reg_in = a;        //  SLT = 000: MOV
        3'b001 : reg_in = not_in;   //  SLT = 001: NOT
        3'b011 : reg_in = and_in;   //  SLT = 011: AND
        3'b100 : reg_in = or_in;    //  SLT = 100: OR
        3'b101 : begin              //  SLT = 101: SUB
                    reg_in = diff;
                    ov_in = overflow;
                end
        3'b110 : begin              //  SLT = 110: ADD
                    reg_in = sum;
                    c_in = carry;
                 end
        endcase
    end
endmodule