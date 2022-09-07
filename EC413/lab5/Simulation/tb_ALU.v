`timescale 1ns / 1ns

module tb_ALU;
parameter size = 32;
	// Inputs
	reg [size-1:0] a;
	reg [size-1:0] b;
	reg [2:0] select;
	reg clk;

	// Outputs
	wire c_out;
	wire [size-1:0] result;
	wire c_out_verify;
	wire [size-1:0]result_verify;
	wire error_flag;

	// Instantiate the Unit Under Test (UUT)
	ALU_32bit #(size) uut (
		.c_out(c_out), 
		.result(result), 
		.a(a), 
		.b(b), 
		.select(select), 
		.clk(clk)
	);
	
	ALU_verification #(size) Verification (
		.c_out(c_out_verify), 
		.result(result_verify), 
		.a(a), 
		.b(b), 
		.select(select),
		.clk(clk)
	);
	
	// Assign Error_flag
	assign error_flag = (c_out != c_out_verify || result != result_verify);
	
	// Verification logic
	always@(posedge clk)
		begin
		if(error_flag)
			$display("Error occurs when a = %d, b = %d, c_in = %d\n", a, b, select);
		end
		

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		select = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		//Move
		#20;
		a = 343455;
		b = 10;
		select = 0;
		
		//NOT
		#20;
		a = 7;
		b = 0;
		select = 1;
		
		//ADD
		#20;
		a = 32'b11111111111111111111111111111110;
		b = 1;
		select = 6;
		
		#20;
		a = 32'b11111111111111111111111111111111;
		b = 1;
		select = 6;
		
		#20;
		a = 78;
		b = 3432;
		select = 6;

		#20;
		a = -6;
		b = 5;
		select = 6;
		
		//SUB
		#20;
		a = 10;
		b = 10;
		select = 5;
		
		#20;
		a = 7;
		b = 10;
		select = 5;
		
		#20;
		a = 52;
		b = 3;
		select = 5;

		#20;
		a = 8003434;
		b = 452;
		select = 5;
		
		//OR
		#20;
		a = 3423;
		b = 1000;
		select = 4;
		
		//AND
		#20;
		a = 4463;
		b = 2122;
		select = 3;
	end
	
      always
	#5 clk = ~clk;
	
endmodule

