`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

module tb_riscv();

reg clk_in,
    rst_in,
    instr_hready_in;

reg hresp_in;
reg [63:0] rc_in;

reg data_hready_in,
    eirq_in,
    tirq_in,
    sirq_in;
    
wire dmwr_req_out;
wire [31:0] imaddr_out;
wire [1:0]  data_htrans_out;

wire [31:0] dmaddr_out;
wire [31:0] instr_in;
wire [31:0] dmdata_out;
wire [3:0]  dmwr_mask_out;
wire [31:0] dmdata_in;

rv32_top m1(clk_in,
              rst_in,
              rc_in,
              imaddr_out,
              instr_in,
              instr_hready_in,
              dmaddr_out,
              dmdata_out,
              dmwr_req_out,
              dmwr_mask_out,
              dmdata_in,
              data_hready_in,
              hresp_in,
              data_htrans_out,
              eirq_in,
              tirq_in,
              sirq_in);

I_cache im(clk_in,
           rst_in,
           imaddr_out,
           instr_in);
                        
D_cache dm(clk_in,
           rst_in,
           dmaddr_out,
           dmdata_in,
           dmwr_mask_out,
           dmdata_out);

always #5 clk_in = ~clk_in;

initial begin
    clk_in <= 1;
    rst_in <= 1;

    hresp_in <= 0;
    rc_in <= 64'b0;
    data_hready_in <= 1;
    eirq_in <= 0;
    tirq_in <= 0;
    sirq_in <= 0;

    instr_hready_in <= 1;

    #50
    rst_in <= 0;

    #5000
    //$stop();
    $finish();
end

endmodule







