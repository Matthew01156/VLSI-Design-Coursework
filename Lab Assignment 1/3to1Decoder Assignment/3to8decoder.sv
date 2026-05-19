// Name: Matthew Bernardino
// Date: 29 January 2026
// Class: ECPE 136
// Professor: Anshul
// Description: 3 to 8 decoder - A 3 bit input will activate one of 8 outputs (8 bits)

module decoder3to8 (
    
    input logic [2:0] ip, // create a 3 bit array for input variables   

    output logic [7:0] op // create an 8 bit array for output variables
);

    always_comb begin // use always comb to update as inputs change immidiately 
        
        case(ip) // case statement that compares the inputs executes the correct line of code for the output

            3'b000: op = 8'b0000_0001;  // ip=0 op=activate bit 0
            3'b001: op = 8'b0000_0010;  // ip=1 op=activate bit 1
            3'b010: op = 8'b0000_0100;  // ip=2 op=activate bit 2
            3'b011: op = 8'b0000_1000;  // ip=3 op=activate bit 3
            3'b100: op = 8'b0001_0000;  // ip=4 op=activate bit 4
            3'b101: op = 8'b0010_0000;  // ip=5 op=activate bit 5
            3'b110: op = 8'b0100_0000;  // ip=6 op=activate bit 6
            3'b111: op = 8'b1000_0000;  // ip=7 op=activate bit 7

            default: op = 8'b0000_0000; // set a default case for error handleing

        endcase
    end
endmodule