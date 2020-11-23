source $ad_hdl_dir/library/jesd204/scripts/jesd204.tcl

# TX parameters
set TX_NUM_OF_LANES 0      ; # L
set TX_NUM_OF_CONVERTERS 2 ; # M
set TX_SAMPLES_PER_FRAME 1 ; # S
set TX_SAMPLE_WIDTH 16     ; # N/NP

set TX_SAMPLES_PER_CHANNEL [expr $TX_NUM_OF_LANES * 32 / \
                                ($TX_NUM_OF_CONVERTERS * $TX_SAMPLE_WIDTH)] ; # L * 32 / (M * N)

set dac_fifo_name axi_ad9152_fifo
set dac_data_width [expr $TX_SAMPLE_WIDTH * $TX_NUM_OF_CONVERTERS * $TX_SAMPLES_PER_CHANNEL]

# RX parameters
set RX_NUM_OF_LANES 2      ; # L
set RX_NUM_OF_CONVERTERS 8 ; # M
set RX_SAMPLES_PER_FRAME 1 ; # S
set RX_SAMPLE_WIDTH 16     ; # N/NP

# set RX_SAMPLES_PER_CHANNEL [expr $RX_NUM_OF_LANES * 32.0 /  ($RX_NUM_OF_CONVERTERS * $RX_SAMPLE_WIDTH)] ; # L * 32 / (M * N) only works if F<8

set LINK_LAYER_BYTES_PER_BEAT 4

# F = (M * N * S) / (L * 8)
set RX_BYTES_PER_FRAME [expr ($RX_NUM_OF_CONVERTERS * $RX_SAMPLE_WIDTH * $RX_SAMPLES_PER_FRAME) / ($RX_NUM_OF_LANES * 8)];
# one beat per lane must accommodate at least one frame
set RX_TPL_BYTES_PER_BEAT [expr max($RX_BYTES_PER_FRAME, $LINK_LAYER_BYTES_PER_BEAT)]

# datapath width = L * 8 * TPL_BYTES_PER_BEAT / (M * N)
set RX_SAMPLES_PER_CHANNEL [expr ($RX_NUM_OF_LANES * 8 * $RX_TPL_BYTES_PER_BEAT) / ($RX_NUM_OF_CONVERTERS * $RX_SAMPLE_WIDTH)]


set adc_fifo_name axi_ad9675_fifo
set adc_data_width [expr $RX_SAMPLE_WIDTH * $RX_NUM_OF_CONVERTERS * $RX_SAMPLES_PER_CHANNEL]

# adc peripherals
ad_ip_instance axi_clkgen axi_ad9675_rx_clkgen
ad_ip_parameter axi_ad9675_rx_clkgen CONFIG.ID 2
ad_ip_parameter axi_ad9675_rx_clkgen CONFIG.CLKIN_PERIOD 4
ad_ip_parameter axi_ad9675_rx_clkgen CONFIG.VCO_DIV 1
ad_ip_parameter axi_ad9675_rx_clkgen CONFIG.VCO_MUL 4
ad_ip_parameter axi_ad9675_rx_clkgen CONFIG.CLK0_DIV 4
# When F = 8 add a second clock to drive the transport layer with a 2x slower clock
if {$RX_TPL_BYTES_PER_BEAT > $LINK_LAYER_BYTES_PER_BEAT} {
  ad_ip_parameter axi_ad9675_rx_clkgen CONFIG.ENABLE_CLKOUT1 1
  ad_ip_parameter axi_ad9675_rx_clkgen CONFIG.CLK1_DIV 8
  set rx_link_clk axi_ad9675_rx_clkgen/clk_0
  set rx_data_clk axi_ad9675_rx_clkgen/clk_1
} else {
  set rx_link_clk axi_ad9675_rx_clkgen/clk_0
  set rx_data_clk axi_ad9675_rx_clkgen/clk_0
}

ad_ip_instance axi_adxcvr axi_ad9675_xcvr
ad_ip_parameter axi_ad9675_xcvr CONFIG.NUM_OF_LANES $RX_NUM_OF_LANES
ad_ip_parameter axi_ad9675_xcvr CONFIG.QPLL_ENABLE 0
ad_ip_parameter axi_ad9675_xcvr CONFIG.TX_OR_RX_N 0
ad_ip_parameter axi_ad9675_xcvr CONFIG.SYS_CLK_SEL 0
ad_ip_parameter axi_ad9675_xcvr CONFIG.OUT_CLK_SEL 3


