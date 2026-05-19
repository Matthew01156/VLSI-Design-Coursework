// Matthew Bernardino
// ECPE 136
// Professor Anshul
// Description: cla 16bit - use 4 cla 4 bit partial full adders blocks to make 16 bit cla adder. 
// Each 4 bit block with do its own simultaneous look ahead with the 4 bit cla to comput a 16 bit cla adder.
// The blocks will look ahead on their own bits and then a final look ahead looks over all the 4 bit blocks

module cla_16bit(
// need 16 bit input variables for all 16 input bits for a and b
    input logic [15:0] a, 
    input logic [15:0] b,
    input logic carry_in, // 16 bit carry in 
    
    output logic [15:0] s,  // total 16 bit sum output
    output logic carry_out // 16 bit carry out if any
);

// need internal logic for connecting the 4 bit partial full adder blocks

    logic [3:0] group_gblock;    // generate 4 bit group block
    logic [3:0] group_pblock;   // propogate 4 bit group block
    logic [3:0] local_carry_block; //carries from the 4 bit cla partial full adder blocks
    
    cla_4bit b0( // first 4 bits 0 - 3
        .a(a[3:0]), //4 bit array for output of partial full adder being 0000
        .b(b[3:0]),
        .carry_in(carry_in),// external carry in
        .s(s[3:0]), // 4 bit sum 0000
        .carry_out(),    // this gets ignored because of lookahead  
        .group_g(group_gblock[0]), // handles extra carry 
        .group_p(group_pblock[0])
    );
    
    cla_4bit b1( // next 4 bits 4 - 7
        .a(a[7:4]), //4 bit array for output of partial full adder being 0000
        .b(b[7:4]),
        .carry_in(local_carry_block[0]),// lookahead logic
        .s(s[7:4]), // 4 bit sum 0000
        .carry_out(),    // this gets ignored because of lookahead  
        .group_g(group_gblock[1]), // handles extra carry 
        .group_p(group_pblock[1])
    );
    
    cla_4bit b2( // next 4 bits 8 - 11
        .a(a[11:8]), //4 bit array for output of partial full adder being 0000
        .b(b[11:8]),
        .carry_in(local_carry_block[1]),
        .s(s[11:8]), // 4 bit sum 0000
        .carry_out(),    // this gets ignored because of lookahead  
        .group_g(group_gblock[2]), // handles extra carry 
        .group_p(group_pblock[2])
    );
    
    cla_4bit b3( // next 4 bits 12 - 15
        .a(a[15:12]), //4 bit array for output of partial full adder being 0000
        .b(b[15:12]),
        .carry_in(local_carry_block[2]),
        .s(s[15:12]), // 4 bit sum 0000
        .carry_out(),    // this gets ignored because of lookahead, no need to wait on other block to feed output
        .group_g(group_gblock[3]), // handles extra carry 
        .group_p(group_pblock[3])
    );
    
    // need to instantiate to keep the lookahead continuing to prevent bottleneck
    // we dont want the blocks waiting on one another, by converting each block to a single bit, the lookahead can continue
    // takes the whole group_gblock / group_pblock 4 bit block and carry in and computes local_carry_block(4 bits) in parallel
    cla_logic block_lookahead(
        .g(group_gblock),
        .p(group_pblock),
        .carry_in(carry_in),
        .c_out(local_carry_block),
        .group_g(),     // not needed as no larger adder than 16, no need to propogate / generate
        .group_p()  
    );
    
    // final carry outgoing into another block if there was one.
    assign carry_out = local_carry_block[3];
    
    
endmodule