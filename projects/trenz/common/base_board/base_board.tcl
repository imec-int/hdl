#set ip_repo for base_board
set project_dir [get_property DIRECTORY [current_project]]
set lib_dirs  [get_property ip_repo_paths [current_project]]
lappend lib_dirs $project_dir/../common/base_board/ip_lib/
set_property ip_repo_paths $lib_dirs [current_project]
update_ip_catalog

#add base_board constraints file
add_files -fileset constrs_1 -quiet $project_dir/common/base_board/base_board.xdc [current_project]

#add ip blocks
create_bd_cell -type ip -vlnv trenz.biz:user:SC0808BF:1.0 SC0808BF_0
create_bd_cell -type ip -vlnv trenz.biz:user:RGPIO:1.0 RGPIO_0


#adapt zynqmp for base_board
set_property -dict [list CONFIG.PSU__CAN0__PERIPHERAL__ENABLE {1} CONFIG.PSU__CAN0__PERIPHERAL__IO {EMIO}] [get_bd_cells sys_ps8]

