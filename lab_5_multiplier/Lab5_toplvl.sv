
module Lab5_toplvl
(
    input   logic           Clk,        // 50MHz clock is only used to get timing estimate data
    input   logic           Reset,      // From push-button 0.  Remember the button is active low (0 when pressed)
    input   logic           ClearA_LoadB,      // From push-button 2
    input   logic           Run,        // From push-button 3.
    input   logic[7:0]      S,         // From slider switches
    
    // all outputs are registered
//    output  logic           CO,         // Carry-out.  Goes to the green LED to the left of the hex displays.
//    output  logic[15:0]     Sum,        // Goes to the red LEDs.  You need to press "Run" before the sum shows up here.
    // output  logic[6:0]      Ahex0,      // Hex drivers display both inputs to the adder.
    // output  logic[6:0]      Ahex1,
    // output  logic[6:0]      Ahex2,
    // output  logic[6:0]      Ahex3,
    // output  logic[6:0]      Bhex0,
    // output  logic[6:0]      Bhex1,
    // output  logic[6:0]      Bhex2,
    // output  logic[6:0]      Bhex3,
    output  logic[6:0]      AhexL,
    output  logic[6:0]      AhexU,
    output  logic[6:0]      BhexL,
    output  logic[6:0]      BhexU,
    output  logic[7:0]      Aval,
    output  logic[7:0]      Bval,
    output  logic           X
	 
);

    ///* Declare Internal Registers */
//    logic[7:0]     A;  // use this as an input to your adder
//    logic[7:0]     B;  // use this as an input to your adder
		logic[7:0]		A;
		logic[7:0]		B;
