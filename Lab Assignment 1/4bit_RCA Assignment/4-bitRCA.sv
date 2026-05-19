// Name: Matthew Bernardino
// Date: 29 January 2026
// Class: ECPE 136
// Professor: Anshul
// Description: 4-bit Ripple Carry Adder - Use 4 Full adders to add two 4 bit numbers

module RCA_4bit(

// make 4 bit variables using array
    input logic [3:0] a,    
    input logic [3:0] b,
    input logic ci, // carry in handler
    
    output logic [3:0] s,   // 4 bit sum 
    output logic co    // carry output 

);

// setup wire connections of full adders
// set carry outs for pass full adder to full adder
logic co0_to_ci1;  
logic co1_to_ci2;
logic co2_to_ci3;

full_adder FA0 (
    .a(a[0]),   // connect full adder script to current 4 bit array
    .b(b[0]),   // first a and b inputs
    .ci(ci),    // first carry input
    .s(s[0]), // makes bit 0 sum
    .co(co0_to_ci1) // hands carry out to next full adder
);

full_adder FA1 (
    .a(a[1]),   // second a and b inputs
    .b(b[1]), 
    .ci(co0_to_ci1),   // carry in from previous full adder
    .s(s[1]),   // makes bit 1 sum
    .co(co1_to_ci2)   // hands carry out to next full adder
);

full_adder FA2 (
    .a(a[2]),   // third a and b inputs
    .b(b[2]), 
    .ci(co1_to_ci2),   // carry in from previous full adder
    .s(s[2]),   // makes bit 3 sum
    .co(co2_to_ci3)   // hands carry out to next full adder
);

full_adder FA3 (
    .a(a[3]),   // third a and b inputs
    .b(b[3]), 
    .ci(co2_to_ci3),   // carry in from previous full adder
    .s(s[3]),   // makes bit 3 sum
    .co(co)   // has final carry output, if there is one
);

endmodule