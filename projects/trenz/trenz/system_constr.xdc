# FMC_HPC 0

# daq3

set_property  -dict {PACKAGE_PIN  AF16   IOSTANDARD LVDS} [get_ports rx_sync_p]                                ; ## D08  FMC_HPC0_LA01_CC_P
set_property  -dict {PACKAGE_PIN  AF17   IOSTANDARD LVDS} [get_ports rx_sync_n]                                ; ## D09  FMC_HPC0_LA01_CC_N
set_property  -dict {PACKAGE_PIN  AD19    IOSTANDARD LVDS DIFF_TERM_ADV TERM_100} [get_ports rx_sysref_p]       ; ## G09  FMC_HPC0_LA03_P
set_property  -dict {PACKAGE_PIN  AE19    IOSTANDARD LVDS DIFF_TERM_ADV TERM_100} [get_ports rx_sysref_n]       ; ## G10  FMC_HPC0_LA03_N

set_property  -dict {PACKAGE_PIN  AH17   IOSTANDARD LVCMOS18} [get_ports spi_csn_clk]                          ; ## D11  FMC_HPC0_LA05_P
set_property  -dict {PACKAGE_PIN  AJ17   IOSTANDARD LVCMOS18} [get_ports spi_clk]                              ; ## D12  FMC_HPC0_LA05_N
set_property  -dict {PACKAGE_PIN  AK18    IOSTANDARD LVCMOS18} [get_ports spi_csn_dac]                          ; ## C14  FMC_HPC0_LA10_P
set_property  -dict {PACKAGE_PIN  AK15    IOSTANDARD LVCMOS18} [get_ports spi_csn_adc]                          ; ## D15  FMC_HPC0_LA09_N
set_property  -dict {PACKAGE_PIN  AJ15    IOSTANDARD LVCMOS18} [get_ports spi_sdio]                             ; ## D14  FMC_HPC0_LA09_P
set_property  -dict {PACKAGE_PIN  AF18   IOSTANDARD LVCMOS18} [get_ports spi_dir]                              ; ## C11  FMC_HPC0_LA06_N

set_property  -dict {PACKAGE_PIN  AD15   IOSTANDARD LVDS}  [get_ports sysref_p]                                ; ## D17  FMC_HPC0_LA13_P
set_property  -dict {PACKAGE_PIN  AE15   IOSTANDARD LVDS}  [get_ports sysref_n]                                ; ## D18  FMC_HPC0_LA13_N
set_property  -dict {PACKAGE_PIN  AK12    IOSTANDARD LVCMOS18} [get_ports dac_txen]                             ; ## G16  FMC_HPC0_LA12_N
set_property  -dict {PACKAGE_PIN  AE18   IOSTANDARD LVCMOS18} [get_ports adc_pd]                               ; ## C10  FMC_HPC0_LA06_P

set_property  -dict {PACKAGE_PIN  AH16    IOSTANDARD LVCMOS18} [get_ports clkd_status[0]]                       ; ## G12  FMC_HPC0_LA08_P
set_property  -dict {PACKAGE_PIN  AG16    IOSTANDARD LVCMOS18} [get_ports clkd_status[1]]                       ; ## G13  FMC_HPC0_LA08_N
set_property  -dict {PACKAGE_PIN  AK13    IOSTANDARD LVCMOS18} [get_ports dac_irq]                              ; ## G15  FMC_HPC0_LA12_P
set_property  -dict {PACKAGE_PIN  AJ14   IOSTANDARD LVCMOS18} [get_ports adc_fda]                              ; ## H16  FMC_HPC0_LA11_P
set_property  -dict {PACKAGE_PIN  AK14   IOSTANDARD LVCMOS18} [get_ports adc_fdb]                              ; ## H17  FMC_HPC0_LA11_N

set_property  -dict {PACKAGE_PIN  AJ16    IOSTANDARD LVDS DIFF_TERM_ADV TERM_100} [get_ports trig_p]            ; ## H13  FMC_HPC0_LA07_P
set_property  -dict {PACKAGE_PIN  AK16    IOSTANDARD LVDS DIFF_TERM_ADV TERM_100} [get_ports trig_n]            ; ## H14  FMC_HPC0_LA07_N

#set_property LOC GTHE5_COMMON_X1Y1 [get_cells -hierarchical -filter {NAME =~ *i_ibufds_rx_ref_clk}]
#set_property LOC GTHE4_COMMON_X1Y2 [get_cells -hierarchical -filter {NAME =~ *i_ibufds_tx_ref_clk}]

