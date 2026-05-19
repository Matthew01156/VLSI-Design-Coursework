`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2026 02:40:29 PM
// Design Name: 
// Module Name: alu_8bit_tb
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
// Description: test bench to test inputs A and B as well as Control selecting each opcode

module alu_8bit_tb();
    // Variable setup input and output
    reg [7:0] A;
    reg [7:0] B;
    reg [2:0] Control;
    reg Cin;
    wire [7:0] Output;
    wire Cout;
    
    ////instantiate the design module and connect the variable declared above
    alu_8bit alu_inst(.A(A), .B(B), .Control(Control), .Cin(Cin), .Output(Output), .Cout(Cout));
    
    // Edge case testing
    initial begin
    
    // start all inputs at 0 
        A = 8'h00;
        B = 8'h00;
        Cin = 1'b0; 
        Control = 3'b000;
        
        #10; //delay for operation start
        
// ADD = Control 000
        // simple add 2 + 3
        Control = 3'b000;
        A = 8'h02;
        B = 8'h03;
        Cin = 1'b0;
        #10; //delay until next inputs
        
        // focus on A being the FF or 01
        // edge case 0 + 15
        A = 8'h00;
        B = 8'h0F;
        Cin = 1'b0;
        #10;
        
        // edge case FF 255 + 1, should show cout = 1 output = 0
        A = 8'hFF;
        B = 8'h01;
        Cin = 1'b0;
        #10; 
        
        // focus on B being the FF or 01
        // edge case 0 + 15
        B = 8'h00;
        A = 8'h0F;
        Cin = 1'b0;
        #10;
        
        // edge case FF 255 + 1, should show cout = 1 output = 0
        B = 8'hFF;
        A = 8'h01;
        Cin = 1'b0;
        #10; 
        
        // add a and b and add in carry in 1 + 3 + 1 = 5
        A = 8'h01;
        B = 8'h03;
        Cin = 1'b1;
        #10; 
        
        // add a and b and add in carry in 255 + 255 + 1 = 511 , carry out 1, overflow case, 
        A = 8'hFF;
        B = 8'hFF;
        Cin = 1'b1;
        #10; 
    
// Subtraction Cases Control: 001
    // simple add 2 - 3 = 1
        Control = 3'b001;
        A = 8'h03;
        B = 8'h02;
        Cin = 1'b0;
        #10; //delay until next inputs
        
        // focus on A being the FF or 01
        // edge case 0 - 5 = - 5 have Cout = 1 for borrow/ - indicator, goes to 251
        A = 8'h00;
        B = 8'h05;
        Cin = 1'b0;
        #10;
        
        // edge case FF 255 - 1 = 254, should show cout = 0
        A = 8'hFF;
        B = 8'h01;
        Cin = 1'b0;
        #10; 
        
        // focus on B being the FF or 01
        // edge case 10 - 0 = 10 0x0A 
        A = 8'h0A;
        B = 8'h00;
        Cin = 1'b0;
        #10;
        
        // edge case FF 5 - 255 = -250, should show cout = 1 borrow output = 6 (0x06) wraps
        A = 8'h05;
        B = 8'hFF;
        Cin = 1'b0;
        #10; 
        
        // sub 3 - 1 - 1 = 1, carry in adds extra -1
        A = 8'h03;
        B = 8'h01;
        Cin = 1'b1;
        #10; 
        
        // overflow: sub 0 - 1 - 1 = -2 = 254 0xFE with Cout = 1 barrow for negative result
        A = 8'h00;
        B = 8'h01;
        Cin = 1'b1;
        #10; 

// OR Operation Examples Control: 010
        Control = 3'b010;
        A = 8'hAA;  // 10101010 or 01010101 = 11111111 0xFF 
        B = 8'h55;
        Cin = 1'b0;
        #10; //delay until next inputs
        
        A = 8'h00;  // 00000000 or 11110000 = 11110000 0xF0
        B = 8'hF0;
        #10; //delay until next inputs
        
        A = 8'hFF;  // 11111111 or 00001111 = 11111111 0xFF
        B = 8'h0F;
        #10; //delay until next inputs
        
        A = 8'h00;  // 00000000 or 010101010 = 010101010 0xAA
        B = 8'hAA;
        #10; //delay until next inputs
        
        A = 8'h55;  // 01010101 or 10101010 = 11111111 0xFF 
        B = 8'hAA;
        Cin = 1'b0;
        #10; //delay until next inputs
        
// AND Operation Examples Control: 011
        Control = 3'b011;
        A = 8'hAA;  // 10101010 and 01010101 = 00000000 0x00 
        B = 8'h55;
        Cin = 1'b0;
        #10; //delay until next inputs
        
        A = 8'hF0;  // 11110000 and 10101010 = 10100000 0xA0 
        B = 8'hAA;
        #10; //delay until next inputs
        
        A = 8'h55;  // 01010101 and 11111111 = 01010101 0x55 
        B = 8'hFF;
        #10; //delay until next inputs

// SHL Operation Examples Control: 100 // only take one input to shift
        Control = 3'b100;
        A = 8'hAA;  // (170) 10101010 shift left A = 01010100 (84)
        B = 8'h00; // stays 0 not used only input A
        Cin = 1'b0;
        #10; //delay until next inputs   
        
        A = 8'h00;  // 00000000 shift left = 00000000, sanity check
        #10;
        
        A = 8'hFF;  // 11111111 shift left = 11111110
        #10;
        
        A = 8'hF0;  // 11110000 shift left = 11100000 // 
        #10;
        
// SHR Operation Examples Control: 101 // only take one input to shift
        Control = 3'b101;
        A = 8'hAA;  // (170) 10101010 shift right A = 01010101 0x55 
        B = 8'h00; // stays 0 not used only input A
        Cin = 1'b0;
        #10; //delay until next inputs   
        
        A = 8'h00;  // 00000000 shift right = 00000000, sanity check
        #10;
        
        A = 8'hFF;  // 11111111 shift right = 01111111
        #10;
        
        A = 8'hF0;  // 11110000 shift right = 01111000 
        #10;
             
//ROL Operation Examples Control: 110 MSB wrapts to LSB 
        Control = 3'b110;
        A = 8'hAA;  //10101010 rotate left = 01010101 0x55
        B = 8'h00; // stays 0 not used only input A
        Cin = 1'b0;
        #10; //delay until next inputs  
          
        A = 8'hFF; // 11111111 rotate left = 11111111  same
        #10; //delay until next inputs    
        
        A = 8'h80; // 10000000 rotate left = 00000001 
        #10; //delay until next inputs 
        
//ROR Operation Examples Control: 111 LSB wrapts to MSB 
        Control = 3'b111;
        A = 8'hAA;  // 10101010 rotate right = 01010101 0x55
        B = 8'h00; // stays 0 not used only input A
        Cin = 1'b0;
        #10; //delay until next inputs  
          
        A = 8'hFF; // 11111111 rotate right = 11111111  same
        #10; //delay until next inputs    
        
        A = 8'h01; // 00000001 rotate right = 10000000 = 0x80
        #10; //delay until next inputs 
        
        #20 $finish;
              
    end

    // Monitor output
    always @(A, B, Cin, Control, Output, Cout)
        $monitor("Time=%0t ns, Control=%b, A=0x%h, B=0x%h, Cin=%b, Output=0x%h, Cout=%b", $time, Control, A, B, Cin,Output, Cout);

endmodule
