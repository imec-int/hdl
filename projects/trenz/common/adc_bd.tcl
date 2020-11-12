
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

set RX_SAMPLES_PER_CHANNEL [expr $RX_NUM_OF_LANES * 32.0 / \
                                ($RX_NUM_OF_CONVERTERS * $RX_SAMPLE_WIDTH)] ; # L * 32 / (M * N)

set adc_fifo_name axi_ad9675_fifo
set adc_data_width [expr $RX_SAMPLE_WIDTH * $RX_NUM_OF_CONVERTERS * $RX_SAMPLES_PER_CHANNEL]

# adc peripherals

ad_ip_instance axi_adxcvr axi_ad9675_xcvr
ad_ip_parameter axi_ad9675_xcvr CONFIG.NUM_OF_LANES $RX_NUM_OF_LANES
ad_ip_parameter axi_ad9675_xcvr CONFIG.QPLL_ENABLE 0
ad_ip_parameter axi_ad9675_xcvr CONFIG.TX_OR_RX_N 0

adi_axi_jesd204_rx_create axi_ad9675_jesd $RX_NUM_OF_LANES

adi_tpl_jesd204_rx_create axi_ad9675_tpl_core $RX_NUM_OF_LANES \
                                               $RX_NUM_OF_CONVERTERS \
                                               $RX_SAMPLES_PER_FRAME \
                                               $RX_SAMPLE_WIDTH

ad_ip_instance util_cpack2 axi_ad9675_cpack [list \
  NUM_OF_CHANNELS $RX_NUM_OF_CONVERTERS \
  SAMPLES_PER_CHANNEL $RX_SAMPLES_PER_CHANNEL \
  SAMPLE_DATA_WIDTH $RX_SAMPLE_WIDTH \
  ]

ad_ip_instance axi_dmac axi_ad9675_dma
ad_ip_parameter axi_ad9675_dma CONFIG.DMA_TYPE_SRC 1
ad_ip_parameter axi_ad9675_dma CONFIG.DMA_TYPE_DEST 0
ad_ip_parameter axi_ad9675_dma CONFIG.ID 0
ad_ip_parameter axi_ad9675_dma CONFIG.AXI_SLICE_SRC 0
ad_ip_parameter axi_ad9675_dma CONFIG.AXI_SLICE_DEST 0
ad_ip_parameter axi_ad9675_dma CONFIG.SYNC_TRANSFER_START 0
ad_ip_parameter axi_ad9675_dma CONFIG.DMA_LENGTH_WIDTH 24
ad_ip_parameter axi_ad9675_dma CONFIG.DMA_2D_TRANSFER 0
ad_ip_parameter axi_ad9675_dma CONFIG.CYCLIC 0
ad_ip_parameter axi_ad9675_dma CONFIG.DMA_DATA_WIDTH_SRC $adc_data_width
ad_ip_parameter axi_ad9675_dma CONFIG.DMA_DATA_WIDTH_DEST 64

if {$sys_zynq == 0 || $sys_zynq == 1} {
  ad_adcfifo_create $adc_fifo_name $adc_data_width $adc_data_width $adc_fifo_address_width
}

# shared transceiver core

ad_ip_instance util_adxcvr util_daq3_xcvr
ad_ip_parameter util_daq3_xcvr CONFIG.RX_NUM_OF_LANES $RX_NUM_OF_LANES
ad_ip_parameter util_daq3_xcvr CONFIG.TX_NUM_OF_LANES $TX_NUM_OF_LANES
ad_ip_parameter util_daq3_xcvr CONFIG.QPLL_REFCLK_DIV 1
ad_ip_parameter util_daq3_xcvr CONFIG.QPLL_FBDIV_RATIO 1
ad_ip_parameter util_daq3_xcvr CONFIG.QPLL_FBDIV 0x30; # 20
ad_ip_parameter util_daq3_xcvr CONFIG.RX_OUT_DIV 1
ad_ip_parameter util_daq3_xcvr CONFIG.TX_OUT_DIV 1
ad_ip_parameter util_daq3_xcvr CONFIG.RX_DFE_LPM_CFG 0x0904
ad_ip_parameter util_daq3_xcvr CONFIG.RX_CDR_CFG 0x0B000023FF10400020