//		logic			X;
    
    /* Declare Internal Wires
     * Wheather an internal logic signal becomes a register or wire depends
     * on if it is written inside an always_ff or always_comb block respectivly */
    // logic[15:0]     Sum_comb;
    // logic           CO_comb;
    // logic[6:0]      Ahex0_comb;
    // logic[6:0]      Ahex1_comb;
    // logic[6:0]      Ahex2_comb;
    // logic[6:0]      Ahex3_comb;
    // logic[6:0]      Bhex0_comb;
    // logic[6:0]      Bhex1_comb;
    // logic[6:0]      Bhex2_comb;
    // logic[6:0]      Bhex3_comb;
    logic[6:0]      AhexL_comb;
    logic[6:0]      AhexU_comb;
    logic[6:0]      BhexL_comb;
    logic[6:0]      BhexU_comb;
    logic           X_comb;
    logic           CO_comb;
    // wires from FSM
    logic           Clr_Ld_wire;
    logic           Shift_wire;
    logic           Add_wire;
    logic           Sub_wire;
	 logic 				Clr_A_wire;
	 
	 logic[7:0]			FA_out;
	 
	 logic				FF_X_Q;
    
    // logic           ld_b_wire;
    
    
    ///* Behavior of registers A, B, Sum, and CO */
    // always_ff @(posedge Clk) begin
        
    //     if (!Clr_Ld_wire) begin
    //         A <= 8'h00;
    //         ld_b_wire <= 1;
            
            
    //         // Sum <= 16'h0000;
    //         // CO <= 1'b0;
    //     // end else if (!LoadB) begin
    //     //     // If LoadB is pressed, copy switches to register B
    //     //     B <= SW;
    //     // end else begin
    //     //     // otherwise, continuously copy switches to register A
    //     //     A <= SW;
    //     // end
        
    //     // // transfer sum and carry-out from adder to output register
    //     // // every clock cycle that Run is pressed
    //     // if (!Run) begin
    //     //     Sum <= Sum_comb;
    //     //     CO <= CO_comb;
    //     // end
    //     //     // else, Sum and CO maintain their previous values
        
    // end
    
    /* Decoders for HEX drivers and output registers
     * Note that the hex drivers are calculated one cycle after Sum so
     * that they have minimal interfere with timing (fmax) analysis.
     * The human eye can't see this one-cycle latency so it's OK. */
    always_ff @(posedge Clk) begin
        
        // Ahex0 <= Ahex0_comb;
        // Ahex1 <= Ahex1_comb;
        // Ahex2 <= Ahex2_comb;
        // Ahex3 <= Ahex3_comb;
        // Bhex0 <= Bhex0_comb;
        // Bhex1 <= Bhex1_comb;
        // Bhex2 <= Bhex2_comb;
        // Bhex3 <= Bhex3_comb;
        AhexL <= AhexL_comb;
        AhexU <= AhexU_comb;
        BhexL <= BhexL_comb;
        BhexU <= BhexU_comb;
		  
		  X <= FF_X_Q;
		  Aval <= A;
		  Bval <= B;
        
    end
    
    /* Module instantiation
	  * You can think of the lines below as instantiating objects (analogy to C++).
     * The things with names like Ahex0_inst, Ahex1_inst... are like a objects
     * The thing called HexDriver is like a class
     * Each time you instantate an "object", you consume physical hardware on the FPGA
     * in the same way that you'd place a 74-series hex driver chip on your protoboard 
     * Make sure only *one* adder module (out of the three types) is instantiated*/
	  
	  
	  FSM fsm(
	    //inputs to fsm
	    .Clk, 
	    .Reset(!Reset),
	    .Run(!Run),
	    .ClearA_LoadB(!ClearA_LoadB),
	    //outputs from fsm
        .Clr_Ld(Clr_Ld_wire),
        .Shift(Shift_wire),
        .Add(Add_wire), 
        .Sub(Sub_wire),
		  .ClearA(Clr_A_wire)
        );
        
    FA8Bit adder( //Note: this is a 9 bit adder, despite its name...
        //inputs to adder
        .A({A[7],A}),
        .Bin({S[7] & B[0], 8'(signed'(B[0])) & S}), //A + M*S
        .fn(Sub_wire), //are we not using Add_wire?
        //outputs from adder
        .Sum({X_comb,FA_out}),    // this might not work, might need to split this into a separate comb
        .CO(CO_comb)
    );
    
    shiftRegister SRA(
        //inputs to SRA
       .Clk, 
	    .Load(Add_wire | Sub_wire), 
		.Reset(Clr_Ld_wire | Clr_A_wire),  
		.Shift_En(Shift_wire), 
		.Shift_In(FF_X_Q),
		.D(FA_out),
        //outputs from SRA
        .Data_Out(A)
							);
							
    shiftRegister SRB(
        //inputs to SRA
        .Clk, 
	    .Load(Clr_Ld_wire), 
		.Reset(!Reset),  
		.Shift_En(Shift_wire), 
		.Shift_In(A[0]),
		.D(S),
        //outputs from SRA
        .Data_Out(B)
							);
	  
	Dreg FF_X(
		//inputs
		.Clk, 
		.Load(Add_wire | Sub_wire), 
		.Reset(!Reset), 
		.D(X_comb),
      //outputs
		.Q(FF_X_Q)
		);
				  
// 	 ripple_adder ripple_adder_inst
//     (
//         .A,             // This is shorthand for .A(A) when both wires/registers have the same name
//         .B,
//         .Sum(Sum_comb), // Connects the Sum_comb wire in this file to the Sum wire in ripple_adder.sv
//         .CO(CO_comb)
//     );
	 
//    carry_lookahead_adder carry_lookahead_adder_inst
//    (
//        .A,             // This is shorthand for .A(A) when both wires/registers have the same name
//        .B,
//        .Sum(Sum_comb), // Connects the Sum_comb wire in this file to the Sum wire in ripple_adder.sv
//        .CO(CO_comb)
//    );

//    carry_select_adder carry_select_adder_inst
//    (
//        .A,             // This is shorthand for .A(A) when both wires/registers have the same name
//        .B,
//        .Sum(Sum_comb), // Connects the Sum_comb wire in this file to the Sum wire in ripple_adder.sv
//        .CO(CO_comb)
//    );
    
    HexDriver AhexL_inst
    (
        .In0(A[3:0]),   // This connects the 4 least significant bits of 
                        // register A to the input of a hex driver named Ahex0_inst
        .Out0(AhexL_comb)
    );
    
    HexDriver AhexU_inst
    (
        .In0(A[7:4]),
        .Out0(AhexU_comb)
    );
    
    HexDriver BhexL_inst
    (
        .In0(B[3:0]),
        .Out0(BhexL_comb)
    );
    
    HexDriver BhexU_inst
    (
        .In0(B[7:4]),
        .Out0(BhexU_comb)
    );
    
endmodule

