`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2026 06:43:08 PM
// Design Name: 
// Module Name: t_flipflop_tb
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
//T-Flip FLop test bench

module t_flipflop_tb();

    //declaring the variable that need to be connected to the testbench
    reg clock, reset, t;
    wire q, not_q;
    
    //instantiate the design module and connect the variable declared above
    t_flipflop t_ffinst(.clock(clock), .reset(reset), .t(t), .q(q), .not_q(not_q));
    
        
        
         //stimulus that can be driven into the design
        initial begin
            clock = 1'b0; // clock variable start at 0
            reset = 1'b0; // variable setup of reset = 0 and start from 0
            t = 1'b0; // variable setup of t = 0 
            
            // make test cases with t as toggle flip flop and reset
            #15 reset = 1'b1; //wait 15 ns until reset,
             
            #200 $finish; // 200ns total time
        end
        
        always #10 clock = ~clock; //clock updates every 10ns
        always #40 t = ~t;          // t updates every 40ns
        
        
        always@(clock, reset, t, q, not_q)
            $monitor("at time=%t ns, clock=%1b, reset=%1b, t=%1b, q=%1b, not_q=%1b", $time, clock, reset, t, q, not_q);
            // want all variables to be represented in 1 byte for 0 / 1 as low and high. 
endmodule


