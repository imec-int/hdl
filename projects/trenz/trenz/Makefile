####################################################################################
## Copyright 2018(c) Analog Devices, Inc.
## Auto-generated, do not modify!
####################################################################################


PROJECT_NAME := AD_trenz
BOARD:= pulsify
#ifeq (BOARD, baseboard)
#	echo "compiling for evaluation board"
M_DEPS += ../common/base_board/base_board.tcl
#endif
M_DEPS += ../common/adc_spi.v
M_DEPS += ../common/adc_bd.tcl
M_DEPS += ../../common/trenz/trenz_system_constr.xdc
M_DEPS += ../../common/trenz/trenz_system_bd.tcl
M_DEPS += ../../common/xilinx/dacfifo_bd.tcl
M_DEPS += ../../../library/jesd204/scripts/jesd204.tcl
M_DEPS += ../../../library/common/ad_iobuf.v

LIB_DEPS += axi_dmac
LIB_DEPS += axi_sysid
LIB_DEPS += jesd204/ad_ip_jesd204_tpl_adc
LIB_DEPS += jesd204/ad_ip_jesd204_tpl_dac
LIB_DEPS += jesd204/axi_jesd204_rx
LIB_DEPS += jesd204/axi_jesd204_tx
LIB_DEPS += jesd204/jesd204_rx
LIB_DEPS += jesd204/jesd204_tx
LIB_DEPS += jesd204/ad_ip_jesd204_link_dnconv
LIB_DEPS += sysid_rom
LIB_DEPS += util_dacfifo
LIB_DEPS += util_pack/util_cpack2
LIB_DEPS += util_pack/util_upack2
LIB_DEPS += xilinx/axi_adxcvr
LIB_DEPS += xilinx/util_adxcvr

include ../../scripts/project-xilinx.mk
