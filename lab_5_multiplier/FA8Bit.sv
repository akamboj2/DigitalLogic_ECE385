module FA8Bit
(
    input   logic[8:0]     A,
    input   logic[8:0]     Bin,
    output  logic[8:0]     Sum,
    input   logic           fn,
    output  logic           CO
);

	  logic c0,c1;
	  logic[8:0] B;
	  
	  always_comb
	  begin
	    if (fn)
	        B = ~ Bin + 9'b001;
	    else
	        B = Bin;
	  end
	  
	  four_bit_ra FRA0(.x(A[3:0]), .y(B[3:0]), .cin(0), .s(Sum[3:0]), .cout(c0));
	  four_bit_ra FRA1(.x(A[7:4]), .y(B[7:4]), .cin(c0), .s(Sum[7:4]), .cout(c1));
	  full_adder FA_0(.x(A[8]), .y(B[8]), .z(c1), .s(Sum[8]), .c(CO));
	 // four_bit_ra FRA2(.x(A[11:8]), .y(B[11:8]), .cin(c1), .s(Sum[11:8]), .cout(c2));
	 // four_bit_ra FRA3(.x(A[15:12]), .y(B[15:12]), .cin(c2), .s(Sum[15:12]), .cout(COC0));

     
endmodule

module full_adder (input x, y, z,
	output s, c);
	assign s = x^y^z;
	assign c = (x&y)|(y&z)|(x&z);

endmodule

module four_bit_ra(
		input [3:0] x, input [3:0] y, input cin,
		output logic [3:0] s, output logic cout);
		
	logic c0, c1, c2;
	
	full_adder fa0(.x(x[0]), .y(y[0]), .z(cin), .s(s[0]), .c(c0));
	full_adder fa1(.x(x[1]), .y(y[1]), .z(c0), .s(s[1]), .c(c1));
	full_adder fa2(.x(x[2]), .y(y[2]), .z(c1), .s(s[2]), .c(c2));
	full_adder fa3(.x(x[3]), .y(y[3]), .z(c2), .s(s[3]), .c(cout));
	
endmodule