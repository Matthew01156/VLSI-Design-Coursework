// Name: Matthew Bernardino
// Date: 29 January 2026
// Class: ECPE 136
// Professor: Anshul
// Description: 16 to 1 mux

module mux16to1 (

// setup 16 inputs for mux
    input logic ip0, ip1, ip2, ip3, 
    input logic ip4, ip5, ip6, ip7,
    input logic ip8, ip9, ip10, ip11,
    input logic ip12, ip13, ip14, ip15,

// setup 4 select signal inputs for 2^4 = 16, 4 bits for 16 values
    input logic [3:0] selection, // tells what inputs go through as output

// 16:1 mux has 1 output
    output logic op

);

    always_comb begin // use to update logic immediately after input changes
    // make a case for selection to associate to an output in binary
    // selection can be values from 0-15 
        case (selection)  // ex: selection = 0 = 0000
            
            // associate all inputs with all binary value of 0 to 15
            // when the selection signal is equal to a binary value, the output displays the corresponding input
            4'd0: op = ip0;   // sets 4 bit decimal to binary, 0 = 0000
            4'd1: op = ip1; 
            4'd2: op = ip2;
            4'd3: op = ip3;
            4'd4: op = ip4;
            4'd5: op = ip5;
            4'd6: op = ip6;
            4'd7: op = ip7;
            4'd8: op = ip8;
            4'd9: op = ip9;
            4'd10: op = ip10;
            4'd11: op = ip11;
            4'd12: op = ip12;
            4'd13: op = ip13;
            4'd14: op = ip14;
            4'd15: op = ip15;   // 4 bit decimal to binary 15 = 1111

            default: op = 1'bx; // default statement for error handling says unknown
        endcase
    end
endmodule
