`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2026 06:22:26 PM
// Design Name: 
// Module Name: fulladder_1bit_tb
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
// fulladder 1 bit test bench

module fulladder_1bit_tb();
    //declaring the variable that need to be connected to the testbench
    reg a, b, carry_in;
    
    wire sum, carry_out;
    
    //instantiate the design module and connect the variable declared above
    fulladder_1bit fainst(.a(a), .b(b), .carry_in(carry_in), .sum(sum), .carry_out(carry_out));
    
    //stimulus that can be driven into the design
    // set all inputs to 0
        initial begin
            a = 1'b0;   //both a and b are 1 bit
            b = 1'b0;
            carry_in = 1'b0;
            
            #200 $finish;
            
        end
        // toggles variable in ns
        always #20 a = ~a;
        always #40 b = ~b;
        always #80 carry_in = ~carry_in;
        
        always@(a, b, carry_in)
            $monitor("at time=%t ns, a=%0d, b=%0d, carry_in=%0d, sum=%0d, carry_out=%0d", $time, a, b, carry_in, sum, carry_out);
       
endmodule
