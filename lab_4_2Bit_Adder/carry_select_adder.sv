module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  logic c0, c1, c2, c3;
	  four_bit_csa FCSA0(.Ax(A[3:0]), .By(B[3:0]), .cin(0), .s(Sum[3:0]), .cout(c0));
	  four_bit_csa FCSA1(.Ax(A[7:4]), .By(B[7:4]), .cin(c0), .s(Sum[7:4]), .cout(c1));
	  four_bit_csa FCSA2(.Ax(A[11:8]), .By(B[11:8]), .cin(c1), .s(Sum[11:8]), .cout(c2));
	  four_bit_csa FCSA3(.Ax(A[15:12]), .By(B[15:12]), .cin(c2), .s(Sum[15:12]), .cout(c3));
	  
	  assign CO=c3;

     
endmodule

module four_bit_csa(input logic[3:0] Ax, input logic[3:0] By, input logic cin, output logic[3:0] s, output logic cout);

	logic[3:0] sum0,sum1;
	logic c0,c1;
	four_bit_ra FRA0(.x(Ax[3:0]), .y(By[3:0]), .cin(0), .s(sum0), .cout(c0));
	four_bit_ra FRA1(.x(Ax[3:0]), .y(By[3:0]), .cin(1), .s(sum1), .cout(c1));
	
	//implements gates
	assign cout = c0 | c1&cin;
	
	//implements mux operation
	assign s[3] = sum0[3]&(~cin) | sum1[3]&cin;
	assign s[2] = sum0[2]&(~cin) | sum1[2]&cin;
	assign s[1] = sum0[1]&(~cin) | sum1[1]&cin;
	assign s[0] = sum0[0]&(~cin) | sum1[0]&cin;

endmodule 