`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2026 03:47:12 PM
// Design Name: 
// Module Name: cla_16bit_tb
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
//Matthew Bernardino
//Test bench for 16 bit carry look ahead adder

module cla_16bit_tb();
    reg [15:0] a; // 16 bit variables a and b for adding
    reg [15:0] b;
    reg carry_in; // carry in variable to account for any
    
    wire [15:0] s; // total result of 16 bit output
    wire carry_out; // if a carry out exists then accoutn for it
    
    //instantiate the design module and connect the variable declared above
    cla_16bit cla_16bit_inst(.a(a), .b(b), .carry_in(carry_in), .s(s), .carry_out(carry_out));
    
    initial begin
       
       a = 16'hFFFF; // want to simulate carry out, so 65535 plus any num>0 is cout=1
       b = 16'h0000;
       carry_in = 1'b0;
       
       #200
       
       a = 16'b0;   // we set both a and b to 0 to start incrementing with time
       b = 16'b0;
       carry_in = 1'b0; // only a 1 bit extra carry of there is
        
       #800 $finish; //200 ns time
        
  
    end
   
    always #20 a = a + 1; // increment 0 - 15 for testing
    always #10 b = b + 1; // increment 0 - 15 for testing, do so faster to add the same value to a for multiple cases
    always #80 carry_in = ~carry_in; // carry in setup
    
    always @(a, b, carry_in, s, carry_out)
        $monitor("at time=%t ns, a=%0d, b=%0d, cin=%1b, sum=%0d, cout=%1b", $time, a, b, carry_in, s, carry_out);
    
endmodule
