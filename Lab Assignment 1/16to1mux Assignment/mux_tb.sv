`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2026 05:01:45 PM
// Design Name: 
// Module Name: mux_tb
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
// 16to1mux test bench

module mux_tb();
    //declaring the variable that need to be connected to the testbench
    reg ip0, ip1, ip2, ip3; 
    reg ip4, ip5, ip6, ip7; 
    reg 
ip8, ip9, ip10, ip11;
 
    reg ip12, ip13, ip14, ip15;
    
    reg [3:0] selection; // 4 bit selection signal
    
    wire op;
    
    //instantiate the design module and connect the variable declared above
    mux16to1 muxinst(
    .ip0(ip0), .ip1(ip1), .ip2(ip2), .ip3(ip3), 
    .ip4(ip4), .ip5(ip5), .ip6(ip6), .ip7(ip7), 
    .ip8(ip8), .ip9(ip9), .ip10(ip10), .ip11(ip11), 
    .ip12(ip12), .ip13(ip13), .ip14(ip14), .ip15(ip15), 
    .selection(selection), .op(op)
    );
    
    //stimulus that can be driven into the design
    initial begin
        ip0 = 1'b0;
        ip1 = 1'b0;
        ip2 = 1'b0;
        ip3 = 1'b0;
        ip4 = 1'b0;
        ip5 = 1'b0;
        ip6 = 1'b0;
        ip7 = 1'b0;
        ip8 = 1'b0;
        ip9 = 1'b0;
        ip10 = 1'b0;
        ip11 = 1'b0;
        ip12 = 1'b0;
        ip13 = 1'b0;
        ip14 = 1'b0;
        ip15 = 1'b0;
        
        selection = 4'b0000;
        
        #500 $finish;
    
    end
    // times at which executes
    always #20 ip0 = ~ip0;
    always #40 ip1 = ~ip1;
    always #60 ip2 = ~ip2;
    always #80 ip3 = ~ip3;
    always #100 ip4 = ~ip4;
    always #120 ip5 = ~ip5;
    always #140 ip6 = ~ip6;
    always #160 ip7 = ~ip7;
    always #180 ip8 = ~ip8;
    always #200 ip9 = ~ip9;
    always #220 ip10 = ~ip10;
    always #240 ip11 = ~ip11;
    always #260 ip12 = ~ip12;
    always #280 ip13 = ~ip13;
    always #300 ip14 = ~ip14;
    always #320 ip15 = ~ip15;
    always #10 selection = ~selection;
    
    always @(ip0, ip1, ip2, ip3, ip4, ip5, ip6, ip7, 
             ip8, ip9, ip10, ip11, ip12, ip13, ip14, ip15, selection)
             
        $monitor("time=%0t ns, selection=%0d, ip0=%b ip1=%b ip2=%b ip3=%b ip4=%b ip5=%b ip6=%b ip7=%b ip8=%b ip9=%b ip10=%b ip11=%b ip12=%b ip13=%b ip14=%b ip15=%b, op=%b",
                 $time, selection, ip0, ip1, ip2, ip3, ip4, ip5, ip6, ip7,
                 ip8, ip9, ip10, ip11, ip12, ip13, ip14, ip15, op);
    
endmodule
