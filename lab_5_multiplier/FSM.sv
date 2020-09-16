module FSM(input logic Clk, Reset, Run, ClearA_LoadB,
           output logic Clr_Ld, Shift, Add, Sub, ClearA);

    enum logic [4:0] {A,clean, B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R} curr_state, next_state;

    always_ff @ (posedge Clk or posedge Reset)  
    begin
        if (Reset)  // Asynchronous Reset 
            curr_state <= A;   // A is the reset/start state
        else 
            curr_state <= next_state;
    end


    // Assign outputs based on state
	always_comb
    begin
        
		next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            A :    if (Run)
                       next_state = clean;
				clean: next_state = B;
            B :    next_state = C;
            C :    next_state = D;
            D :    next_state = E;
            E :    next_state = F;
            F :    next_state = G;
            G :    next_state = H;
            H :    next_state = I;
            I :    next_state = J;
            J :    next_state = K;
            K :    next_state = L;
            L :    next_state = M;
            M :    next_state = N;
            N :    next_state = O;
            O :    next_state = P;
            P :    next_state = Q;
            Q :    next_state = R;
            R :    if (~Run) 
                       next_state = A;
							  
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   A:                   // initial state
	         begin
                Clr_Ld = ClearA_LoadB;
					 ClearA = 1'b0;
                Shift = 1'b0;
                Add = 1'b0;
                Sub = 1'b0;
		      end
				clean:
				begin
               Clr_Ld = 1'b0;
					ClearA = 1'b1;
					Shift = 1'b0;
               Add = 1'b0;
               Sub = 1'b0;
				end
	   	   R:                   // final state
		      begin
                Clr_Ld = 1'b0;
					 ClearA = 1'b0;
                Shift = 1'b0;
                Add = 1'b0;
                Sub = 1'b0;
		      end
		   B, D, F, H, J, L, N: // add state
		      begin
		        Clr_Ld = 1'b0;
				   ClearA = 1'b0;
                Shift = 1'b0;
                Add = 1'b1;
                Sub = 1'b0;
		      end
		   P:                   // subtract state
		      begin
		        Clr_Ld = 1'b0;
				   ClearA = 1'b0;
                Shift = 1'b0;
                Add = 1'b0;
                Sub = 1'b1;
		      end
	   	   default:                // shift state
		      begin 
                Clr_Ld = 1'b0;
					 ClearA = 1'b0;
                Shift = 1'b1;
                Add = 1'b0;
                Sub = 1'b0;
		      end
        endcase
    end

endmodule