#set_property LOC GTHE4_CHANNEL_X1Y8  [get_cells -hierarchical -filter {NAME =~ *util_daq3_xcvr/inst/i_xch_0/i_gthe4_channel}]
#set_property LOC GTHE4_CHANNEL_X1Y10 [get_cells -hierarchical -filter {NAME =~ *util_daq3_xcvr/inst/i_xch_1/i_gthe4_channel}]
#set_property LOC GTHE4_CHANNEL_X1Y11 [get_cells -hierarchical -filter {NAME =~ *util_daq3_xcvr/inst/i_xch_2/i_gthe4_channel}]
#set_property LOC GTHE4_CHANNEL_X1Y9  [get_cells -hierarchical -filter {NAME =~ *util_daq3_xcvr/inst/i_xch_3/i_gthe4_channel}]

# clocks

create_clock -name rx_ref_clk   -period  1.60 [get_ports rx_ref_clk_p]
create_clock -name rx_div_clk   -period  3.20 [get_pins i_system_wrapper/system_i/util_daq3_xcvr/inst/i_xch_0/i_gthe4_channel/RXOUTCLK]

# pin assignments below are for reference only and are ignored by the tool!

set_property  -dict {PACKAGE_PIN  N8  } [get_ports rx_ref_clk_p]                                      ; ## B20  FMC_HPC0_GBTCLK1_M2C_C_P
set_property  -dict {PACKAGE_PIN  N7  } [get_ports rx_ref_clk_n]                                      ; ## B21  FMC_HPC0_GBTCLK1_M2C_C_N

set_property  -dict {PACKAGE_PIN  P2  } [get_ports rx_data_p[0]]                                      ; ## A10  FMC_HPC0_DP3_M2C_P
set_property  -dict {PACKAGE_PIN  P1  } [get_ports rx_data_n[0]]                                      ; ## A11  FMC_HPC0_DP3_M2C_N
set_property  -dict {PACKAGE_PIN  V2  } [get_ports rx_data_p[1]]                                      ; ## C06  FMC_HPC0_DP0_M2C_P
set_property  -dict {PACKAGE_PIN  V1  } [get_ports rx_data_n[1]]                                      ; ## C07  FMC_HPC0_DP0_M2C_N
set_property  -dict {PACKAGE_PIN  T2  } [get_ports rx_data_p[2]]                                      ; ## A06  FMC_HPC0_DP2_M2C_P
set_property  -dict {PACKAGE_PIN  T1  } [get_ports rx_data_n[2]]                                      ; ## A07  FMC_HPC0_DP2_M2C_N
set_property  -dict {PACKAGE_PIN  U4  } [get_ports rx_data_p[3]]                                      ; ## A02  FMC_HPC0_DP1_M2C_P
set_property  -dict {PACKAGE_PIN  U3  } [get_ports rx_data_n[3]]                                      ; ## A03  FMC_HPC0_DP1_M2C_N

### FILES FROM SK_DEMO1
##System Controller IP

##J3:31 LED_HD
#set_property PACKAGE_PIN K11 [get_ports gpio_bd_o[0]]
#set_property  -dict {PACKAGE_PIN  K11  IOSTANDARD LVCMOS33} [get_ports gpio_bd_o[0]]           ; ## GPIO_LED_0
##J3:41
#set_property PACKAGE_PIN E14 [get_ports BASE_sc5]
##J3:45
#set_property PACKAGE_PIN C12 [get_ports BASE_sc6]
##J3:47
#set_property PACKAGE_PIN D12 [get_ports BASE_sc7]
##J3:32
#set_property PACKAGE_PIN J12 [get_ports BASE_sc10_io]
##J3:34
#set_property PACKAGE_PIN K13 [get_ports BASE_sc11]
##J3:36
#set_property PACKAGE_PIN A13 [get_ports BASE_sc12]
##J3:38
#set_property PACKAGE_PIN A14 [get_ports BASE_sc13]
##J3:40
#set_property PACKAGE_PIN E12 [get_ports BASE_sc14]
##J3:42
#set_property PACKAGE_PIN F12 [get_ports BASE_sc15]
##J3:46 CAN S
#set_property PACKAGE_PIN A12 [get_ports BASE_sc16]
##J3:48 LED_XMOD
#set_property PACKAGE_PIN B12 [get_ports BASE_sc17]
##J3:50 CAN TX 
#set_property PACKAGE_PIN B14 [get_ports BASE_sc18]
##J3:52 CAN RX 
#set_property PACKAGE_PIN C14 [get_ports BASE_sc19]

#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc0]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc5]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc6]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc7]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc10_io]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc11]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc12]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc13]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc14]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc15]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc16]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc17]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc18]
#set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc19]

# PLL
#J4:74
#set_property PACKAGE_PIN AF15 [get_ports {si570_clk_p[0]}]
#set_property IOSTANDARD LVDS [get_ports {si570_clk_p[0]}]
#set_property IOSTANDARD LVDS [get_ports {si570_clk_n[0]}]



