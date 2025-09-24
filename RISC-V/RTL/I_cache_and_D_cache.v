
////////////data memory////////
module D_cache #(
		parameter  ADD_WIDTH = 18,
		parameter      DEPTH = (2**ADD_WIDTH)/4
	)(
	input clk,reset,
	
	input  [31:0] addr,
	output [31:0] rdata,
	input  [ 3:0] wen,
	input  [31:0] wdata
);
	
	reg [31:0] mem [0:DEPTH-1];

//wire [31:0]data_at_address; 


initial $readmemh("./memory.hex",mem);// for sever
//initial $readmemh("D:/RISC V/memory.hex",mem);// for pc
//// ----------------------		Read Channel		-------------------- ////
	
	wire [ADD_WIDTH-3:0] mem_add   = addr[ADD_WIDTH-1:2] ;
	wire [31:0]          mem_rdata;
	
	assign  mem_rdata= mem[mem_add] ;
	
	assign rdata = mem_rdata;
	
// ----------------------		Write Channel		-------------------- ////
	
	wire [31:0] wdata1;
	assign wdata1[31:24] = (wen[3]) ? wdata[31:24] : mem_rdata[31:24];
	assign wdata1[23:16] = (wen[2]) ? wdata[23:16] : mem_rdata[23:16];
	assign wdata1[15: 8] = (wen[1]) ? wdata[15: 8] : mem_rdata[15: 8];
	assign wdata1[ 7: 0] = (wen[0]) ? wdata[ 7: 0] : mem_rdata[ 7: 0];
	
	always@(posedge clk) if( !reset & wen!=3'b000 ) mem[mem_add] <= wdata1;


//assign data_at_address = mem[192508];
	
endmodule
	





  
	//////////cache memory
	
module I_cache #(
		parameter  ADD_WIDTH = 17,
		parameter      DEPTH = (2**ADD_WIDTH)/4
	)(
	input clk,reset,
	input  [31:0] addr,
	output reg [31:0] rdata
	
);
    
	reg [31:0] mem [0:DEPTH-1];
	
	
initial $readmemh("./memory.hex",mem); // for sever
//initial $readmemh("D:/RISC V/memory.hex",mem);
	
//// ----------------------		Read Channel		-------------------- ////
	
	wire [ADD_WIDTH-3:0] mem_add   = addr[ADD_WIDTH-1:2] ;
	wire [31:0]          mem_rdata = mem[mem_add] ;
	
	 
	always@(posedge clk) begin
	  if   (reset) rdata <= 32'd0;
//	  else if(addr==32'h00000000) rdata <= 32'd0;
	  else         rdata <= mem_rdata;
	end

	
		


endmodule


