module shiftRegister(input logic Clk, 
							input logic Load, 
							input logic Reset,  
							input logic Shift_En, 
							input logic Shift_In,
							input logic[7:0] D,
                     output logic[7:0] Data_Out
							);

    logic [7:0] Data_next;
    
    always_ff @ (posedge Clk) begin
    	Data_Out <= Data_next;  
    end
    
    always_comb begin
    Data_next = Data_Out;
    	if (Reset)             // Synchronous Reset
    		Data_next = 0;
    	else if (Load)
            Data_next = D;
        else if (Shift_En)
            Data_next = { Shift_In, Data_Out[7:1] };
    end
    
endmodule