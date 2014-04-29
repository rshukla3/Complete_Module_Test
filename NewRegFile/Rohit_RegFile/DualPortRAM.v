// Timescale definition
`timescale	1ns/1ps

// Include listing

// Dual Port RAM module ports declaration
module DualPortRAM #(
	// External parameters
	parameter	DATA_WIDTH		= 32,
	parameter	ADDR_WIDTH		= 5
)
(
	// Outputs
	output		[DATA_WIDTH-1:0]	oDataA,
	output		[DATA_WIDTH-1:0]	oDataB,

	// Inputs
	input		[DATA_WIDTH-1:0]	iDataA,
	input		[ADDR_WIDTH-1:0]	iAddrA,
	input							iEnA,
	input							iWeA,
	input							iClkA,
	input		[DATA_WIDTH-1:0]	iDataB,
	input		[ADDR_WIDTH-1:0]	iAddrB,
	input							iEnB,
	input							iWeB,
	input							iClkB,
	input							iRst_n
);

	// Internal signals declaration
	reg		[DATA_WIDTH-1:0]	ram[(2**ADDR_WIDTH)-1:0];
	
	//initial
	//	ram[0] = {DATA_WIDTH{1'b0}};
	
	assign oDataA = (iEnA) ? ram[iAddrA] : 32'd0;
	assign oDataB = (iEnA) ? ram[iAddrB] : 32'd0;

	// Internal signals assignment
	always @ (posedge iClkA) begin		// Port A: Clock A logic
		if (iEnA) begin			
			if (iWeA)
				ram[iAddrA] <= iDataA;	// Port A: Write logic
//			else
//				oDataA <= ram[iAddrA];		// Port A: Read logic
		end
	end

	always @ (posedge iClkB) begin		// Port B: Clock B logic
		if (iEnB) begin			
			if (iWeB)
				ram[iAddrB] <= iDataB;	// Port B: Write logic
//			else
//				oDataB <= ram[iAddrB];		// Port B: Read logic
		end
	end
endmodule
