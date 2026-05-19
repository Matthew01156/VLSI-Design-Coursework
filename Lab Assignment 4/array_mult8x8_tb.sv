`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 02/18/2026 10:47:21 AM
// Module Name: array_mult8x8_tb
//////////////////////////////////////////////////////////////////////////////////
// Matthew Bernardino
// professor Anshul
// ECPE 136
// 8x8 Array Multiplier testbench

module array_mult8x8_tb();
    // variable setup and output setup
    reg [7:0] A;
    reg [7:0] B; 
    wire [15:0] P_decimal;
    wire [15:0] P_hexa;
    
    
    // instantiate inputs/outputs to top level 
    array_multiplier8x8 mult8x8_inst(.A(A), .B(B), .P(P_hexa));
    // i want to show both hexa and decimal values in waveform for ease of reading
    assign P_decimal = P_hexa;
    
    initial begin
        // start both inputs at 0
        A = 8'h00;
        B = 8'h00;
        #10; // delay
        
        // inputs both 0 should have ouput 0 or 0x0000
        A = 8'h00;
        B = 8'h00;
        #10; // delay 
        
        // 255 x 0 should output 0 or 0x0000
        A = 8'hFF;
        B = 8'h00;
        #10; // delay        
        
        // 0 x 255 should output 0 or 0x0000
        A = 8'h00;
        B = 8'hFF;
        #10; // delay  
        
        // 1 x 1 should output 1 or 0x0001
        A = 8'h01;
        B = 8'h01;
        #10; // delay    
        
        // 2 x 3 should output 6 or 0x0006
        A = 8'h02;
        B = 8'h03;
        #10; // delay
        
        // 15 x 2 should output 30 or 0x001E
        A = 8'h0F;
        B = 8'h02;
        #10; // delay
        
        // 10 x 10 should output 100 or 0x0064
        A = 8'h0A;
        B = 8'h0A;
        #10; // delay
        
        // 64 x 4 should output 256 0x0100
        A = 8'h40;
        B = 8'h04;
        #10;
        
        // 255 x 255 should output 65025 or 0xFE01
        A = 8'hFF;
        B = 8'hFF;
        #10; // delay
        
        #20 $finish;
             
    end 
    // Monitor output, added the same output to have both hexadecimal and decimal to compare easily
    always @(A, B, P_decimal, P_hexa)
        $monitor("Time=%0t ns, A=%0d, B=%0d, P_decimal=%0d,P_hexa=0x%h", $time, A, B, P_decimal, P_hexa);
    
endmodule