adi_axi_jesd204_rx_create axi_ad9675_rx_jesd $RX_NUM_OF_LANES

adi_tpl_jesd204_rx_create axi_ad9675_tpl_core $RX_NUM_OF_LANES \
                                               $RX_NUM_OF_CONVERTERS \
                                               $RX_SAMPLES_PER_FRAME \
                                               $RX_SAMPLE_WIDTH

#ad_ip_instance util_cpack2 axi_ad9675_cpack [list \
#  NUM_OF_CHANNELS $RX_NUM_OF_CONVERTERS \
#  SAMPLES_PER_CHANNEL $RX_SAMPLES_PER_CHANNEL \
#  SAMPLE_DATA_WIDTH $RX_SAMPLE_WIDTH \
#  ]

ad_ip_instance axi_dmac axi_ad9675_dma
ad_ip_parameter axi_ad9675_dma CONFIG.DMA_TYPE_SRC 2
ad_ip_parameter axi_ad9675_dma CONFIG.DMA_TYPE_DEST 0
ad_ip_parameter axi_ad9675_dma CONFIG.ID 0
ad_ip_parameter axi_ad9675_dma CONFIG.AXI_SLICE_SRC 0
ad_ip_parameter axi_ad9675_dma CONFIG.AXI_SLICE_DEST 0
ad_ip_parameter axi_ad9675_dma CONFIG.SYNC_TRANSFER_START 0
ad_ip_parameter axi_ad9675_dma CONFIG.DMA_LENGTH_WIDTH 24
ad_ip_parameter axi_ad9675_dma CONFIG.DMA_2D_TRANSFER 0
ad_ip_parameter axi_ad9675_dma CONFIG.CYCLIC 0
ad_ip_parameter axi_ad9675_dma CONFIG.DMA_DATA_WIDTH_SRC [expr $RX_SAMPLE_WIDTH*$RX_SAMPLES_PER_CHANNEL*$RX_NUM_OF_CONVERTERS]
ad_ip_parameter axi_ad9675_dma CONFIG.DMA_DATA_WIDTH_DEST 64

if {$sys_zynq == 0 || $sys_zynq == 1} {
  ad_adcfifo_create $adc_fifo_name $adc_data_width $adc_data_width $adc_fifo_address_width
}

# shared transceiver core

ad_ip_instance util_adxcvr util_ad9675_xcvr
ad_ip_parameter util_ad9675_xcvr CONFIG.RX_NUM_OF_LANES $RX_NUM_OF_LANES
ad_ip_parameter util_ad9675_xcvr CONFIG.TX_NUM_OF_LANES $TX_NUM_OF_LANES
ad_ip_parameter util_ad9675_xcvr CONFIG.QPLL_REFCLK_DIV 1
ad_ip_parameter util_ad9675_xcvr CONFIG.QPLL_FBDIV_RATIO 1
ad_ip_parameter util_ad9675_xcvr CONFIG.QPLL_FBDIV 0x30; # 20
ad_ip_parameter util_ad9675_xcvr CONFIG.RX_OUT_DIV 1
ad_ip_parameter util_ad9675_xcvr CONFIG.TX_OUT_DIV 1
ad_ip_parameter util_ad9675_xcvr CONFIG.RX_DFE_LPM_CFG 0x0904
ad_ip_parameter util_ad9675_xcvr CONFIG.RX_CDR_CFG 0x0B000023FF10400020

ad_connect  $sys_cpu_resetn util_ad9675_xcvr/up_rstn
ad_connect  $sys_cpu_clk util_ad9675_xcvr/up_clk

# reference clocks & resets

create_bd_port -dir I tx_ref_clk_0
create_bd_port -dir I rx_ref_clk_0

ad_xcvrpll  tx_ref_clk_0 util_ad9675_xcvr/qpll_ref_clk_*
#ad_xcvrpll  rx_ref_clk_0 util_ad9675_xcvr/cpll_ref_clk_*
#ad_xcvrpll  axi_ad9675_xcvr/up_pll_rst util_ad9675_xcvr/up_cpll_rst_*

# connections (adc)
set rx_offset 0

