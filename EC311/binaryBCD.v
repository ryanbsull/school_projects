`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2019 01:17:59 PM
// Design Name: 
// Module Name: binaryBCD
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


module binaryBCD(
    input clk,
    input reset,
    input [7:0] binary,
    output reg [11:0]bcd    
);

    reg [3:0]i;
    
    //Always, implement double dabble
    
    always@(posedge clk)begin
        bcd = 0;
        for(i=0;i<8;i=i+1)begin
            bcd = {bcd[10:0], binary[7-i]};
            
            if(i < 7 && bcd[3:0] > 4) 
                bcd[3:0] = bcd[3:0] + 3;
            if(i < 7 && bcd[7:4] > 4)
                bcd[7:4] = bcd[7:4] + 3;
            if(i < 7 && bcd[11:8] > 4)
                bcd[11:8] = bcd[11:8] + 3; 
         end//for
     end//always
endmodule

