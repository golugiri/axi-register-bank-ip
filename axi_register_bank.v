module axi_register_bank #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32
)(
    input wire clk,
    input wire rst_n,

    // Simple Control/Status Bus Interface
    input wire [ADDR_WIDTH-1:0] reg_addr,
    input wire reg_wr_en,
    input wire [DATA_WIDTH-1:0] reg_wr_data,
    output reg [DATA_WIDTH-1:0] reg_rd_data,

    // Exposed Registers to your FPGA Custom Logic
    output reg [31:0] control_reg_0,
    output reg [31:0] control_reg_1,
    input  wire [31:0] status_reg_0
);

    // Internal Registers Map
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            control_reg_0 <= 32'h00000000;
            control_reg_1 <= 32'h00000000;
        end else if (reg_wr_en) begin
            case (reg_addr)
                8'h00: control_reg_0 <= reg_wr_data;
                8'h01: control_reg_1 <= reg_wr_data;
                default: ; // Do nothing for invalid address
            endcase
        end
    end

    // Read Logic
    always @(*) begin
        case (reg_addr)
            8'h00: reg_rd_data = control_reg_0;
            8'h01: reg_rd_data = control_reg_1;
            8'h02: reg_rd_data = status_reg_0;
            default: reg_rd_data = 32'h00000000;
        endcase
    end

endmodule