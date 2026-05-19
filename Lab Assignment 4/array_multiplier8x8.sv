`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 02/17/2026 02:48:13 PM
// Module Name: array_multiplier8x8
//////////////////////////////////////////////////////////////////////////////////
// Matthew Bernardino
// professor Anshul
// ECPE 136
// 8x8 Array Multiplier


module array_multiplier8x8(
    input logic [7:0] A,    // multiplicand
    input logic [7:0] B,    // multiplier
    output logic [15:0] P    // product
    );
    
    
    logic [7:0] partial_p  [0:7];     // and gate matrix array
    logic [15:0] partialp_shift   [0:7]; // indented rows, shift left by x to multiply by 2
    logic [15:0] sum_a        [0:7];  // addition, the rca_16 blocks the final 16bit product is stored to P
    
   // this loop does all the math in parallel instead of sequentially, since all comparisons are independent.
   // reference: https://www.systemverilog.io/verification/generate/
   // need to use partial_p as an array of 8 bits to inidvidually take each bit from an 8 bit binary to AND gate 
   // A is an 8bit binary number and B is also 8 bit binary but each individual bit from B gets AND with all of A
    genvar i; // create i variable for for loop
    generate    // create for loop
        for (i = 0; i < 8; i++) begin : partial_p_AND // 8 increments for 8 bits, increment i with each new AND comparison
            assign partial_p[i] = A & {8{B[i]}}; // makes each B bit individually AND With all of A 8bit
        end                                     //B is either 11111111 or 00000000 for each comparison
    endgenerate
    
    // partialp_shift loop. Another array of 8 bits. 
    // need to shift left 8 bit partial_p to 16 bits, we shift based on the partial_p[k]
    genvar k;// make variable for for loop
    generate
        for (k = 0; k < 8; k++) begin : product_shift
            assign partialp_shift[k] = {8'b0, partial_p[k]} << k; // make the 8bit partia_p as 16 bits for proper shifting
        end                                 // << k shifts left by 2^k. as k increments the shift is increased.
    endgenerate
    
    assign sum_a[0] = partialp_shift[0]; // there is no addition for the first row[0] so we add it in directly
    // needs another value to add to it
    // the actual addition of 7 adders and 8 rows to make one final result
    genvar j; // create variable for for loop
    generate
        for (j = 1; j < 8; j++) begin : sum_addition // for loop starts from 
            rca_16bit final_adder ( // instantiate from rca_16bit.sv to use 4 bit block adders
                .a(sum_a[j-1]),     // since we start sum_a[0] outside loop, we need to j-1 to go back to sum[0]  
                .b(partialp_shift[j]),  // next shifted partial product to add
                .s(sum_a[j])          // updates the 16 bit sum as it iterates with shifted partial products
            );
        end
    endgenerate 
    
    // sum_a[7] has the final 16 bit output and we need to assign it to P since its the output wire
    
    assign P = sum_a[7];
    
endmodule
