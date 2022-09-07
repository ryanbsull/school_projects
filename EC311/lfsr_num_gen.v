`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2019 01:35:59 PM
// Design Name: 
// Module Name: lfsr_num_gen
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


module lfsr_num_gen(
    input clk,
    input reset,
    input [2:0] init,
    output reg [4:0] mole
    );
    reg [2:0] num;
    reg [2:0] in;
    always @(posedge clk) begin
        if(init == 0)
            in <= 3'b111;
        else
            in <= init;
    end
    always @(posedge clk or posedge reset) begin
        if(reset)
            num <= in;
        else if(clk) begin
           // num <= in;
            num[0] <= num[1]^num[2];
            num[1] <= num[0];
            num[2] <= num[1];
        end
    end
    always @(posedge clk) begin
        case(num)
            3'b000: mole <= 5'b00001;
            3'b001: mole <= 5'b00010;
            3'b010: mole <= 5'b00100;
            3'b011: mole <= 5'b01000;
            3'b100: mole <= 5'b10000;
            3'b101: mole <= 5'b00001;
            3'b110: mole <= 5'b00100;
            3'b111: mole <= 5'b10000;
        endcase
    end
endmodule
