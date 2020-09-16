module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
     
	  logic p_0, p_4, p_8, p_12;
	  logic g_0, g_4, g_8, g_12;
	 
	  four_bit_la FLA0(.x(A[3:0]), .y(B[3:0]), .cin(0), .s(Sum[3:0]), .p_group(p_0), .g_group(g_0));
	  four_bit_la FLA1(.x(A[7:4]), .y(B[7:4]), .cin(g_0), .s(Sum[7:4]), .p_group(p_4), .g_group(g_4));
	  four_bit_la FLA2(.x(A[11:8]), .y(B[11:8]), .cin(g_4 | g_0&p_4), .s(Sum[11:8]), .p_group(p_8), .g_group(g_8));
	  four_bit_la FLA3(.x(A[15:12]), .y(B[15:12]), .cin(g_8 | g_4&p_8 | g_0&p_8&p_4), .s(Sum[15:12]), .p_group(p_12), .g_group(g_12));

	  assign CO = g_12 | g_8&p_12 | g_4&p_12&p_8 | g_0&p_12&p_8&p_4;
	  
endmodule


module full_adder_la (input x, y, z,
	output s, p, g);
	assign s = x^y^z;
	assign p = x^y;
	assign g = x&y;

endmodule

module four_bit_la(
		input [3:0] x, input [3:0] y, input cin,
		output logic [3:0] s, output logic p_group, output logic g_group);
		
	logic [3:0] p;
	logic [3:0] g;
	
	full_adder_la fa0(.x(x[0]), .y(y[0]), .z(cin), .s(s[0]), .p(p[0]), .g(g[0]));
	full_adder_la fa1(.x(x[1]), .y(y[1]), .z(cin&p[0] | g[0]), .s(s[1]), .p(p[1]), .g(g[1]));
	full_adder_la fa2(.x(x[2]), .y(y[2]), .z(cin&p[0]&p[1] | g[0]&p[1] | g[1]), .s(s[2]), .p(p[2]), .g(g[2]));
	full_adder_la fa3(.x(x[3]), .y(y[3]), .z(cin&p[0]&p[1]&p[2] | g[0]&p[1]&p[2] | g[1]&p[2] | g[2]), .s(s[3]), .p(p[3]), .g(g[3]));
	
	assign p_group = p[0]&p[1]&p[2]&p[3];
	assign g_group = g[3] | g[2]&p[3] | g[1]&p[3]&p[2] | g[0]&p[3]&p[2]&p[1];
	
endmodule