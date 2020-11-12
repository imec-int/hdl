#set ip_repo for base_board
set project_dir [get_property DIRECTORY [current_project]]
set lib_dirs  [get_property ip_repo_paths [current_project]]
lappend lib_dirs $project_dir/../common/base_board/ip_lib/
set_property ip_repo_paths $lib_dirs [current_project]
update_ip_catalog

#add base_board constraints file
add_files -fileset constrs_1 -norecurse -quiet $project_dir/../common/base_board/base_board.xdc

# Hierarchical cell: RGPIO
proc create_hier_cell_RGPIO { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_RGPIO() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv trenz.biz:user:RGPIO_EXT_rtl:1.0 RGPIO_M_EXT

  create_bd_intf_pin -mode Master -vlnv trenz.biz:user:RGPIO_EXT_rtl:1.0 RGPIO_M_EXT1


  # Create pins
  create_bd_pin -dir I -type rst RGPIO_M_RESET_N
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type clk clk1

  # Create instance: RGPIO_Master_CPLD, and set properties
  set RGPIO_Master_CPLD [ create_bd_cell -type ip -vlnv trenz.biz:user:RGPIO RGPIO_Master_CPLD ]
  set_property -dict [ list \
   CONFIG.C_TYP {0} \
 ] $RGPIO_Master_CPLD

  # Create instance: RGPIO_Slave_CPLD, and set properties
  set RGPIO_Slave_CPLD [ create_bd_cell -type ip -vlnv trenz.biz:user:RGPIO RGPIO_Slave_CPLD ]
  set_property -dict [ list \
   CONFIG.C_TYP {0} \
 ] $RGPIO_Slave_CPLD

  # Create instance: vio_rgpio, and set properties
  set vio_rgpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio vio_rgpio ]
  set_property -dict [ list \
   CONFIG.C_NUM_PROBE_IN {20} \
   CONFIG.C_NUM_PROBE_OUT {8} \
   CONFIG.C_PROBE_OUT0_WIDTH {1} \
   CONFIG.C_PROBE_OUT1_WIDTH {1} \
   CONFIG.C_PROBE_OUT2_WIDTH {12} \
   CONFIG.C_PROBE_OUT3_WIDTH {4} \
   CONFIG.C_PROBE_OUT4_WIDTH {2} \
   CONFIG.C_PROBE_OUT5_WIDTH {6} \
   CONFIG.C_PROBE_OUT6_WIDTH {16} \
   CONFIG.C_PROBE_OUT7_WIDTH {8} \
 ] $vio_rgpio

  # Create instance: xlconcat_2, and set properties
  set xlconcat_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_2 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_2

  # Create instance: xlconcat_3, and set properties
  set xlconcat_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_3 ]

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {23} \
   CONFIG.DIN_TO {23} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {22} \
   CONFIG.DIN_TO {22} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_1

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {21} \
   CONFIG.DIN_TO {21} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_2

  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {20} \
   CONFIG.DIN_TO {20} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_3

  # Create instance: xlslice_4, and set properties
  set xlslice_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_4 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {19} \
   CONFIG.DIN_TO {19} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_4

  # Create instance: xlslice_5, and set properties
  set xlslice_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_5 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {18} \
   CONFIG.DIN_TO {18} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_5

  # Create instance: xlslice_6, and set properties
  set xlslice_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_6 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {17} \
   CONFIG.DIN_TO {17} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_6

  # Create instance: xlslice_7, and set properties
  set xlslice_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_7 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {16} \
   CONFIG.DIN_TO {16} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_7

  # Create instance: xlslice_8, and set properties
  set xlslice_8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_8 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DIN_TO {13} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {3} \
 ] $xlslice_8

  # Create instance: xlslice_9, and set properties
  set xlslice_9 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_9 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {12} \
   CONFIG.DIN_TO {12} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_9

  # Create instance: xlslice_10, and set properties
  set xlslice_10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_10 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {11} \
   CONFIG.DIN_TO {8} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {4} \
 ] $xlslice_10

  # Create instance: xlslice_11, and set properties
  set xlslice_11 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_11 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {7} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {8} \
 ] $xlslice_11

  # Create instance: xlslice_12, and set properties
  set xlslice_12 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_12 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {23} \
   CONFIG.DIN_TO {12} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {12} \
 ] $xlslice_12

  # Create instance: xlslice_13, and set properties
  set xlslice_13 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_13 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {11} \
   CONFIG.DIN_TO {8} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {4} \
 ] $xlslice_13

  # Create instance: xlslice_14, and set properties
  set xlslice_14 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_14 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {7} \
   CONFIG.DIN_TO {6} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {2} \
 ] $xlslice_14

  # Create instance: xlslice_15, and set properties
  set xlslice_15 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_15 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {5} \
   CONFIG.DIN_TO {4} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {2} \
 ] $xlslice_15

  # Create instance: xlslice_16, and set properties
  set xlslice_16 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_16 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {3} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_16

  # Create instance: xlslice_17, and set properties
  set xlslice_17 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_17 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_17

  # Create instance: xlslice_18, and set properties
  set xlslice_18 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_18 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_18

  # Create instance: xlslice_19, and set properties
  set xlslice_19 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_19 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {24} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_19

  # Create interface connections
  connect_bd_intf_net -intf_net RGPIO_Master_CPLD_RGPIO_M_EXT [get_bd_intf_pins RGPIO_M_EXT] [get_bd_intf_pins RGPIO_Master_CPLD/RGPIO_M_EXT]
  connect_bd_intf_net -intf_net RGPIO_Slave_CPLD_RGPIO_M_EXT [get_bd_intf_pins RGPIO_M_EXT1] [get_bd_intf_pins RGPIO_Slave_CPLD/RGPIO_M_EXT]

  # Create port connections
  connect_bd_net -net RGPIO_Master_CPLD_RGPIO_M_OUT [get_bd_pins RGPIO_Master_CPLD/RGPIO_M_OUT] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_10/Din] [get_bd_pins xlslice_11/Din] [get_bd_pins xlslice_2/Din] [get_bd_pins xlslice_3/Din] [get_bd_pins xlslice_4/Din] [get_bd_pins xlslice_5/Din] [get_bd_pins xlslice_6/Din] [get_bd_pins xlslice_7/Din] [get_bd_pins xlslice_8/Din] [get_bd_pins xlslice_9/Din]
  connect_bd_net -net RGPIO_Slave_CPLD_RGPIO_M_OUT [get_bd_pins RGPIO_Slave_CPLD/RGPIO_M_OUT] [get_bd_pins xlslice_12/Din] [get_bd_pins xlslice_13/Din] [get_bd_pins xlslice_14/Din] [get_bd_pins xlslice_15/Din] [get_bd_pins xlslice_16/Din] [get_bd_pins xlslice_17/Din] [get_bd_pins xlslice_18/Din] [get_bd_pins xlslice_19/Din]
  connect_bd_net -net clk1_1 [get_bd_pins clk1] [get_bd_pins vio_rgpio/clk]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins RGPIO_M_RESET_N] [get_bd_pins RGPIO_Master_CPLD/RGPIO_M_RESET_N] [get_bd_pins RGPIO_Slave_CPLD/RGPIO_M_RESET_N]
  connect_bd_net -net vio_rgpio_m_11dt8_MUX [get_bd_pins vio_rgpio/probe_in10] [get_bd_pins xlslice_10/Dout]
  connect_bd_net -net vio_rgpio_m_11dt8_muxsel [get_bd_pins vio_rgpio/probe_out3] [get_bd_pins xlconcat_2/In2]
  connect_bd_net -net vio_rgpio_m_12_CAN_FAULT [get_bd_pins vio_rgpio/probe_in9] [get_bd_pins xlslice_9/Dout]
  connect_bd_net -net vio_rgpio_m_15dt13_PHY_LEDS [get_bd_pins vio_rgpio/probe_in8] [get_bd_pins xlslice_8/Dout]
  connect_bd_net -net vio_rgpio_m_16_XMOD2BUTTON [get_bd_pins vio_rgpio/probe_in7] [get_bd_pins xlslice_7/Dout]
  connect_bd_net -net vio_rgpio_m_17_S5_3_USER [get_bd_pins vio_rgpio/probe_in6] [get_bd_pins xlslice_6/Dout]
  connect_bd_net -net vio_rgpio_m_18_S5_4_FMCVADJ [get_bd_pins vio_rgpio/probe_in5] [get_bd_pins xlslice_5/Dout]
  connect_bd_net -net vio_rgpio_m_19_reserved [get_bd_pins vio_rgpio/probe_in4] [get_bd_pins xlslice_4/Dout]
  connect_bd_net -net vio_rgpio_m_20_SD_WP [get_bd_pins vio_rgpio/probe_in3] [get_bd_pins xlslice_3/Dout]
  connect_bd_net -net vio_rgpio_m_21_FMC_CLKDIR [get_bd_pins vio_rgpio/probe_in2] [get_bd_pins xlslice_2/Dout]
  connect_bd_net -net vio_rgpio_m_22_PJTAG_TRST [get_bd_pins vio_rgpio/probe_in1] [get_bd_pins xlslice_1/Dout]
  connect_bd_net -net vio_rgpio_m_23_PJTAG_SRST [get_bd_pins vio_rgpio/probe_in0] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net vio_rgpio_m_23dt12_unused [get_bd_pins vio_rgpio/probe_out2] [get_bd_pins xlconcat_2/In3]
  connect_bd_net -net vio_rgpio_m_5dt0_leds [get_bd_pins vio_rgpio/probe_out5] [get_bd_pins xlconcat_2/In0]
  connect_bd_net -net vio_rgpio_m_7dt0_data [get_bd_pins vio_rgpio/probe_in11] [get_bd_pins xlslice_11/Dout]
  connect_bd_net -net vio_rgpio_m_7dt6_unused [get_bd_pins vio_rgpio/probe_out4] [get_bd_pins xlconcat_2/In1]
  connect_bd_net -net vio_rgpio_m_enable [get_bd_pins RGPIO_Master_CPLD/RGPIO_M_ENABLE] [get_bd_pins vio_rgpio/probe_out0]
  connect_bd_net -net vio_rgpio_s_0_S5_1_bootmode [get_bd_pins vio_rgpio/probe_in19] [get_bd_pins xlslice_19/Dout]
  connect_bd_net -net vio_rgpio_s_11dt8_bootmode [get_bd_pins vio_rgpio/probe_in13] [get_bd_pins xlslice_13/Dout]
  connect_bd_net -net vio_rgpio_s_1_S5_2_bootmode [get_bd_pins vio_rgpio/probe_in18] [get_bd_pins xlslice_18/Dout]
  connect_bd_net -net vio_rgpio_s_23dt12_PG [get_bd_pins vio_rgpio/probe_in12] [get_bd_pins xlslice_12/Dout]
  connect_bd_net -net vio_rgpio_s_23dt8_unused [get_bd_pins vio_rgpio/probe_out6] [get_bd_pins xlconcat_3/In1]
  connect_bd_net -net vio_rgpio_s_2_xmod1_button [get_bd_pins vio_rgpio/probe_in17] [get_bd_pins xlslice_17/Dout]
  connect_bd_net -net vio_rgpio_s_3_unused [get_bd_pins vio_rgpio/probe_in16] [get_bd_pins xlslice_16/Dout]
  connect_bd_net -net vio_rgpio_s_6dt5_SD_CD [get_bd_pins vio_rgpio/probe_in15] [get_bd_pins xlslice_15/Dout]
  connect_bd_net -net vio_rgpio_s_7dt0_data [get_bd_pins vio_rgpio/probe_out7] [get_bd_pins xlconcat_3/In0]
  connect_bd_net -net vio_rgpio_s_7dt6_ER_ERST [get_bd_pins vio_rgpio/probe_in14] [get_bd_pins xlslice_14/Dout]
  connect_bd_net -net vio_rgpio_s_enable [get_bd_pins RGPIO_Slave_CPLD/RGPIO_M_ENABLE] [get_bd_pins vio_rgpio/probe_out1]
  connect_bd_net -net xlconcat_2_dout [get_bd_pins RGPIO_Master_CPLD/RGPIO_M_IN] [get_bd_pins xlconcat_2/dout]
  connect_bd_net -net xlconcat_3_dout [get_bd_pins RGPIO_Slave_CPLD/RGPIO_M_IN] [get_bd_pins xlconcat_3/dout]
  connect_bd_net -net sys_cpu_clk [get_bd_pins clk] [get_bd_pins RGPIO_Master_CPLD/RGPIO_M_USRCLK] [get_bd_pins RGPIO_Slave_CPLD/RGPIO_M_USRCLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

proc create_base_board {  parentCell  } {

# Create interface ports
  set BASE [ create_bd_intf_port -mode Master -vlnv xilinx.com:user:SC0808BF_bus_rtl:1.0 BASE ]


  # Create ports

  # Create instance: RGPIO
   create_hier_cell_RGPIO [current_bd_instance .] RGPIO

  # Create instance: SC0808BF_0, and set properties
  set SC0808BF_0 [ create_bd_cell -type ip -vlnv trenz.biz:user:SC0808BF SC0808BF_0 ]

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset proc_sys_reset_0 ]

  # Create instance: vio_general, and set properties
  set vio_general [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio vio_general ]
  set_property -dict [ list \
   CONFIG.C_EN_PROBE_IN_ACTIVITY {0} \
   CONFIG.C_NUM_PROBE_IN {0} \
   CONFIG.C_NUM_PROBE_OUT {3} \
 ] $vio_general

 
  # adapt zynq PS
set_property -dict [list CONFIG.PSU__CAN0__PERIPHERAL__ENABLE {1} CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} CONFIG.PSU__QSPI__PERIPHERAL__MODE {Dual Parallel} CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} ] [get_bd_cells sys_ps8]
set_property -dict [list CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 38 .. 39} CONFIG.PSU__PJTAG__PERIPHERAL__ENABLE {1} CONFIG.PSU__PJTAG__PERIPHERAL__IO {MIO 26 .. 29} CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 42 .. 43}] [get_bd_cells sys_ps8]
#SD CARDS
set_property -dict [list  CONFIG.PSU__SD0__PERIPHERAL__ENABLE {1} CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} CONFIG.PSU__SD0__SLOT_TYPE {eMMC} CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 46 .. 51} CONFIG.PSU__SD1__SLOT_TYPE {SD 2.0} CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1}] [get_bd_cells sys_ps8]
set_property -dict [list CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1}] [get_bd_cells sys_ps8]





  # Create interface connections
  connect_bd_intf_net -intf_net RGPIO_Master_CPLD_RGPIO_M_EXT [get_bd_intf_pins RGPIO/RGPIO_M_EXT] [get_bd_intf_pins SC0808BF_0/RGPIO_MASTER_CPLD]
  connect_bd_intf_net -intf_net RGPIO_Slave_CPLD_RGPIO_M_EXT [get_bd_intf_pins RGPIO/RGPIO_M_EXT1] [get_bd_intf_pins SC0808BF_0/RGPIO_SLAVE_CPLD]
  connect_bd_intf_net -intf_net SC0808BF_0_BASE [get_bd_intf_ports BASE] [get_bd_intf_pins SC0808BF_0/BASE]
  connect_bd_intf_net -intf_net sys_ps8_CAN_0 [get_bd_intf_pins SC0808BF_0/CAN] [get_bd_intf_pins sys_ps8/CAN_0]


  # Create port connections
  connect_bd_net -net SC0808BF_0_PS_AUX_DI [get_bd_pins SC0808BF_0/PS_AUX_DI] [get_bd_pins sys_ps8/dp_aux_data_in]
  connect_bd_net -net SC0808BF_0_PS_DP_HPD [get_bd_pins SC0808BF_0/PS_DP_HPD] [get_bd_pins sys_ps8/dp_hot_plug_detect]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins RGPIO/RGPIO_M_RESET_N] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net vio_CAN_0_S [get_bd_pins SC0808BF_0/CAN_S] [get_bd_pins vio_general/probe_out2]
  connect_bd_net -net vio_LED_HD [get_bd_pins SC0808BF_0/LED_HD] [get_bd_pins vio_general/probe_out0]
  connect_bd_net -net vio_LED_XMOD2 [get_bd_pins SC0808BF_0/LED_XMOD2] [get_bd_pins vio_general/probe_out1]
  connect_bd_net -net sys_ps8_dp_aux_data_oe_n [get_bd_pins SC0808BF_0/PS_AUX_OE] [get_bd_pins sys_ps8/dp_aux_data_oe_n]
  connect_bd_net -net sys_ps8_dp_aux_data_out [get_bd_pins SC0808BF_0/PS_AUX_DO] [get_bd_pins sys_ps8/dp_aux_data_out]
  connect_bd_net -net sys_250m_clk [get_bd_pins RGPIO/clk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins sys_ps8/pl_clk1]
  connect_bd_net -net sys_cpu_clk [get_bd_pins RGPIO/clk1] [get_bd_pins vio_general/clk] [get_bd_pins sys_ps8/maxihpm0_lpd_aclk] [get_bd_pins sys_ps8/pl_clk0]
  connect_bd_net -net sys_ps8_pl_resetn0 [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins sys_ps8/pl_resetn0]
}

create_base_board ""

