`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:   	30 Jan 2014
// Design Name: 	SPART
// Module Name:    	top_level 
// Project Name: 	
// Target Devices: 	Xilinx Virtex 5
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// No Change in this module. Default code.
//////////////////////////////////////////////////////////////////////////////////
module spart_top_level(
    input clk,         // 100mhz clock
    input rst,         // Asynchronous reset, tied to dip switch 0
    output txd,        // RS232 Transmit Data
    input rxd,         // RS232 Receive Data
	
	// Clocks from DDR2 for ChipScope
//	input clk0_tb,    
//	input clk200_out,
	output [8:0] piso_out,
	output reg [31:0] spart_data_out,
	output reg [31:0] spart_data_in,
	output reg [31:0] spart_status,
	output reg [31:0] spart_addr,
	// Signals from/to SPART Cache interface
	input io_rw_data,
	input io_valid_data,
	output io_ready_data,
	input [27:0] mem_addr,
	output [31:0] io_rd_data,
	input [31:0] io_wr_data
    );
	
	wire iocs;
	wire iorw;
	wire rda;
	wire tbr;
	wire [1:0] ioaddr;
	wire [7:0] databus;
	
	wire spart_data_rden;
	wire spart_data_wren;
	wire data_rdy;
	wire [31:0] data_tx;
	wire [31:0] data_rx;
	wire [31:0] status_register;
	wire clear_status_rd;
	wire [31:0] data_to_chipscope_out;
	reg count;
	assign spart_data_rden = (~io_rw_data && io_valid_data);
	assign spart_data_wren = (io_rw_data && io_valid_data);
	
	assign io_rd_data = (mem_addr == 28'h800_0000) ? data_rx : ((mem_addr == 28'h800_0001) ? status_register : 28'd0);
	assign data_tx = io_wr_data;
	assign clear_status_rd = (mem_addr == 28'h800_0000) ? 1'b1 : 1'b0;
	assign io_ready_data = (spart_data_rden && count) ? data_rdy : ( (spart_data_wren && count) ? data_rdy : 1'b0 );
	
	always @(posedge clk)
	begin
		if(rst)
			spart_data_out <= 32'd0;
		else
		begin
			if(mem_addr == 28'h800_0000 && spart_data_rden)
				spart_data_out <= data_rx;
			else
				spart_data_out <= spart_data_out;
		end
	end
	
	always @(posedge clk)
	begin
		if(rst)
			spart_status <= 32'd0;
		else
			spart_status <= status_register;
	end
	
	always @(posedge clk)
	begin
		if(rst)
			spart_addr <= 32'd0;
		else
			spart_addr <= mem_addr;
	end
	
	always @(posedge clk)
	begin
		if(rst)
			spart_data_in <= 32'd0;
		else
			spart_data_in <= data_to_chipscope_out;
	end
	always @(posedge clk)
	begin
		if(rst)
		begin
			count <= 1'b0;
		end
		else
		begin
			if(spart_data_rden || spart_data_wren)
			begin
				count <= count + 1'b1;
			end
			else
			begin
				count <= 1'b0;
			end
		end
	end
	
	// Instantiate your SPART here
	spart spart0(	.clk(clk),
					.rst(rst),
					.iocs(iocs),
					.iorw(iorw),
					.rda(rda),
					.tbr(tbr),
					.ioaddr(ioaddr),
					.databus(databus),
					.txd(txd),
					.rxd(rxd),
					.piso_out(piso_out)
					);

	// Instantiate your driver here
	driver driver0( .clk(clk),
	                .rst(rst),
					.iocs(iocs),
					.iorw(iorw),
					.rda(rda),
					.tbr(tbr),
					.ioaddr(ioaddr),
					.databus(databus),
					
//					.clk0_tb(clk0_tb),
//					.clk200_out(clk200_out)
					.data_to_chipscope_out(data_to_chipscope_out),
					.data_rx(data_rx),
					.data_tx(data_tx),
					.status_register(status_register),
					.spart_data_wren(spart_data_wren),
					.spart_data_rden(spart_data_rden),
					.clear_status_rd(clear_status_rd),
					.data_rdy(data_rdy),
					.piso_out(piso_out)
					 );
					 
endmodule
