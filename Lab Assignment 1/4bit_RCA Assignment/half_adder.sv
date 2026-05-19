// Name: Matthew Bernardino
// Date: 29 January 2026
// Class: ECPE 136
// Professor: Anshul
// Description: half Adder - add two bits to make a sum and carry

module half_adder(
    input logic a, // input 1
    input logic b, // input 2
    output logic s, // ouput sum
    output logic carry // output carry 
);

    assign s = a ^ b; // need XOR for sum 

    assign carry = a & b; // if both a and b are 1 , we carry it lik in 1 + 1 = 1 carry


endmodule