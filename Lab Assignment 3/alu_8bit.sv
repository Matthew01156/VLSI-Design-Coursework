`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2026 02:40:10 PM
// Design Name: 
// Module Name: alu_8bit
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
// ECPE 136
// Professor Anshul
// Description: Arithmatic logic unit that does math of 8 different operations, based on a 3 bit control signal
// control signal indicates operation

module alu_8bit(
// initialize given variables
    input logic [7:0] A, // 8 bit inputs A and B
    input logic [7:0] B,
    input logic Cin, // 1 bit, carry or no carry
    input logic [2:0] Control, // 3 bit control opcode
    output logic [7:0] Output, // 8 bit output
    output logic Cout // 1 bit, carry or no carry
    );
    
    // need to create internal signals that are 9 bits, adding 8 bit numbers can result in 9 bits with a carry
    logic [8:0] sum_add;
    logic [8:0] sum_sub;
    
    // use always_comb for combinational logic
    // make switch statement to check with new inputs always changing
    always_comb begin
        sum_add = A + B + Cin; // addition formula, if carry then 9 bits
        
        sum_sub = A - B - Cin; // subtraction formula, if borrow bit 
        
        // create default values, this prevents numbers from being remembered
        Output = 8'b0; // default output to 0 every new arthimetic
        Cout = 1'b0; // onlt a 1 or 0 for carry
        
        // use case statements for each arithemsitc operation
        case (Control)
            3'b000: begin // add operation
                Output = sum_add[7:0]; // take first 8 bits as addition result
                Cout = sum_add[8];  // carry 1 as 9th bit if there is one like edge cases
            end
            
            3'b001: begin // sub operation
                Output = sum_sub[7:0]; // take first 8 bits as subtraction result
                Cout = sum_sub[8];  // borrow out 1 as 9th bit if there is a negative result
            end
            
            3'b010: begin // OR operation
                Output = A | B; // Follows OR logic of 1 being dominant output. 
                Cout = 1'b0; // no carry in this logic
            end
            
            3'b011: begin // AND operation
                Output = A & B; // both inputs must be the same
                Cout = 1'b0; // no carry in this logic
            end
            
            3'b100: begin // SHL operation
                Output = {A[6:0], 1'b0}; // shift left logic, take the 7 bits and shift them left, LSB = 0 // 8th bit gets dropped
                Cout = 1'b0; // no carry in this logic
            end
            
            3'b101: begin // SHR operation
                Output = {1'b0, A[7:1]}; // shift right logic, take the 7 bits and shift them right, MSB = 0 // 0th bit gets dropped
                Cout = 1'b0; // no carry in this logic
            end
            
            3'b110: begin // ROL operation
                Output = {A[6:0], A[7]}; // Rotate left wraps the A[7] bit around to A[0], no bit loss 
                Cout = 1'b0; // no carry in this logic
            end
            
            3'b111: begin // ROR operation
                Output = {A[0], A[7:1]}; // Rotate right wraps the A[0] bit around to A[7], no bit loss  
                Cout = 1'b0; // no carry in this logic
            end
            
            // need default for case statement for any non control values, error catching
            default: begin
                Output = 8'bx; // sets all 8 bits to x as unknown, easy tell for error
                Cout = 1'b0;    // set carry out to 0, not used anyways
            end
                
        endcase   
        
    end

endmodule
