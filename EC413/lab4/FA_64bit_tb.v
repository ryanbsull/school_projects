`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 07:25:50 PM
// Design Name: 
// Module Name: FA_64bit_tb
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


module FA_64bit_tb;
    reg [63:0] a;
    reg [63:0] b;
    reg c_in;
    //  initialize RCA outputs
    wire [63:0] sum_rca;
    wire c_out_rca;
    //  initialize CSA outputs
    wire [63:0] sum_csa;
    wire c_out_csa;
    //  initialize RCA with delay outputs
    wire [63:0] sum_rca_d;
    wire c_out_rca_d;
    //  initialize CSA with delay outputs
    wire [63:0] sum_csa_d;
    wire c_out_csa_d;
    //  initialize Verify outputs
    wire [63:0] sum_verify;
    wire c_out_verify;
    //  initialize Verify module
    Verify_64bit v(
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum_verify),
        .c_out(c_out_verify)
    );
    //  initialize RCA module
    FA_64bit_RCA r(
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum_rca),
        .c_out(c_out_rca)
    );
    //  initialize CSA module
    FA_64bit_CSA c(
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum_csa),
        .c_out(c_out_csa)
    );
    //  initialize RCA module
    FA_64bit_RCA_D rd(
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum_rca_d),
        .c_out(c_out_rca_d)
    );
    //  initialize CSA module
    FA_64bit_CSA_D cd(
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum_csa_d),
        .c_out(c_out_csa_d)
    );
    
    initial begin
        c_in = 1'b0;
        a = 64'b0;
        b = 64'b0;
        #5;    //  wait 1 ns
        forever begin
            a = {$urandom,$urandom};
            b = {$urandom,$urandom};
            #20;
            c_in = c_in + 1'b1;
            #20;
        end
    end
endmodule
