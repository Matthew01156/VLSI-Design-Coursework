`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2026 02:56:49 PM
// Design Name: 
// Module Name: rca_16bit
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
// Matthew Bernardino
// Professor Anshul
// ECPE 136
// Description: Use 4-bit RCA to make 4 blocks to make a 16 bit rca

module rca_16bit(
    // make 4 bit variables using array
    input logic [15:0] a,    // 16 bit inputs
    input logic [15:0] b,
    
    output logic [15:0] s   // 16 bit output sum 
);
    logic cout0;   // carry out bits 0–3
    logic cout1;   // carry out bits 4–7
    logic cout2;   // carry out bits 8–11
    logic cout3;   // carry out bits 12–15

    RCA_4bit B0(
        .a(a[3:0]),
        .b(b[3:0]),
        .ci(1'b0), // no carry in the beginning
        .s(s[3:0]),   // 4 bit part of sum
        .co(cout0)   // carry out goes to next block
    );
    
    RCA_4bit B1(
        .a(a[7:4]),
        .b(b[7:4]),
        .ci(cout0), // carry from previous block
        .s(s[7:4]),   // 4 bit part of sum
        .co(cout1)   // carry out goes to next block
    );
    
    RCA_4bit B2(
        .a(a[11:8]),
        .b(b[11:8]),
        .ci(cout1),     // carry from previous block
        .s(s[11:8]),   // 4 bit part of sum
        .co(cout2)   // carry out goes to next block
    );
    
    RCA_4bit B3(
        .a(a[15:12]),
        .b(b[15:12]),
        .ci(cout2),     // carry from previous block
        .s(s[15:12]),   // 4 bit part of sum
        .co(cout3)   // final carry out 
    );
    
    
endmodule
