#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/ad/eng/support/software/linux/opt/xilinx/Vivado/2019.1/SDK/2019.1/bin:/ad/eng/support/software/linux/opt/xilinx/Vivado/2019.1/Vivado/2019.1/ids_lite/ISE/bin/lin64:/ad/eng/support/software/linux/opt/xilinx/Vivado/2019.1/Vivado/2019.1/bin
else
  PATH=/ad/eng/support/software/linux/opt/xilinx/Vivado/2019.1/SDK/2019.1/bin:/ad/eng/support/software/linux/opt/xilinx/Vivado/2019.1/Vivado/2019.1/ids_lite/ISE/bin/lin64:/ad/eng/support/software/linux/opt/xilinx/Vivado/2019.1/Vivado/2019.1/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/ad/eng/users/r/y/ryanbs/Desktop/EC413_Lab4/EC413_Lab4.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .init_design.begin.rst
EAStep vivado -log FA_64bit_RCA.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source FA_64bit_RCA.tcl -notrace


