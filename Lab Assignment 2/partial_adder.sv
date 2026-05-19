// Matthew Bernardino
// ECPE 136
// Professor Anshul
// Description: Partial full adder - used to calcualte if gernerate (carry produced) and propagate (incoming carry) for carry

module partial_fulladder(
    // setup variables to be used for partial adder
    input logic a, b, carry_in,  // 3 inputs
    output logic g, p, s // 3 outputs, generate, propogate, sum
    );
    
    assign g = a & b;       // generate function (a carry bit is generated), a carry out is created no matter what carry in
    
    assign p = a ^ b;       // propogate function (will a carry bit pass through), this bit will pass the carry-in through to carry-out if one comes in
    
    assign s = a ^ b ^ carry_in;   // sum function (sum bit for position)
    
    
endmodule
