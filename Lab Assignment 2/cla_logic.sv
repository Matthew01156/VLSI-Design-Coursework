// Matthew Bernardino
// ECPE 136
// Professor Anshul
// Description: cla logic - used to calculate all carrys simultaneously using generate and propogate signals and carry in

module cla_logic(
    // setup our 4 bit inputs and carry in 
    input logic [3:0] g, // both propogate and generate are 4 bits
    input logic [3:0] p,
    input logic carry_in, // 1 or 0 for carry or no carry
    
    // setup our 4 bit outputs
    output logic [3:0] c_out,
    output logic group_g, // if generated carry from 4 bit 
    output logic group_p  // if propgoated carry from 4 bit
    );
    
    // we are showing all possible ways a carry can happen with each equation.

    assign c_out[0] = g[0] | (p[0] & carry_in); // carry into bit 1: generate at bit 0 or propogate from carry_in
    
    assign c_out[1] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & carry_in); //carry into bit 2: generate at bit 1 or generate at g[0] and p[1] or propagate all the way with carry in 
    
    assign c_out[2] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & carry_in); //carry into bit 3: generate at bit 2 or generate at g[0] and p[1] or propagate all the way with carry in
    
    assign c_out[3] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & carry_in); // generate at bit 4 or propogate from previous

    assign group_p = p[3] & p[2] & p[1] & p[0]; // 4 bit might carry in if all 4 bits propogate, if not then carry stops
    
    assign group_g = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]); // determines if entire 4 bit block genertates a carry output, or if propogates with earlier generate to make carry output without carry in needed
    

endmodule