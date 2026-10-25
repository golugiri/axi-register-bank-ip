# AXI4-Lite Register Bank / Control Interface IP

## Overview
This repository contains a lightweight, high-performance, and fully synthesizable Verilog implementation of an **AXI4-Lite Register Bank / Control Interface**. It is designed for FPGA-based systems, custom SoC controllers, and embedded hardware accelerators requiring clean, reliable register-mapped control and status interfacing.

## Key Features
- **Configurable Parameters:** Fully parameterized data width (`DATA_WIDTH`) and address width (`ADDR_WIDTH`).
- **Zero Wait-State Read/Write:** Optimized combinational read and synchronous write logic for maximum operating frequency.
- **Clean Separation:** Easily isolates control registers (driven from host bus) from status registers (driven from user FPGA logic).
- **Simulation Verified:** Extensively tested with Icarus Verilog (`iverilog`) and verified via GTKWave waveforms.

## Interface Signals

| Signal Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `clk` | Input | 1 | System Clock |
| `rst_n` | Input | 1 | Active-Low Asynchronous Reset |
| `reg_addr` | Input | `ADDR_WIDTH` | Register Address Bus |
| `reg_wr_en` | Input | 1 | Write Enable Strobe |
| `reg_wr_data` | Input | `DATA_WIDTH` | Write Data Bus |
| `reg_rd_data` | Output | `DATA_WIDTH` | Read Data Bus |
| `control_reg_0` | Output | 32 | General Purpose Control Register 0 |
| `control_reg_1` | Output | 32 | General Purpose Control Register 1 |
| `status_reg_0` | Input | 32 | General Purpose Status Register 0 |

## Quick Start / Simulation
To compile and run the testbench locally using open-source tools:
```bash
iverilog -o sim_out axi_register_bank.v tb_axi_register_bank.v
vvp sim_out
gtkwave axi_register_bank.vcd