ad_connect  $sys_cpu_resetn util_daq3_xcvr/up_rstn
ad_connect  $sys_cpu_clk util_daq3_xcvr/up_clk

# reference clocks & resets

create_bd_port -dir I tx_ref_clk_0
create_bd_port -dir I rx_ref_clk_0

ad_xcvrpll  tx_ref_clk_0 util_daq3_xcvr/qpll_ref_clk_*
ad_xcvrpll  rx_ref_clk_0 util_daq3_xcvr/cpll_ref_clk_*
ad_xcvrpll  axi_ad9675_xcvr/up_pll_rst util_daq3_xcvr/up_cpll_rst_*

# connections (adc)

ad_xcvrcon  util_daq3_xcvr axi_ad9675_xcvr axi_ad9675_jesd
ad_connect  util_daq3_xcvr/rx_out_clk_0 axi_ad9675_tpl_core/link_clk
ad_connect  axi_ad9675_jesd/rx_sof axi_ad9675_tpl_core/link_sof
ad_connect  axi_ad9675_jesd/rx_data_tdata axi_ad9675_tpl_core/link_data
ad_connect  axi_ad9675_jesd/rx_data_tvalid axi_ad9675_tpl_core/link_valid
ad_connect  axi_ad9675_tpl_core/adc_valid_0 axi_ad9675_cpack/fifo_wr_en

if {$sys_zynq == 0 || $sys_zynq == 1} {
    ad_connect  util_daq3_xcvr/rx_out_clk_0 axi_ad9675_fifo/adc_clk
    ad_connect  axi_ad9675_jesd_rstgen/peripheral_reset axi_ad9675_fifo/adc_rst
    ad_connect  axi_ad9675_cpack/packed_fifo_wr_en axi_ad9675_fifo/adc_wr
    ad_connect  axi_ad9675_cpack/packed_fifo_wr_data axi_ad9675_fifo/adc_wdata
    ad_connect  $sys_dma_clk axi_ad9675_fifo/dma_clk
    ad_connect  $sys_dma_clk axi_ad9675_dma/s_axis_aclk
    ad_connect  $sys_dma_resetn axi_ad9675_dma/m_dest_axi_aresetn
    ad_connect  axi_ad9675_fifo/dma_wr axi_ad9675_dma/s_axis_valid
    ad_connect  axi_ad9675_fifo/dma_wdata axi_ad9675_dma/s_axis_data
    ad_connect  axi_ad9675_fifo/dma_wready axi_ad9675_dma/s_axis_ready
    ad_connect  axi_ad9675_fifo/dma_xfer_req axi_ad9675_dma/s_axis_xfer_req
    ad_connect  axi_ad9675_tpl_core/adc_dovf axi_ad9675_fifo/adc_wovf
}

ad_connect  util_daq3_xcvr/rx_out_clk_0 axi_ad9675_cpack/clk
ad_connect  axi_ad9675_jesd_rstgen/peripheral_reset axi_ad9675_cpack/reset

for {set i 0} {$i < $RX_NUM_OF_CONVERTERS} {incr i} {
  ad_connect  axi_ad9675_tpl_core/adc_enable_$i axi_ad9675_cpack/enable_$i
  ad_connect  axi_ad9675_tpl_core/adc_data_$i axi_ad9675_cpack/fifo_wr_data_$i
}

# interconnect (cpu)

ad_cpu_interconnect 0x44A50000 axi_ad9675_xcvr
ad_cpu_interconnect 0x44A10000 axi_ad9675_tpl_core
ad_cpu_interconnect 0x44AA0000 axi_ad9675_jesd
ad_cpu_interconnect 0x7c400000 axi_ad9675_dma


if {$sys_zynq == 0 || $sys_zynq == 1} {
    ad_mem_hp2_interconnect $sys_dma_clk sys_ps7/S_AXI_HP2
    ad_mem_hp2_interconnect $sys_dma_clk axi_ad9675_dma/m_dest_axi
    ad_mem_hp3_interconnect $sys_cpu_clk sys_ps7/S_AXI_HP3
    ad_mem_hp3_interconnect $sys_cpu_clk axi_ad9675_xcvr/m_axi
}

# interrupts

ad_cpu_interrupt ps-11 mb-14 axi_ad9675_jesd/irq
ad_cpu_interrupt ps-13 mb-12 axi_ad9675_dma/irq
