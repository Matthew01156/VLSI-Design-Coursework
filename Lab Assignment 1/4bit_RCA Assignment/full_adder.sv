// Name: Matthew Bernardino
// Date: 29 January 2026
// Class: ECPE 136
// Professor: Anshul
// Description: full Adder - add three bits using two half adders with OR gate

module full_adder (
    input logic a, // input 1
    input logic b, // input 2
    input logic ci, // carry in from previous add
    output logic s, // ouput sum
    output logic co // output carry 
);

   // setup for xonnecting two half adders together
   logic sum_half_adder1;       // sum
   logic carry_half_adder1; // carry output from first half
   logic carry_half_adder2; // carry output from second half

    half_adder first_ha (
       // connect two half adders together
        .a(a),  
        .b(b),  
        .s(sum_half_adder1),    // partial sum
        .carry(carry_half_adder1) // carry of a & b

    );

    // adds partial sum with carry in
    half_adder second_ha (
        .a(sum_half_adder1),  // partial sum from first half adder
        .b(ci),  // adds carry in
        .s(s),    // final added output
        .carry(co) // another carry
    );

    // combine both carry outputs with OR gate
    assign co = carry_half_adder1 | carry_half_adder2;

endmodule