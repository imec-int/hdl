if [ -d "./boot" ] 
then
    echo "Directory ./boot exists." 
else
    echo "Error: Directory ./boot does not exist, creating dir"
    mkdir -p boot
fi
cp ./AD_trenz.srcs/sources_1/bd/system/hw_handoff/system.hwh ./boot/base.hwh
cp ./AD_trenz.runs/impl_1/system_top.bit ./boot/base.bit
cp ./AD_trenz.runs/impl_1/system_top.hwdef ./boot/base.hwdef
cp ./AD_trenz.runs/impl_1/system_top.tcl ./boot/base.tcl
cp ./AD_trenz.runs/impl_1/system_top.vdi ./boot/base.vdi
