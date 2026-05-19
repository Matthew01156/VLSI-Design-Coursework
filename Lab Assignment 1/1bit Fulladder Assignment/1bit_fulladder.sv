// Name: Matthew Bernardino
// Date: 29 January 2026
// Class: ECPE 136
// Professor: Anshul
// Description: 1-bit Full Adder - uses combinational logic to add three 1 bit inputs to make a 2 bit output

module fulladder_1bit (

// create three input variables - Only 000 to 111 (0-7)
    input logic a, b, carry_in, // a and b will be added together, carry_in is a carry in from previous stage 
// create two output variables
    output logic sum, carry_out // sum will be the sum bit of the addition and carry_out will carry out to the next stage

);

    // we use XOR since it is the same rule as addition of binary numbers. Carry_in handles when there are two 1s being added
    assign sum = a ^ b ^ carry_in; // we use assign sum to indicate that the expression is always sum = a ^ b ^ carry_in

    // carry out is done when atleast two inputs are 1
    assign carry_out = (a & b) | (b & carry_in) | (a & carry_in); // carry_out is also used when two 1s are present
    
endmodule