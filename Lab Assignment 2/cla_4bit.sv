// Matthew Bernardino
// ECPE 136
// Professor Anshul
// Description: cla 4bit - instantiate 4 partial full adders and connect to carry look ahead logic setup in cla_logic.sv
// Each partial full adder with compute the generate and propogate signals
// all generate and propogate go into the cla_logic for all 4 carries. this is done in parallel making it faster, a final sum is created with the groups

module cla_4bit(
    // setup 4 bit input variables a/b
    input logic [3:0] a,
    input logic [3:0] b,
    input logic carry_in, 
    
    // setup our output variables that connect to prevous scripts
    output logic [3:0] s, // sum 4 bit output
    output logic group_g, //group_g 4 bit from cla logic 
    output logic group_p, //group_p 4 bit from cla logic 
    output logic carry_out
);

// create variables to connect to cla logic from cla_logic.sv
    logic [3:0] generate_s; // generate array for g[0] - g[3]
    logic [3:0] propogate_s; // propogate array for p[0] - p[3]
    logic [3:0] local_carry; // array of carries that go from partial adder to partial adder
    
    // instantiate 4 partial full adders that calculate each bit position 0000 from partial_adder.sv
    //a and b computation that determines g an p for each partial adder to create a 4 bit number in parallel
    partial_fulladder bit0(
        .a(a[0]),
        .b(b[0]),
        .carry_in(carry_in), // first carry
        .g(generate_s[0]),
        .p(propogate_s[0]),
        .s(s[0])
    );
    partial_fulladder bit1(
        .a(a[1]),
        .b(b[1]),
        .carry_in(local_carry[0]), // carry from cla_logic
        .g(generate_s[1]),
        .p(propogate_s[1]),
        .s(s[1])
    );

    partial_fulladder bit2(
         .a(a[2]),
         .b(b[2]),
         .carry_in(local_carry[1]), // carry from cla_logic
         .g(generate_s[2]),
         .p(propogate_s[2]),
         .s(s[2])
    );

    partial_fulladder bit3(
          .a(a[3]),
          .b(b[3]),
          .carry_in(local_carry[2]), // carry from cla_logic
          .g(generate_s[3]),
          .p(propogate_s[3]),
          .s(s[3])
    );
    
    // need to instantiate the cla logic from cla_logic.sv
    // take all g and p and calculate all carries simultaneously
    
    cla_logic lookahead_cla(
        .g(generate_s),
        .p(propogate_s),
        .carry_in(carry_in),
        .c_out(local_carry),
        .group_g(group_g),
        .group_p(group_p)
    );

    assign carry_out = local_carry[3]; // final output is the carry out of bit 3, gets used as the next carry input for the next 4 bit block when making 16 bit total cla.

endmodule