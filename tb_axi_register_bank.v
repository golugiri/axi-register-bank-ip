`timescale 1ns / 1ps

module tb_axi_register_bank();

    // Parameters
    parameter ADDR_WIDTH = 8;
    parameter DATA_WIDTH = 32;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg [ADDR_WIDTH-1:0] reg_addr;
    reg reg_wr_en;
    reg [DATA_WIDTH-1:0] reg_wr_data;
    wire [DATA_WIDTH-1:0] reg_rd_data;

    wire [31:0] control_reg_0;
    wire [31:0] control_reg_1;
    reg [31:0] status_reg_0;

    // Instantiate the Unit Under Test (UUT)
    axi_register_bank #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .reg_addr(reg_addr),
        .reg_wr_en(reg_wr_en),
        .reg_wr_data(reg_wr_data),
        .reg_rd_data(reg_rd_data),
        .control_reg_0(control_reg_0),
        .control_reg_1(control_reg_1),
        .status_reg_0(status_reg_0)
    );

    // Clock Generation (10ns period -> 50MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        reg_addr = 0;
        reg_wr_en = 0;
        reg_wr_data = 0;
        status_reg_0 = 32'hDEADBEEF; // Dummy status value

        // Apply Reset
        #20;
        rst_n = 1;
        #10;

        // Test 1: Write data to control_reg_0 (Address 8'h00)
        @(posedge clk);
        reg_addr = 8'h00;
        reg_wr_data = 32'h12345678;
        reg_wr_en = 1;

        // Test 2: Write data to control_reg_1 (Address 8'h01)
        @(posedge clk);
        reg_addr = 8'h01;
        reg_wr_data = 32'hCAFEBAB0;

        // Stop Writing
        @(posedge clk);
        reg_wr_en = 0;

        // Test 3: Read back from control_reg_0 (Address 8'h00)
        @(posedge clk);
        reg_addr = 8'h00;

        // Test 4: Read back status register (Address 8'h02)
        @(posedge clk);
        reg_addr = 8'h02;

        #20;
        $finish;
    end

    // Dump waveform for viewing
    initial begin
        $dumpfile("axi_register_bank.vcd");
        $dumpvars(0, tb_axi_register_bank);
    end

endmodule