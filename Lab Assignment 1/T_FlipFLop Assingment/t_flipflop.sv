// Name: Matthew Bernardino
// Date: 29 January 2026
// Class: ECPE 136
// Professor: Anshul
// Description: t-flip flop - toggles its output for every signal received changing

module t_flipflop (
    
    // need a positive edge for the clk implementation, need to reset for output q, t for flip flop 0 / 1
    input logic clock, 
    input logic reset,
    input logic t,

    output logic q, not_q   // output q and not_q for inverted q
);

    always_ff @(posedge clock or negedge reset) begin   // use always_ff for sequential logic and updates only on positive edge of clock

        if(!reset) begin // want to set output to 0 when reset is low. want immediately and update q output on positive clock edge
            q <= 1'b0;   // used non-blocking assignment to update on positive edge of clock and setup output q register of clock
        end

        // positive edge clock normal flip flop
        else begin 

            if(t) begin

                q <= ~q; // want to toggle t=1 then 0 turns into 1, and 1 to 0, t=0 keep state

            end
            else begin
                q <= q;  // want to keep the same value
            end
        end
    end

    assign not_q = ~q; // stores opposite value as output variable. 

endmodule