# Audio Codec
#LRCLK		J3:49 B47_L9_N
#BCLK		J3:51 B47_L9_P
#DAC_SDATA	J3:53 B47_L7_N
#ADC_SDATA	J3:55 B47_L7_P
#set_property PACKAGE_PIN G14 [get_ports I2S_lrclk ]
#set_property PACKAGE_PIN H14 [get_ports I2S_bclk ]
#set_property PACKAGE_PIN C13 [get_ports I2S_sdin ]
#set_property PACKAGE_PIN D14 [get_ports I2S_sdout ]
#set_property IOSTANDARD LVCMOS18 [get_ports I2S_lrclk ]
#set_property IOSTANDARD LVCMOS18 [get_ports I2S_bclk ]
#set_property IOSTANDARD LVCMOS18 [get_ports I2S_sdin ]
#set_property IOSTANDARD LVCMOS18 [get_ports I2S_sdout ]


###FILES FROM MAIN CONSTRAINTS FILE


# # MGT Lanes
# # Bank 224 - GTH
# # lane 0
# set_property PACKAGE_PIN V2 [get_ports B224_RX0_P]
# set_property PACKAGE_PIN V1 [get_ports B224_RX0_N]
# set_property PACKAGE_PIN W4 [get_ports B224_TX0_P]
# set_property PACKAGE_PIN W3 [get_ports B224_TX0_N]
# # lane 1
# set_property PACKAGE_PIN U4 [get_ports B224_RX1_P]
# set_property PACKAGE_PIN U3 [get_ports B224_RX1_N]
# set_property PACKAGE_PIN V6 [get_ports B224_TX1_P]
# set_property PACKAGE_PIN V5 [get_ports B224_TX1_N]
# # lane 2
# set_property PACKAGE_PIN T2 [get_ports B224_RX2_P]
# set_property PACKAGE_PIN T1 [get_ports B224_RX2_N]
# set_property PACKAGE_PIN T6 [get_ports B224_TX2_P]
# set_property PACKAGE_PIN T5 [get_ports B224_TX2_N]
# # lane 3
# set_property PACKAGE_PIN V2 [get_ports B224_RX3_P]
# set_property PACKAGE_PIN V1 [get_ports B224_RX3_N]
# set_property PACKAGE_PIN W4 [get_ports B224_TX3_P]
# set_property PACKAGE_PIN W3 [get_ports B224_TX3_N]
# #clocks
# set_property PACKAGE_PIN R8 [get_ports B224_CLK0_P]; # carrier board
# set_property PACKAGE_PIN R7 [get_ports B224_CLK0_N]; # carrier board
# set_property PACKAGE_PIN N8 [get_ports B224_CLK1_P]; # On-board Si5345A
# set_property PACKAGE_PIN N7 [get_ports B224_CLK1_N]; # On-board Si5345A
# # Bank 225 - GTH
# # lane 0
# set_property PACKAGE_PIN N4 [get_ports B225_RX0_P]
# set_property PACKAGE_PIN N3 [get_ports B225_RX0_N]
# set_property PACKAGE_PIN P6 [get_ports B225_TX0_P]
# set_property PACKAGE_PIN P5 [get_ports B225_TX0_N]
# # lane 1
# set_property PACKAGE_PIN M2 [get_ports B225_RX1_P]
# set_property PACKAGE_PIN M1 [get_ports B225_RX1_N]
# set_property PACKAGE_PIN M6 [get_ports B225_TX1_P]
# set_property PACKAGE_PIN M5 [get_ports B225_TX1_N]
# # lane 2
# set_property PACKAGE_PIN K2 [get_ports B225_RX2_P]
# set_property PACKAGE_PIN K1 [get_ports B225_RX2_N]
# set_property PACKAGE_PIN L4 [get_ports B225_TX2_P]
# set_property PACKAGE_PIN L3 [get_ports B225_TX2_N]
# # lane 3
# set_property PACKAGE_PIN J4 [get_ports B225_RX3_P]
# set_property PACKAGE_PIN J3 [get_ports B225_RX3_N]
# set_property PACKAGE_PIN K6 [get_ports B225_TX3_P]
# set_property PACKAGE_PIN K5 [get_ports B225_TX3_N]
# #clocks
# set_property PACKAGE_PIN L8 [get_ports B225_CLK0_P]; # carrier board
# set_property PACKAGE_PIN L7 [get_ports B225_CLK0_N]; # carrier board
# set_property PACKAGE_PIN J8 [get_ports B225_CLK1_P]; # On-board Si5345A
# set_property PACKAGE_PIN J7 [get_ports B225_CLK1_N]; # On-board Si5345A
# # Bank 226 - GTH
# # lane 0
# set_property PACKAGE_PIN H2 [get_ports B226_RX0_P]
# set_property PACKAGE_PIN H1 [get_ports B226_RX0_N]
# set_property PACKAGE_PIN H6 [get_ports B226_TX0_P]
# set_property PACKAGE_PIN H5 [get_ports B226_TX0_N]
# # lane 1
# set_property PACKAGE_PIN G4 [get_ports B226_RX1_P]
# set_property PACKAGE_PIN G3 [get_ports B226_RX1_N]
# set_property PACKAGE_PIN G8 [get_ports B226_TX1_P]
# set_property PACKAGE_PIN G7 [get_ports B226_TX1_N]
# # lane 2
# set_property PACKAGE_PIN F2 [get_ports B226_RX2_P]
# set_property PACKAGE_PIN F1 [get_ports B226_RX2_N]
# set_property PACKAGE_PIN F6 [get_ports B226_TX2_P]
# set_property PACKAGE_PIN F5 [get_ports B226_TX2_N]
# # lane 3
# set_property PACKAGE_PIN E4 [get_ports B226_RX3_P]
# set_property PACKAGE_PIN E3 [get_ports B226_RX3_N]
# set_property PACKAGE_PIN E8 [get_ports B226_TX3_P]
# set_property PACKAGE_PIN E7 [get_ports B226_TX3_N]
# #clocks
# set_property PACKAGE_PIN H10 [get_ports B226_CLK0_P]; # On-board Si5345A
# set_property PACKAGE_PIN H9 [get_ports B226_CLK0_N]; # On-board Si5345A
# set_property PACKAGE_PIN F10 [get_ports B226_CLK1_P]; # carrier board
# set_property PACKAGE_PIN F9 [get_ports B226_CLK1_N]; # carrier board
# # Bank 227 - GTH
# # lane 0
# set_property PACKAGE_PIN D5 [get_ports B227_RX0_P]
# set_property PACKAGE_PIN D6 [get_ports B227_RX0_N]
# set_property PACKAGE_PIN D1 [get_ports B227_TX0_P]
# set_property PACKAGE_PIN D2 [get_ports B227_TX0_N]
# # lane 1
# set_property PACKAGE_PIN C7 [get_ports B227_RX1_P]
# set_property PACKAGE_PIN C8 [get_ports B227_RX1_N]
# set_property PACKAGE_PIN C3 [get_ports B227_TX1_P]
# set_property PACKAGE_PIN C4 [get_ports B227_TX1_N]
# # lane 2
# set_property PACKAGE_PIN B5 [get_ports B227_RX2_P]
# set_property PACKAGE_PIN B6 [get_ports B227_RX2_N]
# set_property PACKAGE_PIN B1 [get_ports B227_TX2_P]
# set_property PACKAGE_PIN B2 [get_ports B227_TX2_N]
# # lane 3
# set_property PACKAGE_PIN A7 [get_ports B227_RX3_P]
# set_property PACKAGE_PIN A8 [get_ports B227_RX3_N]
# set_property PACKAGE_PIN A3 [get_ports B227_TX3_P]
# set_property PACKAGE_PIN A4 [get_ports B227_TX3_N]
# #clocks
# set_property PACKAGE_PIN D10 [get_ports B227_CLK0_P]; # On-board Si5345A
# set_property PACKAGE_PIN D9 [get_ports B227_CLK0_N]; # On-board Si5345A
# set_property PACKAGE_PIN B10 [get_ports B227_CLK1_P]; # carrier board
# set_property PACKAGE_PIN B9 [get_ports B227_CLK1_N]; # carrier board
# # Bank 505 - GTR
# # lane 0
# set_property PACKAGE_PIN L29 [get_ports B505_RX0_P]
# set_property PACKAGE_PIN L30 [get_ports B505_RX0_N]
# set_property PACKAGE_PIN M27 [get_ports B505_TX0_P]
# set_property PACKAGE_PIN M28 [get_ports B505_TX0_N]
# # lane 1
# set_property PACKAGE_PIN J29 [get_ports B505_RX1_P]
# set_property PACKAGE_PIN J30 [get_ports B505_RX1_N]
# set_property PACKAGE_PIN K27 [get_ports B505_TX1_P]
# set_property PACKAGE_PIN K28 [get_ports B505_TX1_N]
# # lane 2
# set_property PACKAGE_PIN H27 [get_ports B505_RX2_P]
# set_property PACKAGE_PIN H28 [get_ports B505_RX2_N]
# set_property PACKAGE_PIN J25 [get_ports B505_TX2_P]
# set_property PACKAGE_PIN J26 [get_ports B505_TX2_N]
# # lane 3
# set_property PACKAGE_PIN G29 [get_ports B505_RX3_P]
# set_property PACKAGE_PIN G30 [get_ports B505_RX3_N]
# set_property PACKAGE_PIN G25 [get_ports B505_TX3_P]
# set_property PACKAGE_PIN G26 [get_ports B505_TX3_N]
# #clocks
# set_property PACKAGE_PIN M23 [get_ports B505_CLK0_P]; # carrier board
# set_property PACKAGE_PIN M24 [get_ports B505_CLK0_N]; # carrier board
# set_property PACKAGE_PIN L25 [get_ports B505_CLK1_P]; # carrier board
# set_property PACKAGE_PIN L26 [get_ports B505_CLK1_N]; # carrier board
# set_property PACKAGE_PIN K23 [get_ports B505_CLK2_P]; # On-board Si5345A
# set_property PACKAGE_PIN K24 [get_ports B505_CLK2_N]; # On-board Si5345A
# set_property PACKAGE_PIN H23 [get_ports B505_CLK3_P]; # On-board Si5345A
# set_property PACKAGE_PIN H24 [get_ports B505_CLK3_N]; # On-board Si5345A


