// ***************************************************************************
// ***************************************************************************
// Copyright (C) 2024-2025 Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/main/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top  #(
  parameter TX_JESD_L = 4,
  parameter TX_NUM_LINKS = 1,
  parameter RX_JESD_L = 4,
  parameter RX_NUM_LINKS = 1,
  parameter JESD_MODE = "8B10B",
  parameter GENERATE_LINK_CLK = 1
) (

  input           sys_clk_n,
  input           sys_clk_p,

  output  [ 5:0]  ch0_lpddr4_trip1_ca_a,
  output  [ 5:0]  ch0_lpddr4_trip1_ca_b,
  output          ch0_lpddr4_trip1_ck_c_a,
  output          ch0_lpddr4_trip1_ck_c_b,
  output          ch0_lpddr4_trip1_ck_t_a,
  output          ch0_lpddr4_trip1_ck_t_b,
  output          ch0_lpddr4_trip1_cke_a,
  output          ch0_lpddr4_trip1_cke_b,
  output          ch0_lpddr4_trip1_cs_a,
  output          ch0_lpddr4_trip1_cs_b,
  inout   [ 1:0]  ch0_lpddr4_trip1_dmi_a,
  inout   [ 1:0]  ch0_lpddr4_trip1_dmi_b,
  inout   [15:0]  ch0_lpddr4_trip1_dq_a,
  inout   [15:0]  ch0_lpddr4_trip1_dq_b,
  inout   [ 1:0]  ch0_lpddr4_trip1_dqs_c_a,
  inout   [ 1:0]  ch0_lpddr4_trip1_dqs_c_b,
  inout   [ 1:0]  ch0_lpddr4_trip1_dqs_t_a,
  inout   [ 1:0]  ch0_lpddr4_trip1_dqs_t_b,
  output          ch0_lpddr4_trip1_reset_n,
  output  [ 5:0]  ch1_lpddr4_trip1_ca_a,
  output  [ 5:0]  ch1_lpddr4_trip1_ca_b,
  output          ch1_lpddr4_trip1_ck_c_a,
  output          ch1_lpddr4_trip1_ck_c_b,
  output          ch1_lpddr4_trip1_ck_t_a,
  output          ch1_lpddr4_trip1_ck_t_b,
  output          ch1_lpddr4_trip1_cke_a,
  output          ch1_lpddr4_trip1_cke_b,
  output          ch1_lpddr4_trip1_cs_a,
  output          ch1_lpddr4_trip1_cs_b,
  inout   [ 1:0]  ch1_lpddr4_trip1_dmi_a,
  inout   [ 1:0]  ch1_lpddr4_trip1_dmi_b,
  inout   [15:0]  ch1_lpddr4_trip1_dq_a,
  inout   [15:0]  ch1_lpddr4_trip1_dq_b,
  inout   [ 1:0]  ch1_lpddr4_trip1_dqs_c_a,
  inout   [ 1:0]  ch1_lpddr4_trip1_dqs_c_b,
  inout   [ 1:0]  ch1_lpddr4_trip1_dqs_t_a,
  inout   [ 1:0]  ch1_lpddr4_trip1_dqs_t_b,
  output          ch1_lpddr4_trip1_reset_n,

  // GPIOs
  output  [ 3:0]  gpio_led,
  input   [ 3:0]  gpio_dip_sw,
  input   [ 1:0]  gpio_pb,

  // FMC HPC IOs
  input  [ 1:0]  agc0,
  input  [ 1:0]  agc1,
  input  [ 1:0]  agc2,
  input  [ 1:0]  agc3,
  input          clkin6_n,
  input          clkin6_p,
  input          clkin10_n,
  input          clkin10_p,
  input          fpga_refclk_in_n,
  input          fpga_refclk_in_p,
  input  [RX_JESD_L*RX_NUM_LINKS-1:0]  rx_data_n,
  input  [RX_JESD_L*RX_NUM_LINKS-1:0]  rx_data_p,
  output [TX_JESD_L*TX_NUM_LINKS-1:0]  tx_data_n,
  output [TX_JESD_L*TX_NUM_LINKS-1:0]  tx_data_p,
  input          fpga_syncin_0_n,
  input          fpga_syncin_0_p,
  inout          fpga_syncin_1_n,
  inout          fpga_syncin_1_p,
  output         fpga_syncout_0_n,
  output         fpga_syncout_0_p,
  inout          fpga_syncout_1_n,
  inout          fpga_syncout_1_p,
  inout  [10:0]  gpio,
  inout          hmc_gpio1,
  output         hmc_sync,
  input  [ 1:0]  irqb,
  output         rstb,
  output [ 1:0]  rxen,
  output         spi0_csb,
  input          spi0_miso,
  output         spi0_mosi,
  output         spi0_sclk,
  output         spi1_csb,
  output         spi1_sclk,
  inout          spi1_sdio,
  input          sysref2_n,
  input          sysref2_p,
  output [ 1:0]  txen
);

  // internal signals

  wire    [95:0]  gpio_i;
  wire    [95:0]  gpio_o;
  wire    [95:0]  gpio_t;

  wire    [ 2:0]  spi0_csn;

  wire    [ 2:0]  spi1_csn;
  wire            spi1_mosi;
  wire            spi1_miso;

  wire            sysref;
  wire    [TX_NUM_LINKS-1:0]   tx_syncin;
  wire    [RX_NUM_LINKS-1:0]   rx_syncout;

  wire    [7:0]   rx_data_p_loc;
  wire    [7:0]   rx_data_n_loc;
  wire    [7:0]   tx_data_p_loc;
  wire    [7:0]   tx_data_n_loc;

  wire            clkin6;
  wire            clkin10;
  wire            tx_device_clk;
  wire            rx_device_clk;
  wire            rx_sysref;
  wire            tx_sysref;

  wire            gt_reset;
  wire            rx_reset_pll_and_datapath;
  wire            tx_reset_pll_and_datapath;
  wire            rx_reset_datapath;
  wire            tx_reset_datapath;
  wire            rx_resetdone;
  wire            tx_resetdone;
  wire            gt_powergood;
  wire            gt_reset_s;
  wire            mst_resetdone;

  // instantiations
  IBUFDS_GTE5 i_ibufds_ref_clk (
    .CEB (1'b0),
    .I (fpga_refclk_in_p),
    .IB (fpga_refclk_in_n),
    .O (ref_clk),
    .ODIV2 ());

  IBUFDS i_ibufds_sysref (
    .I (sysref2_p),
    .IB (sysref2_n),
    .O (sysref));

  IBUFDS i_ibufds_tx_device_clk (
    .I (clkin6_p),
    .IB (clkin6_n),
    .O (clkin6));

  IBUFDS i_ibufds_rx_device_clk (
    .I (clkin10_p),
    .IB (clkin10_n),
    .O (clkin10));

  IBUFDS i_ibufds_syncin_0 (
    .I (fpga_syncin_0_p),
    .IB (fpga_syncin_0_n),
    .O (tx_syncin[0]));

  OBUFDS i_obufds_syncout_0 (
    .I (rx_syncout[0]),
    .O (fpga_syncout_0_p),
    .OB (fpga_syncout_0_n));

  BUFG i_tx_device_clk (
    .I (clkin6),
    .O (tx_device_clk));

  BUFG i_rx_device_clk (
    .I (clkin10),
    .O (rx_device_clk));

  // spi

  assign spi0_csb   = spi0_csn[0];
  assign spi1_csb   = spi1_csn[0];

  ad_3w_spi #(
    .NUM_OF_SLAVES(1)
  ) i_spi (
    .spi_csn (spi1_csn[0]),
    .spi_clk (spi1_sclk),
    .spi_mosi (spi1_mosi),
    .spi_miso (spi1_miso),
    .spi_sdio (spi1_sdio),
    .spi_dir ());

  // gpios

  ad_iobuf #(
    .DATA_WIDTH(12)
  ) i_iobuf (
    .dio_t (gpio_t[43:32]),
    .dio_i (gpio_o[43:32]),
    .dio_o (gpio_i[43:32]),
    .dio_p ({hmc_gpio1,       // 43
             gpio[10:0]}));   // 42-32

  assign gpio_i[44] = agc0[0];
  assign gpio_i[45] = agc0[1];
  assign gpio_i[46] = agc1[0];
  assign gpio_i[47] = agc1[1];
  assign gpio_i[48] = agc2[0];
  assign gpio_i[49] = agc2[1];
  assign gpio_i[50] = agc3[0];
  assign gpio_i[51] = agc3[1];
  assign gpio_i[52] = irqb[0];
  assign gpio_i[53] = irqb[1];

  assign hmc_sync   = gpio_o[54];
  assign rstb       = gpio_o[55];
  assign rxen[0]    = gpio_o[56];
  assign rxen[1]    = gpio_o[57];
  assign txen[0]    = gpio_o[58];
  assign txen[1]    = gpio_o[59];

  assign gpio_i[64] = rx_resetdone;
  assign gpio_i[65] = tx_resetdone;
  assign gpio_i[66] = mst_resetdone;
  assign gt_reset   = gpio_o[67];
  assign rx_reset_pll_and_datapath = gpio_o[68];
  assign tx_reset_pll_and_datapath = gpio_o[69];
  assign rx_reset_datapath = gpio_o[70];
  assign tx_reset_datapath = gpio_o[71];

  generate
  if (TX_NUM_LINKS > 1 & JESD_MODE == "8B10B") begin
    assign tx_syncin[1] = fpga_syncin_1_p;
  end else begin
    ad_iobuf #(
      .DATA_WIDTH(2)
    ) i_syncin_iobuf (
      .dio_t (gpio_t[61:60]),
      .dio_i (gpio_o[61:60]),
      .dio_o (gpio_i[61:60]),
      .dio_p ({fpga_syncin_1_n,      // 61
               fpga_syncin_1_p}));   // 60
  end

  if (RX_NUM_LINKS > 1 & JESD_MODE == "8B10B") begin
    assign fpga_syncout_1_p = rx_syncout[1];
    assign fpga_syncout_1_n = 0;
  end else begin
    ad_iobuf #(
      .DATA_WIDTH(2)
    ) i_syncout_iobuf (
      .dio_t (gpio_t[63:62]),
      .dio_i (gpio_o[63:62]),
      .dio_o (gpio_i[63:62]),
      .dio_p ({fpga_syncout_1_n,      // 63
               fpga_syncout_1_p}));   // 62
  end
  endgenerate

  /* Board GPIOS. Buttons, LEDs, etc... */
  assign gpio_led     = gpio_o[3:0];
  assign gpio_i[3:0]  = gpio_o[3:0];
  assign gpio_i[7: 4] = gpio_dip_sw;
  assign gpio_i[9: 8] = gpio_pb;

  // Unused GPIOs
  assign gpio_i[59:57] = gpio_o[59:57];
  assign gpio_i[94:72] = gpio_o[94:72];
  assign gpio_i[31:10] = gpio_o[31:10];

  /* Reset should only be asserted if powergood is high */
  assign gt_reset_s    = gt_reset & gt_powergood;
  assign mst_resetdone = rx_resetdone & tx_resetdone;

  system_wrapper i_system_wrapper (
    .gpio0_i (gpio_i[31:0]),
    .gpio0_o (gpio_o[31:0]),
    .gpio0_t (gpio_t[31:0]),
    .gpio1_i (gpio_i[63:32]),
    .gpio1_o (gpio_o[63:32]),
    .gpio1_t (gpio_t[63:32]),
    .gpio2_i (gpio_i[95:64]),
    .gpio2_o (gpio_o[95:64]),
    .gpio2_t (gpio_t[95:64]),

    .lpddr4_clk1_clk_n (sys_clk_n),
    .lpddr4_clk1_clk_p (sys_clk_p),

    .ch0_lpddr4_trip1_ca_a (ch0_lpddr4_trip1_ca_a),
    .ch0_lpddr4_trip1_ca_b (ch0_lpddr4_trip1_ca_b),
    .ch0_lpddr4_trip1_ck_c_a (ch0_lpddr4_trip1_ck_c_a),
    .ch0_lpddr4_trip1_ck_c_b (ch0_lpddr4_trip1_ck_c_b),
    .ch0_lpddr4_trip1_ck_t_a (ch0_lpddr4_trip1_ck_t_a),
    .ch0_lpddr4_trip1_ck_t_b (ch0_lpddr4_trip1_ck_t_b),
    .ch0_lpddr4_trip1_cke_a (ch0_lpddr4_trip1_cke_a),
    .ch0_lpddr4_trip1_cke_b (ch0_lpddr4_trip1_cke_b),
    .ch0_lpddr4_trip1_cs_a (ch0_lpddr4_trip1_cs_a),
    .ch0_lpddr4_trip1_cs_b (ch0_lpddr4_trip1_cs_b),
    .ch0_lpddr4_trip1_dmi_a (ch0_lpddr4_trip1_dmi_a),
    .ch0_lpddr4_trip1_dmi_b (ch0_lpddr4_trip1_dmi_b),
    .ch0_lpddr4_trip1_dq_a (ch0_lpddr4_trip1_dq_a),
    .ch0_lpddr4_trip1_dq_b (ch0_lpddr4_trip1_dq_b),
    .ch0_lpddr4_trip1_dqs_c_a (ch0_lpddr4_trip1_dqs_c_a),
    .ch0_lpddr4_trip1_dqs_c_b (ch0_lpddr4_trip1_dqs_c_b),
    .ch0_lpddr4_trip1_dqs_t_a (ch0_lpddr4_trip1_dqs_t_a),
    .ch0_lpddr4_trip1_dqs_t_b (ch0_lpddr4_trip1_dqs_t_b),
    .ch0_lpddr4_trip1_reset_n (ch0_lpddr4_trip1_reset_n),
    .ch1_lpddr4_trip1_ca_a (ch1_lpddr4_trip1_ca_a),
    .ch1_lpddr4_trip1_ca_b (ch1_lpddr4_trip1_ca_b),
    .ch1_lpddr4_trip1_ck_c_a (ch1_lpddr4_trip1_ck_c_a),
    .ch1_lpddr4_trip1_ck_c_b (ch1_lpddr4_trip1_ck_c_b),
    .ch1_lpddr4_trip1_ck_t_a (ch1_lpddr4_trip1_ck_t_a),
    .ch1_lpddr4_trip1_ck_t_b (ch1_lpddr4_trip1_ck_t_b),
    .ch1_lpddr4_trip1_cke_a (ch1_lpddr4_trip1_cke_a),
    .ch1_lpddr4_trip1_cke_b (ch1_lpddr4_trip1_cke_b),
    .ch1_lpddr4_trip1_cs_a (ch1_lpddr4_trip1_cs_a),
    .ch1_lpddr4_trip1_cs_b (ch1_lpddr4_trip1_cs_b),
    .ch1_lpddr4_trip1_dmi_a (ch1_lpddr4_trip1_dmi_a),
    .ch1_lpddr4_trip1_dmi_b (ch1_lpddr4_trip1_dmi_b),
    .ch1_lpddr4_trip1_dq_a (ch1_lpddr4_trip1_dq_a),
    .ch1_lpddr4_trip1_dq_b (ch1_lpddr4_trip1_dq_b),
    .ch1_lpddr4_trip1_dqs_c_a (ch1_lpddr4_trip1_dqs_c_a),
    .ch1_lpddr4_trip1_dqs_c_b (ch1_lpddr4_trip1_dqs_c_b),
    .ch1_lpddr4_trip1_dqs_t_a (ch1_lpddr4_trip1_dqs_t_a),
    .ch1_lpddr4_trip1_dqs_t_b (ch1_lpddr4_trip1_dqs_t_b),
    .ch1_lpddr4_trip1_reset_n (ch1_lpddr4_trip1_reset_n),

    .spi0_csn  (spi0_csn),
    .spi0_miso (spi0_miso),
    .spi0_mosi (spi0_mosi),
    .spi0_sclk (spi0_sclk),
    .spi1_csn  (spi1_csn),
    .spi1_miso (spi1_miso),
    .spi1_mosi (spi1_mosi),
    .spi1_sclk (spi1_sclk),
    // FMC HPC
    .rx_0_p (rx_data_p_loc[3:0]),
    .rx_0_n (rx_data_n_loc[3:0]),
    .tx_0_p (tx_data_p_loc[3:0]),
    .tx_0_n (tx_data_n_loc[3:0]),
    .rx_1_p (rx_data_p_loc[7:4]),
    .rx_1_n (rx_data_n_loc[7:4]),
    .tx_1_p (tx_data_p_loc[7:4]),
    .tx_1_n (tx_data_n_loc[7:4]),

    .gt_reset (gt_reset_s),
    .gt_reset_rx_datapath (rx_reset_datapath),
    .gt_reset_tx_datapath (tx_reset_datapath),
    .gt_reset_rx_pll_and_datapath (rx_reset_pll_and_datapath),
    .gt_reset_tx_pll_and_datapath (tx_reset_pll_and_datapath),
    .gt_powergood (gt_powergood),
    .rx_resetdone (rx_resetdone),
    .tx_resetdone (tx_resetdone),
    .ref_clk_q0 (ref_clk),
    .ref_clk_q1 (ref_clk),

    .rx_device_clk (rx_device_clk),
    .tx_device_clk (tx_device_clk),
    .rx_sync_0 (rx_syncout),
    .tx_sync_0 (tx_syncin),
    .rx_sysref_0 (sysref),
    .tx_sysref_0 (sysref));

  assign rx_data_p_loc[RX_JESD_L*RX_NUM_LINKS-1:0] = rx_data_p[RX_JESD_L*RX_NUM_LINKS-1:0];
  assign rx_data_n_loc[RX_JESD_L*RX_NUM_LINKS-1:0] = rx_data_n[RX_JESD_L*RX_NUM_LINKS-1:0];

  assign tx_data_p[TX_JESD_L*TX_NUM_LINKS-1:0] = tx_data_p_loc[TX_JESD_L*TX_NUM_LINKS-1:0];
  assign tx_data_n[TX_JESD_L*TX_NUM_LINKS-1:0] = tx_data_n_loc[TX_JESD_L*TX_NUM_LINKS-1:0];

endmodule
