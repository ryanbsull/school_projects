`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2020 01:14:08 PM
// Design Name: 
// Module Name: FA_str
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


module FA_str(
    input a,
    input b,
    input c_in,
    output sum,
    output c_out
    );
    wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10;
    and a1(w1,a,b);             //  a*b
    and a2(w2,a,c_in);          //  a*c_in
    and a3(w3,b,c_in);          //  b*c_in
    or  o1(c_out,w1,w2,w3);     //  c_out = a*b + a*c_in + b*c_in
    not n1(w4,a);               //  ~a
    not n2(w5,b);               //  ~b
    not n3(w6,c_in);            //  ~c_in
    and a4(w7,w4,w5,c_in);      //  (~a)*(~b)*c_in
    and a5(w8,a,w5,w6);         //  a*(~b)*(~c_in)
    and a6(w9,w4,b,w6);         //  (~a)*b*(~c_in)
    and a7(w10,a,b,c_in);       //  a*b*c
    or  o2(sum,w7,w8,w9,w10);   //  sum = (~a)*(~b)*c_in + a*(~b)*(~c_in) + (~a)*b*(~c_in) + a*b*c
endmodule