# FMC connector
#set_property PACKAGE_PIN P2	[get_ports FMC-DP3_M2C_P ] 
#set_property PACKAGE_PIN P1	[get_ports FMC-DP3_M2C_N ] 
#set_property PACKAGE_PIN N4	[get_ports FMC-DP4_M2C_P ] 
#set_property PACKAGE_PIN N3	[get_ports FMC-DP4_M2C_N ] 
#set_property PACKAGE_PIN M2	[get_ports FMC-DP5_M2C_P ] 
#set_property PACKAGE_PIN M1	[get_ports FMC-DP5_M2C_N ] 
#set_property PACKAGE_PIN U4	[get_ports FMC-DP1_M2C_P ] 
#set_property PACKAGE_PIN V6	[get_ports FMC-DP1_C2M_P ] 
#set_property PACKAGE_PIN V5	[get_ports FMC-DP1_C2M_N ] 
#set_property PACKAGE_PIN T6	[get_ports FMC-DP2_C2M_P ] 
#set_property PACKAGE_PIN T5	[get_ports FMC-DP2_C2M_N ] 
#set_property PACKAGE_PIN U3	[get_ports FMC-DP1_M2C_N ] 
#set_property PACKAGE_PIN R4	[get_ports FMC-DP3_C2M_P ] 
#set_property PACKAGE_PIN R3	[get_ports FMC-DP3_C2M_N ] 
#set_property PACKAGE_PIN P6	[get_ports FMC-DP4_C2M_P ] 
#set_property PACKAGE_PIN P5	[get_ports FMC-DP4_C2M_N ] 
#set_property PACKAGE_PIN M6	[get_ports FMC-DP5_C2M_P ] 
#set_property PACKAGE_PIN M5	[get_ports FMC-DP5_C2M_N ] 
#set_property PACKAGE_PIN T2	[get_ports FMC-DP2_M2C_P ] 
#set_property PACKAGE_PIN T1	[get_ports FMC-DP2_M2C_N ] 
#set_property PACKAGE_PIN J4	[get_ports FMC-DP7_M2C_P ] 
#set_property PACKAGE_PIN J3	[get_ports FMC-DP7_M2C_N ] 
#set_property PACKAGE_PIN K2	[get_ports FMC-DP6_M2C_P ] 
#set_property PACKAGE_PIN K1	[get_ports FMC-DP6_M2C_N ] 
#set_property PACKAGE_PIN L7	[get_ports FMC-GBTCLK1_M2C_P ] 
#set_property PACKAGE_PIN L8	[get_ports FMC-GBTCLK1_M2C_N ] 
#set_property PACKAGE_PIN G8	[get_ports FMC-DP9_C2M_P ] 
#set_property PACKAGE_PIN G7	[get_ports FMC-DP9_C2M_N ] 
#set_property PACKAGE_PIN H6	[get_ports FMC-DP8_C2M_P ] 
#set_property PACKAGE_PIN H5	[get_ports FMC-DP8_C2M_N ] 
#set_property PACKAGE_PIN K6	[get_ports FMC-DP7_C2M_P ] 
#set_property PACKAGE_PIN K5	[get_ports FMC-DP7_C2M_N ] 
#set_property PACKAGE_PIN L4	[get_ports FMC-DP6_C2M_P ] 
#set_property PACKAGE_PIN L3	[get_ports FMC-DP6_C2M_N ] 
#set_property PACKAGE_PIN G4	[get_ports FMC-DP9_M2C_P ] 
#set_property PACKAGE_PIN G3	[get_ports FMC-DP9_M2C_N ] 
#set_property PACKAGE_PIN H2	[get_ports FMC-DP8_M2C_P ] 
#set_property PACKAGE_PIN H1	[get_ports FMC-DP8_M2C_N ] 
#set_property PACKAGE_PIN AE18	[get_ports FMC-LA06_P ] 
#set_property PACKAGE_PIN AF18	[get_ports FMC-LA06_N ] 
#set_property PACKAGE_PIN AK18	[get_ports FMC-LA10_P ] 
#set_property PACKAGE_PIN AK17	[get_ports FMC-LA10_N ] 
#set_property PACKAGE_PIN AD16	[get_ports FMC-LA14_P ] 
#set_property PACKAGE_PIN AC16	[get_ports FMC-LA14_N ] 
#set_property PACKAGE_PIN W4	[get_ports FMC-DP0_C2M_P ] 
#set_property PACKAGE_PIN AH7	[get_ports FMC-LA18_P_CC ] 
#set_property PACKAGE_PIN AJ7	[get_ports FMC-LA18_N_CC ] 
#set_property PACKAGE_PIN AF8	[get_ports FMC-LA27_P ] 
#set_property PACKAGE_PIN AF7	[get_ports FMC-LA27_N ] 
#set_property PACKAGE_PIN W3	[get_ports FMC-DP0_C2M_N ] 
#set_property PACKAGE_PIN V2	[get_ports FMC-DP0_M2C_P ] 
#set_property PACKAGE_PIN V1	[get_ports FMC-DP0_M2C_N ] 
#set_property PACKAGE_PIN AH17	[get_ports FMC-LA05_P ] 
#set_property PACKAGE_PIN AJ17	[get_ports FMC-LA05_N ] 
#set_property PACKAGE_PIN AJ15	[get_ports FMC-LA09_P ] 
#set_property PACKAGE_PIN AK15	[get_ports FMC-LA09_N ] 
#set_property PACKAGE_PIN AE15	[get_ports FMC-LA13_P ] 
#set_property PACKAGE_PIN AD15	[get_ports FMC-LA13_N ] 
#set_property PACKAGE_PIN AG6	[get_ports FMC-LA17_P_CC ] 
#set_property PACKAGE_PIN AG5	[get_ports FMC-LA17_N_CC ] 
#set_property PACKAGE_PIN AK9	[get_ports FMC-LA23_P ] 
#set_property PACKAGE_PIN AK8	[get_ports FMC-LA23_N ] 
#set_property PACKAGE_PIN AJ10	[get_ports FMC-LA26_P ] 
#set_property PACKAGE_PIN AK10	[get_ports FMC-LA26_N ] 
#set_property PACKAGE_PIN R7	[get_ports FMC-GBTCLK0_M2C_P ] 
#set_property PACKAGE_PIN R8	[get_ports FMC-GBTCLK0_M2C_N ] 
#set_property PACKAGE_PIN AF16	[get_ports FMC-LA01_P_CC ] 
#set_property PACKAGE_PIN AF17	[get_ports FMC-LA01_N_CC ] 
#set_property PACKAGE_PIN AD5	[get_ports FMC-HA09_N ] 
#set_property PACKAGE_PIN AC8	[get_ports FMC-HA13_P ] 
#set_property PACKAGE_PIN AC7	[get_ports FMC-HA13_N ] 
#set_property PACKAGE_PIN AC11	[get_ports FMC-HA16_P ] 
#set_property PACKAGE_PIN AB11	[get_ports FMC-HA16_N ] 
#set_property PACKAGE_PIN AC12	[get_ports FMC-HA20_P ] 
#set_property PACKAGE_PIN AD12	[get_ports FMC-HA20_N ] 
#set_property PACKAGE_PIN AA8	[get_ports FMC-HA01_P_CC ] 
#set_property PACKAGE_PIN AE14	[get_ports FMC-HB03_P ] 
#set_property PACKAGE_PIN AE13	[get_ports FMC-HB03_N ] 
#set_property PACKAGE_PIN AD14	[get_ports FMC-HB05_P ] 
#set_property PACKAGE_PIN AC14	[get_ports FMC-HB05_N ] 
#set_property PACKAGE_PIN AG4	[get_ports FMC-HB09_P ] 
#set_property PACKAGE_PIN AG3	[get_ports FMC-HB09_N ] 
#set_property PACKAGE_PIN AB8	[get_ports FMC-HA01_N_CC ] 
#set_property PACKAGE_PIN E15	[get_ports FMC-HB13_P ] 
#set_property PACKAGE_PIN D15	[get_ports FMC-HB13_N ] 
#set_property PACKAGE_PIN K15	[get_ports FMC-HB19_P ] 
#set_property PACKAGE_PIN K14	[get_ports FMC-HB19_N ] 
#set_property PACKAGE_PIN C17	[get_ports FMC-HB21_P ] 
#set_property PACKAGE_PIN B16	[get_ports FMC-HB21_N ] 
#set_property PACKAGE_PIN W8	[get_ports FMC-HA05_P ] 
#set_property PACKAGE_PIN Y8	[get_ports FMC-HA05_N ] 
#set_property PACKAGE_PIN AE5	[get_ports FMC-HA09_P ] 
#set_property PACKAGE_PIN AD9	[get_ports FMC-HA08_P ] 
#set_property PACKAGE_PIN AC9	[get_ports FMC-HA08_N ] 
#set_property PACKAGE_PIN AB9	[get_ports FMC-HA12_P ] 
#set_property PACKAGE_PIN AB10	[get_ports FMC-HA12_N ] 
#set_property PACKAGE_PIN AD11	[get_ports FMC-HA15_P ] 
#set_property PACKAGE_PIN AD10	[get_ports FMC-HA15_N ] 
#set_property PACKAGE_PIN AA5	[get_ports FMC-HA19_P ] 
#set_property PACKAGE_PIN AA6	[get_ports FMC-HA19_N ] 
#set_property PACKAGE_PIN AB13	[get_ports FMC-HB02_P ] 
#set_property PACKAGE_PIN AA13	[get_ports FMC-HB02_N ] 
#set_property PACKAGE_PIN AA14	[get_ports FMC-HB04_P ] 
#set_property PACKAGE_PIN AB14	[get_ports FMC-HB04_N ] 
#set_property PACKAGE_PIN AH3	[get_ports FMC-HB08_P ] 
#set_property PACKAGE_PIN AH2	[get_ports FMC-HB08_N ] 
#set_property PACKAGE_PIN J14	[get_ports FMC-HB12_P ] 
#set_property PACKAGE_PIN J15	[get_ports FMC-HB12_N ] 
#set_property PACKAGE_PIN D16	[get_ports FMC-HB16_P ] 
#set_property PACKAGE_PIN C16	[get_ports FMC-HB16_N ] 
#set_property PACKAGE_PIN J16	[get_ports FMC-HB20_P ] 
#set_property PACKAGE_PIN H16	[get_ports FMC-HB20_N ] 
#set_property PACKAGE_PIN AB6	[get_ports FMC-HA00_P_CC ] 
#set_property PACKAGE_PIN AB5	[get_ports FMC-HA00_N_CC ] 
#set_property PACKAGE_PIN AC6	[get_ports FMC-HA04_P ] 
#set_property PACKAGE_PIN AD6	[get_ports FMC-HA04_N ] 
#set_property PACKAGE_PIN AE19	[get_ports FMC-LA03_N ] 
#set_property PACKAGE_PIN AH16	[get_ports FMC-LA08_P ] 
#set_property PACKAGE_PIN AG16	[get_ports FMC-LA08_N ] 
#set_property PACKAGE_PIN AK13	[get_ports FMC-LA12_P ] 
#set_property PACKAGE_PIN AK12	[get_ports FMC-LA12_N ] 
#set_property PACKAGE_PIN AG13	[get_ports FMC-LA16_P ] 
#set_property PACKAGE_PIN AH13	[get_ports FMC-LA16_N ] 
#set_property PACKAGE_PIN G16	[get_ports FMC-CLK1_M2C_P ] 
#set_property PACKAGE_PIN AJ11	[get_ports FMC-LA20_P ] 
#set_property PACKAGE_PIN AK11	[get_ports FMC-LA20_N ] 
#set_property PACKAGE_PIN AK7	[get_ports FMC-LA22_P ] 
#set_property PACKAGE_PIN AK6	[get_ports FMC-LA22_N ] 
#set_property PACKAGE_PIN AG10	[get_ports FMC-LA25_P ] 
#set_property PACKAGE_PIN AF10	[get_ports FMC-LA25_N ] 
#set_property PACKAGE_PIN G15	[get_ports FMC-CLK1_M2C_N ] 
#set_property PACKAGE_PIN AH12	[get_ports FMC-LA29_P ] 
#set_property PACKAGE_PIN AJ12	[get_ports FMC-LA29_N ] 
#set_property PACKAGE_PIN AJ5	[get_ports FMC-LA31_P ] 
#set_property PACKAGE_PIN AK5	[get_ports FMC-LA31_N ] 
#set_property PACKAGE_PIN AF12	[get_ports FMC-LA33_P ] 
#set_property PACKAGE_PIN AF11	[get_ports FMC-LA33_N ] 
#set_property PACKAGE_PIN AD17	[get_ports FMC-LA00_P_CC ] 
#set_property PACKAGE_PIN AE17	[get_ports FMC-LA00_N_CC ] 
#set_property PACKAGE_PIN AD19	[get_ports FMC-LA03_P ] 
#set_property PACKAGE_PIN AG18	[get_ports FMC-LA04_P ] 
#set_property PACKAGE_PIN AH18	[get_ports FMC-LA04_N ] 
#set_property PACKAGE_PIN AJ16	[get_ports FMC-LA07_P ] 
#set_property PACKAGE_PIN AK16	[get_ports FMC-LA07_N ] 
#set_property PACKAGE_PIN AJ14	[get_ports FMC-LA11_P ] 
#set_property PACKAGE_PIN AK14	[get_ports FMC-LA11_N ] 
#set_property PACKAGE_PIN AB16	[get_ports FMC-LA15_P ] 
#set_property PACKAGE_PIN AA16	[get_ports FMC-LA15_N ] 
#set_property PACKAGE_PIN AE9	[get_ports FMC-LA19_P ] 
#set_property PACKAGE_PIN AE8	[get_ports FMC-LA19_N ] 
#set_property PACKAGE_PIN AK4	[get_ports FMC-LA21_P ] 
#set_property PACKAGE_PIN AJ4	[get_ports FMC-LA21_N ] 
#set_property PACKAGE_PIN AF6	[get_ports FMC-LA24_P ] 
#set_property PACKAGE_PIN AF5	[get_ports FMC-LA24_N ] 
#set_property PACKAGE_PIN AK2	[get_ports FMC-LA28_P ] 
#set_property PACKAGE_PIN AK3	[get_ports FMC-LA28_N ] 
#set_property PACKAGE_PIN AH11	[get_ports FMC-LA30_P ] 
#set_property PACKAGE_PIN AG11	[get_ports FMC-LA30_N ] 
#set_property PACKAGE_PIN AH9	[get_ports FMC-LA32_P ] 
#set_property PACKAGE_PIN AJ9	[get_ports FMC-LA32_N ] 
#set_property PACKAGE_PIN AF15	[get_ports FMC-CLK0_M2C_P ] 
#set_property PACKAGE_PIN AG15	[get_ports FMC-CLK0_M2C_N ] 
#set_property PACKAGE_PIN AC18	[get_ports FMC-LA02_P ] 
#set_property PACKAGE_PIN AC17	[get_ports FMC-LA02_N ] 
#set_property PACKAGE_PIN AA12	[get_ports FMC-HA07_N ] 
#set_property PACKAGE_PIN AC1	[get_ports FMC-HA11_P ] 
#set_property PACKAGE_PIN AB1	[get_ports FMC-HA11_N ] 
#set_property PACKAGE_PIN AE2	[get_ports FMC-HA14_P ] 
#set_property PACKAGE_PIN AD2	[get_ports FMC-HA14_N ] 
#set_property PACKAGE_PIN AE1	[get_ports FMC-HA18_P ] 
#set_property PACKAGE_PIN AD1	[get_ports FMC-HA18_N ] 
#set_property PACKAGE_PIN AC2	[get_ports FMC-HA22_P ] 
#set_property PACKAGE_PIN AC3	[get_ports FMC-HA22_N ] 
#set_property PACKAGE_PIN AA15	[get_ports FMC-HB01_P ] 
#set_property PACKAGE_PIN AB15	[get_ports FMC-HB01_N ] 
#set_property PACKAGE_PIN AJ1	[get_ports FMC-HB07_P ] 
#set_property PACKAGE_PIN AJ2	[get_ports FMC-HB07_N ] 
#set_property PACKAGE_PIN AF2	[get_ports FMC-HB11_P ] 
#set_property PACKAGE_PIN AF3	[get_ports FMC-HB11_N ] 
#set_property PACKAGE_PIN L15	[get_ports FMC-HB15_P ] 
#set_property PACKAGE_PIN L14	[get_ports FMC-HB15_N ] 
#set_property PACKAGE_PIN A17	[get_ports FMC-HB18_P ] 
#set_property PACKAGE_PIN A16	[get_ports FMC-HB18_N ] 
#set_property PACKAGE_PIN AA2	[get_ports FMC-HA03_P ] 
#set_property PACKAGE_PIN AA1	[get_ports FMC-HA03_N ] 
#set_property PACKAGE_PIN AA11	[get_ports FMC-HA07_P ] 
#set_property PACKAGE_PIN AB3	[get_ports FMC-HA06_P ] 
#set_property PACKAGE_PIN AA3	[get_ports FMC-HA06_N ] 
#set_property PACKAGE_PIN Y10	[get_ports FMC-HA10_P ] 
#set_property PACKAGE_PIN AA10	[get_ports FMC-HA10_N ] 
#set_property PACKAGE_PIN AD7	[get_ports FMC-HA17_P_CC ] 
#set_property PACKAGE_PIN AE7	[get_ports FMC-HA17_N_CC ] 
#set_property PACKAGE_PIN AB4	[get_ports FMC-HA21_P ] 
#set_property PACKAGE_PIN AC4	[get_ports FMC-HA21_N ] 
#set_property PACKAGE_PIN AD4	[get_ports FMC-HA23_P ] 
#set_property PACKAGE_PIN AE4	[get_ports FMC-HA23_N ] 
#set_property PACKAGE_PIN AG14	[get_ports FMC-HB00_P_CC ] 
#set_property PACKAGE_PIN AH14	[get_ports FMC-HB00_N_CC ] 
#set_property PACKAGE_PIN AG8	[get_ports FMC-HB06_P_CC ] 
#set_property PACKAGE_PIN AH8	[get_ports FMC-HB06_N_CC ] 
#set_property PACKAGE_PIN AH1	[get_ports FMC-HB10_P ] 
#set_property PACKAGE_PIN AG1	[get_ports FMC-HB10_N ] 
#set_property PACKAGE_PIN B15	[get_ports FMC-HB14_P ] 
#set_property PACKAGE_PIN A15	[get_ports FMC-HB14_N ] 
#set_property PACKAGE_PIN F16	[get_ports FMC-HB17_P_CC ] 
#set_property PACKAGE_PIN F15	[get_ports FMC-HB17_N_CC ] 
#set_property PACKAGE_PIN Y7	[get_ports FMC-HA02_P ] 
#set_property PACKAGE_PIN AA7	[get_ports FMC-HA02_N ] 


