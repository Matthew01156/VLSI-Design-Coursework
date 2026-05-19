`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2026 07:45:43 PM
// Design Name: 
// Module Name: RCA_4bit_tb
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
// 

module RCA_4bit_tb();
    //declaring the variable that need to be connected to the testbench
    reg [3:0] a;    // both a and b are 4 bit inputs
    reg [3:0] b;
    reg ci; // carry in handler
    
    wire [3:0] s; // 4 bit output
    wire co;    // carry out handler
    
    //instantiate the design module and connect the variable declared above
    RCA_4bit RCA_4bitinst(.a(a), .b(b), .ci(ci), .s(s), .co(co));
    
        //stimulus that can be driven into the design
        // all inputs are 4 bits
        initial begin
            a = 4'b0000;    //set both a and b to 4 bit 0 as starting value
            b = 4'b0000;
            ci = 1'b0; // 1bit at it handles only a extra 1 for carry 
  
            #200 $finish;
        end
        
        always #20 a = a+1; // want to increment 0-15 
        always #5 b = b+1;  // will increment faster 0-15
        always #80 ci = ~ci; // carry in 
        
        always@(a, b, ci, s, co)
            $monitor("at time=%t ns, a=%0d, b=%d, ci=%1b, s=%0d, co=%1b", $time, a, b, ci, s, co);
            // set both ci and co to 1 byte since they expect 1 or 0
endmodule