ad_xcvrcon  util_ad9675_xcvr axi_ad9675_xcvr axi_ad9675_rx_jesd
ad_reconct util_ad9675_xcvr/rx_out_clk_$rx_offset axi_ad9675_rx_clkgen/clk; # axi_ad9675_tpl_core/link_clk 
for {set i 0} {$i < $RX_NUM_OF_LANES} {incr i} {
  set ch [expr $rx_offset+$i]
  ad_connect  $rx_link_clk util_ad9675_xcvr/rx_clk_$ch
  ad_xcvrpll  rx_ref_clk_0 util_ad9675_xcvr/cpll_ref_clk_$ch
  ad_xcvrpll  axi_ad9675_xcvr/up_pll_rst util_ad9675_xcvr/up_cpll_rst_$ch
}
#ad_reconnect?
ad_connect  $rx_link_clk axi_ad9675_rx_jesd/device_clk
ad_connect  $rx_link_clk axi_ad9675_rx_jesd_rstgen/slowest_sync_clk


#if {$sys_zynq == 0 || $sys_zynq == 1} {
#    ad_connect  util_ad9675_xcvr/rx_out_clk_0 axi_ad9675_fifo/adc_clk
#    ad_connect  axi_ad9675_jesd_rstgen/peripheral_reset axi_ad9675_fifo/adc_rst
#    ad_connect  axi_ad9675_cpack/packed_fifo_wr_en axi_ad9675_fifo/adc_wr
#    ad_connect  axi_ad9675_cpack/packed_fifo_wr_data axi_ad9675_fifo/adc_wdata
#    ad_connect  $sys_dma_clk axi_ad9675_fifo/dma_clk
#    ad_connect  $sys_dma_clk axi_ad9675_dma/s_axis_aclk
#    ad_connect  $sys_dma_resetn axi_ad9675_dma/m_dest_axi_aresetn
#    ad_connect  axi_ad9675_fifo/dma_wr axi_ad9675_dma/s_axis_valid
#    ad_connect  axi_ad9675_fifo/dma_wdata axi_ad9675_dma/s_axis_data
#    ad_connect  axi_ad9675_fifo/dma_wready axi_ad9675_dma/s_axis_ready
#    ad_connect  axi_ad9675_fifo/dma_xfer_req axi_ad9675_dma/s_axis_xfer_req
#    ad_connect  axi_ad9675_tpl_core/adc_dovf axi_ad9675_fifo/adc_wovf
#}

#ad_connect  util_ad9675_xcvr/rx_out_clk_0 axi_ad9675_cpack/clk
#ad_connect  axi_ad9675_jesd_rstgen/peripheral_reset axi_ad9675_cpack/reset

#for {set i 0} {$i < $RX_NUM_OF_CONVERTERS} {incr i} {
#  ad_connect  axi_ad9675_tpl_core/adc_enable_$i axi_ad9675_cpack/enable_$i
#  ad_connect  axi_ad9675_tpl_core/adc_data_$i axi_ad9675_cpack/fifo_wr_data_$i
#}


# dma clock & reset
ad_ip_instance proc_sys_reset sys_dma_rstgen
ad_ip_parameter sys_dma_rstgen CONFIG.C_EXT_RST_WIDTH 1

ad_connect  sys_dma_clk sys_dma_rstgen/slowest_sync_clk
ad_connect  sys_dma_resetn sys_dma_rstgen/peripheral_aresetn
ad_connect  sys_dma_reset sys_dma_rstgen/peripheral_reset
# Connect JESD Link layer with Transport layer

#ad_connect  axi_ad9675_jesd/rx_sof axi_ad9675_tpl_core/link_sof
#ad_connect  axi_ad9675_jesd/rx_data_tdata axi_ad9675_tpl_core/link_data
#ad_connect  axi_ad9675_jesd/rx_data_tvalid axi_ad9675_tpl_core/link_valid
#ad_connect  axi_ad9675_tpl_core/adc_valid_0 axi_ad9675_cpack/fifo_wr_en

