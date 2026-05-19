`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2026 05:54:42 PM
// Design Name: 
// Module Name: 3to8decoder_tb
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
// 3to8 Decoder test bench


module decoder3to8_tb();
    //declaring the variable that need to be connected to the testbench
    reg [2:0] ip;   // 3bit input
    wire [7:0] op;  // 8 bit ouput
    
    //instantiate the design module and connect the variable declared above
    decoder3to8 decoderinst(.ip(ip), .op(op));
    
    //stimulus that can be driven into the design
    initial begin
        ip = 3'b000; // start from 000
        
        #200 $finish;
        
    end
    // for faster binary decreased interval time to get all 7 numbers outputs
    always #10 ip[0] = ~ip[0];
    always #20 ip[1] = ~ip[1];
    always #40 ip[2] = ~ip[2];
    
    always@(ip, op)
        $monitor("at time=%t ns, ip=%3b, op=%8b", $time, ip, op); // add ip=%3b so shouws 3 bit input and op=8%8b as 8 bit output 
        
endmodule