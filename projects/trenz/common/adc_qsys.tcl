# JESD204B attributes

set RX_NUM_OF_LANES 4           ; # L
set RX_NUM_OF_CONVERTERS 2      ; # M
set RX_SAMPLES_PER_FRAME 1      ; # S
set RX_SAMPLE_WIDTH 16          ; # N/NP

set RX_SAMPLES_PER_CHANNEL [expr $RX_NUM_OF_LANES * 32 / ($RX_NUM_OF_CONVERTERS * $RX_SAMPLE_WIDTH)]

set adc_data_width [expr $RX_SAMPLE_WIDTH * $RX_NUM_OF_CONVERTERS * $RX_SAMPLES_PER_CHANNEL]

set TX_NUM_OF_LANES 0           ; # L
set TX_NUM_OF_CONVERTERS 2      ; # M
set TX_SAMPLES_PER_FRAME 1      ; # S
set TX_SAMPLE_WIDTH 16          ; # N/NP

set TX_SAMPLES_PER_CHANNEL [expr $TX_NUM_OF_LANES * 32 / ($TX_NUM_OF_CONVERTERS * $TX_SAMPLE_WIDTH)]

set dac_fifo_name avl_ad9152_fifo
set dac_data_width 128




# ad9675-xcvr

add_instance ad9675_jesd204 adi_jesd204
set_instance_parameter_value ad9675_jesd204 {ID} {1}
set_instance_parameter_value ad9675_jesd204 {TX_OR_RX_N} {0}
set_instance_parameter_value ad9675_jesd204 {LANE_RATE} {12333.3}
set_instance_parameter_value ad9675_jesd204 {REFCLK_FREQUENCY} {616.665}
set_instance_parameter_value ad9675_jesd204 {NUM_OF_LANES} {4}
set_instance_parameter_value ad9675_jesd204 {INPUT_PIPELINE_STAGES} {1}

add_connection sys_clk.clk ad9675_jesd204.sys_clk
add_connection sys_clk.clk_reset ad9675_jesd204.sys_resetn
add_interface rx_ref_clk clock sink
set_interface_property rx_ref_clk EXPORT_OF ad9675_jesd204.ref_clk
add_interface rx_serial_data conduit end
set_interface_property rx_serial_data EXPORT_OF ad9675_jesd204.serial_data
add_interface rx_sysref conduit end
set_interface_property rx_sysref EXPORT_OF ad9675_jesd204.sysref
add_interface rx_sync conduit end
set_interface_property rx_sync EXPORT_OF ad9675_jesd204.sync

# ad9675

add_instance axi_ad9675_tpl ad_ip_jesd204_tpl_adc
set_instance_parameter_value axi_ad9675_tpl {ID} {0}
set_instance_parameter_value axi_ad9675_tpl {NUM_CHANNELS} $RX_NUM_OF_CONVERTERS
set_instance_parameter_value axi_ad9675_tpl {NUM_LANES} $RX_NUM_OF_LANES
set_instance_parameter_value axi_ad9675_tpl {BITS_PER_SAMPLE} $RX_SAMPLE_WIDTH
set_instance_parameter_value axi_ad9675_tpl {CONVERTER_RESOLUTION} $RX_SAMPLE_WIDTH
set_instance_parameter_value axi_ad9675_tpl {TWOS_COMPLEMENT} {1}

add_connection ad9675_jesd204.link_clk axi_ad9675_tpl.link_clk
add_connection ad9675_jesd204.link_sof axi_ad9675_tpl.if_link_sof
add_connection ad9675_jesd204.link_data axi_ad9675_tpl.link_data
add_connection sys_clk.clk_reset axi_ad9675_tpl.s_axi_reset
add_connection sys_clk.clk axi_ad9675_tpl.s_axi_clock

# ad9675-pack

add_instance util_ad9675_cpack util_cpack2
set_instance_parameter_value util_ad9675_cpack {NUM_OF_CHANNELS} $RX_NUM_OF_CONVERTERS
set_instance_parameter_value util_ad9675_cpack {SAMPLES_PER_CHANNEL} $RX_NUM_OF_LANES
set_instance_parameter_value util_ad9675_cpack {SAMPLE_DATA_WIDTH} $RX_SAMPLE_WIDTH

add_connection ad9675_jesd204.link_clk util_ad9675_cpack.clk
add_connection ad9675_jesd204.link_reset util_ad9675_cpack.reset
add_connection axi_ad9675_tpl.adc_ch_0 util_ad9675_cpack.adc_ch_0
add_connection axi_ad9675_tpl.adc_ch_1 util_ad9675_cpack.adc_ch_1