ad_connect $rx_data_clk axi_ad9675_tpl_core/link_clk
if {$RX_TPL_BYTES_PER_BEAT > $LINK_LAYER_BYTES_PER_BEAT} {
  ad_ip_instance ad_ip_jesd204_link_dnconv rx_link_dnconverter [list\
    NUM_LANES $RX_NUM_OF_LANES \
    OCTETS_PER_BEAT_IN $LINK_LAYER_BYTES_PER_BEAT \
    OCTETS_PER_BEAT_OUT $RX_TPL_BYTES_PER_BEAT \
  ]
  ad_connect $rx_link_clk rx_link_dnconverter/in_link_clk
  ad_connect $rx_data_clk rx_link_dnconverter/out_link_clk

  ad_connect axi_ad9675_rx_jesd/rx_data_tdata rx_link_dnconverter/in_link_data
  ad_connect axi_ad9675_rx_jesd/rx_data_tvalid rx_link_dnconverter/in_link_valid
  ad_connect axi_ad9675_rx_jesd/rx_sof rx_link_dnconverter/in_link_sof

  ad_connect rx_link_dnconverter/out_link_data axi_ad9675_tpl_core/link_data
  ad_connect rx_link_dnconverter/out_link_valid axi_ad9675_tpl_core/link_valid
  ad_connect rx_link_dnconverter/out_link_sof axi_ad9675_tpl_core/link_sof

} else {
  ad_connect axi_ad9675_rx_jesd/rx_data_tdata axi_ad9675_tpl_core/link_data
  ad_connect axi_ad9675_rx_jesd/rx_data_tvalid axi_ad9675_tpl_core/link_valid
  ad_connect axi_ad9675_rx_jesd/rx_sof axi_ad9675_tpl_core/link_sof
}

if {$RX_NUM_OF_CONVERTERS > 1} {

  #connect DMA to TPL through cpack
  ad_ip_instance util_cpack2 util_ad9675_rx_cpack
  ad_ip_parameter util_ad9675_rx_cpack CONFIG.SAMPLE_DATA_WIDTH [expr $RX_SAMPLE_WIDTH*$RX_SAMPLES_PER_CHANNEL]
  ad_ip_parameter util_ad9675_rx_cpack CONFIG.NUM_OF_CHANNELS $RX_NUM_OF_CONVERTERS
  ad_ip_parameter util_ad9675_rx_cpack CONFIG.SAMPLES_PER_CHANNEL 1

  ad_connect  $rx_data_clk util_ad9675_rx_cpack/clk
  ad_connect  axi_ad9675_rx_jesd_rstgen/peripheral_reset util_ad9675_rx_cpack/reset

  for {set i 0} {$i < $RX_NUM_OF_CONVERTERS} {incr i} {
    ad_connect axi_ad9675_tpl_core/adc_data_$i util_ad9675_rx_cpack/fifo_wr_data_$i
    ad_connect axi_ad9675_tpl_core/adc_enable_$i util_ad9675_rx_cpack/enable_$i  
  }
  ad_connect axi_ad9675_tpl_core/adc_valid_0 util_ad9675_rx_cpack/fifo_wr_en

  ad_connect  util_ad9675_rx_cpack/packed_fifo_wr axi_ad9675_dma/fifo_wr
 # ad_connect  util_ad9675_rx_cpack/adc_sync axi_ad9675_dma/fifo_wr_sync
 # ad_connect  util_ad9675_rx_cpack/adc_data axi_ad9675_dma/fifo_wr_din

} else {
  #connect DMA to TPL directly
  ad_connect rx_ad9675_tpl_core/adc_valid_0 axi_ad9675_dma/fifo_wr_en
  ad_connect rx_ad9675_tpl_core/adc_data_0 axi_ad9675_dma/fifo_wr_din
}
#ad_connect  axi_ad9675_dma/fifo_wr_overflow axi_ad9675_tpl_core/adc_dovf
ad_connect  $rx_data_clk axi_ad9675_dma/fifo_wr_clk
ad_connect  sys_250m_resetn axi_ad9675_dma/m_dest_axi_aresetn;# sys_dma_resetn



# interconnect (cpu)

ad_cpu_interconnect 0x44A50000 axi_ad9675_xcvr
ad_cpu_interconnect 0x44A10000 axi_ad9675_tpl_core
ad_cpu_interconnect 0x44AA0000 axi_ad9675_rx_jesd
ad_cpu_interconnect 0x7c400000 axi_ad9675_dma
ad_cpu_interconnect 0x43C10000 axi_ad9675_rx_clkgen

#if {$sys_zynq == 0 || $sys_zynq == 1} {
    ad_mem_hp2_interconnect $sys_dma_clk sys_ps7/S_AXI_HP2
    ad_mem_hp2_interconnect $sys_dma_clk axi_ad9675_dma/m_dest_axi
    ad_mem_hp3_interconnect $sys_cpu_clk sys_ps7/S_AXI_HP3
    ad_mem_hp3_interconnect $sys_cpu_clk axi_ad9675_xcvr/m_axi
#}

# interrupts

ad_cpu_interrupt ps-11 mb-14 axi_ad9675_rx_jesd/irq
ad_cpu_interrupt ps-13 mb-12 axi_ad9675_dma/irq
