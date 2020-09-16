module testbench();
timeunit 10ns;

timeprecision 1ns;

//	logic           Clk;    // 50MHz clock is only used to get timing estimate data
//    logic           Reset;      // From push-button 0.  Remember the button is active low (0 when pressed)
//    logic           LoadB;      // From push-button 1
//    logic           Run;        // From push-button 3.
//    logic[15:0]     SW;         // From slider switches
// 
// // all outputs are registered
//   logic           CO;        // Carry-out.  Goes to the green LED to the left of the hex displays.
//   logic[15:0]     Sum;        // Goes to the red LEDs.  You need to press "Run" before the sum shows up here.
//   logic[6:0]      Ahex0;      // Hex drivers display both inputs to the adder.
//   logic[6:0]      Ahex1;
//   logic[6:0]      Ahex2;
//   logic[6:0]      Ahex3;
//   logic[6:0]      Bhex0;
//   logic[6:0]      Bhex1;
//   logic[6:0]      Bhex2;
//   logic[6:0]      Bhex3;
	
//	 logic[8:0]     A;
//    logic[8:0]     Bin;
//    logic[8:0]     Sum;
//    logic           CO;
//	 logic			fn;
	 
//	 logic Load;
//	 logic Reset;  
//	 logic Shift_En; 
//	 logic Shift_In;
//	 logic[7:0] D;
//	 logic[7:0] Data_Out;

   logic           Clk;       // 50MHz clock is only used to get timing estimate data
   logic           Reset;      // From push-button 0.  Remember the button is active low (0 when pressed)
   logic           ClearA_LoadB;      // From push-button 1
   logic           Run;        // From push-button 3.
   logic[7:0]      S;         // From slider switches
	
    logic[6:0]      AhexL;
	 logic[6:0]      AhexU;
    logic[6:0]      BhexL;
    logic[6:0]      BhexU;
	 logic[7:0]      Aval;
    logic[7:0]      Bval;
    logic           X;
 
always begin : CLOCK_GENERATION
 
 #1 Clk = ~Clk;

end
 
initial begin : CLOCK_INITIALIZATION
	Clk = 0;
end

//lab4_adders_toplevel tp(.*);
//FA8Bit RA(.*);
//shiftRegister SR(.*);
Lab5_toplvl tl(.*);

initial begin : TEST_VECTORS

#2 Reset = 1;
#2 ClearA_LoadB = 1;
#2 Run 	= 1;


#2 Reset = 0;
#2 Reset = 1;
#2 S = 8'b11000101; //-59
#2 ClearA_LoadB = 0;
#2 ClearA_LoadB = 1;
#2 S = 8'b00000111; //7
#2 Run = 0;
#2 Run = 1;


#100;

#2 Reset = 0;
#2 Reset = 1;
#2 S = 8'hFE; //-2
#2 ClearA_LoadB = 0;
#2 ClearA_LoadB = 1;
#2 S = 8'h03; //3
#2 Run = 0;
#2 Run = 1;


#100;

#2 Reset = 0;
#2 Reset = 1;
#2 S = 8'h05; //5
#2 ClearA_LoadB = 0;
#2 ClearA_LoadB = 1;
#2 S = 8'h01; //1
#2 Run = 0;
#2 Run = 1;

#100;

#2 Reset = 0;
#2 Reset = 1;
#2 S = 8'b11111100; //-4
#2 ClearA_LoadB = 0;
#2 ClearA_LoadB = 1;
#2 S = 8'b11111000; //-8
#2 Run = 0;
#2 Run = 1;

//
//
//#100;
//
//#2 Reset = 1;
//#2 Reset = 0;
//#2 S = 8'hFE; //-2
//#2 ClearA_LoadB = 1;
//#2 ClearA_LoadB = 0;
//#2 S = 8'h03; //3
//#2 Run = 1;
//#2 Run = 0;
//
//
//#100;
//
//#2 Reset = 1;
//#2 Reset = 0;
//#2 S = 8'h02; //2
//#2 ClearA_LoadB = 1;
//#2 ClearA_LoadB = 0;
//#2 S = 8'hFD; //-3
//#2 Run = 1;

/*Shift Register Test*/
//#2 Reset = 1;
//#2 Reset = 0;
//#2 Load = 0;
//#2 Shift_In = 1;
//#2 Shift_En = 1;
//#2 D = 8'h00;
//#16
////now register should be filled with 1s (should be seen in Data_out)
//
//Shift_En = 0;
//D = 8'b01010101;
//#2
//Shift_En =0;
//#2 Load = 1;
//#2 Load = 0;
////now shift register should be filled with 01s
//#22;

/* ADDER TEST!*/
////test Adder
//#2 fn = 1;
//
//#2 A = 9'h0FA;
//#2 Bin = 9'h0F3;
//
//#22;

//
//
////test case1
//#2 Reset = 1;
// 
//#2 LoadB =0;
//	SW = 16'hFFFF;
//
//#2 LoadB = 1;
//	SW = 16'h0001;
//	
//#2 Run = 0;
//
//#22;


end

endmodule