# ad9675-fifo

add_instance ad9675_adcfifo util_adcfifo
set_instance_parameter_value ad9675_adcfifo {ADC_DATA_WIDTH} $adc_data_width
set_instance_parameter_value ad9675_adcfifo {DMA_DATA_WIDTH} $adc_data_width
set_instance_parameter_value ad9675_adcfifo {DMA_ADDRESS_WIDTH} {16}

add_connection sys_clk.clk_reset ad9675_adcfifo.if_adc_rst
add_connection ad9675_jesd204.link_clk ad9675_adcfifo.if_adc_clk
add_connection util_ad9675_cpack.if_packed_fifo_wr_en ad9675_adcfifo.if_adc_wr
add_connection util_ad9675_cpack.if_packed_fifo_wr_data ad9675_adcfifo.if_adc_wdata
add_connection sys_clk.clk ad9675_adcfifo.if_dma_clk

# ad9675-dma

add_instance axi_ad9675_dma axi_dmac
set_instance_parameter_value axi_ad9675_dma {DMA_DATA_WIDTH_SRC} $adc_data_width
set_instance_parameter_value axi_ad9675_dma {DMA_DATA_WIDTH_DEST} {128}
set_instance_parameter_value axi_ad9675_dma {DMA_LENGTH_WIDTH} {24}
set_instance_parameter_value axi_ad9675_dma {DMA_2D_TRANSFER} {0}
set_instance_parameter_value axi_ad9675_dma {SYNC_TRANSFER_START} {0}
set_instance_parameter_value axi_ad9675_dma {CYCLIC} {0}
set_instance_parameter_value axi_ad9675_dma {DMA_TYPE_DEST} {0}
set_instance_parameter_value axi_ad9675_dma {DMA_TYPE_SRC} {1}

add_connection sys_clk.clk axi_ad9675_dma.if_s_axis_aclk
add_connection ad9675_adcfifo.m_axis axi_ad9675_dma.s_axis
add_connection ad9675_adcfifo.if_dma_xfer_req axi_ad9675_dma.if_s_axis_xfer_req
add_connection ad9675_adcfifo.if_adc_wovf axi_ad9675_tpl.if_adc_dovf
add_connection sys_clk.clk_reset axi_ad9675_dma.s_axi_reset
add_connection sys_clk.clk axi_ad9675_dma.s_axi_clock
add_connection sys_clk.clk_reset axi_ad9675_dma.m_dest_axi_reset
add_connection sys_clk.clk axi_ad9675_dma.m_dest_axi_clock

# reconfig sharing

for {set i 0} {$i < 4} {incr i} {
  add_instance avl_adxcfg_${i} avl_adxcfg
  add_connection sys_clk.clk avl_adxcfg_${i}.rcfg_clk
  add_connection sys_clk.clk_reset avl_adxcfg_${i}.rcfg_reset_n
  add_connection avl_adxcfg_${i}.rcfg_m1 ad9675_jesd204.phy_reconfig_${i}
}

# addresses

ad_cpu_interconnect 0x00428000 avl_adxcfg_0.rcfg_s0
ad_cpu_interconnect 0x00429000 avl_adxcfg_1.rcfg_s0
ad_cpu_interconnect 0x0042a000 avl_adxcfg_2.rcfg_s0
ad_cpu_interconnect 0x0042b000 avl_adxcfg_3.rcfg_s0

ad_cpu_interconnect 0x00440000 ad9675_jesd204.link_reconfig
ad_cpu_interconnect 0x00444000 ad9675_jesd204.link_management
ad_cpu_interconnect 0x00445000 ad9675_jesd204.link_pll_reconfig
ad_cpu_interconnect 0x00448000 avl_adxcfg_0.rcfg_s1
ad_cpu_interconnect 0x00449000 avl_adxcfg_1.rcfg_s1
ad_cpu_interconnect 0x0044a000 avl_adxcfg_2.rcfg_s1
ad_cpu_interconnect 0x0044b000 avl_adxcfg_3.rcfg_s1
ad_cpu_interconnect 0x0044c000 axi_ad9675_dma.s_axi
ad_cpu_interconnect 0x00450000 axi_ad9675_tpl.s_axi

# dma interconnects

ad_dma_interconnect axi_ad9675_dma.m_dest_axi

# interrupts

ad_cpu_interrupt 8 ad9675_jesd204.interrupt
ad_cpu_interrupt 10 axi_ad9675_dma.interrupt_sender

