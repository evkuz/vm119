#!/bin/bash
DEV="/dev/vdb" # Где искать lvm
LV_1="condor"
LV_2="cvmfs"




#pvs | grep $DEV

# Если вывод команды не пустой значит PV (physical volume) уже создан.
# Тогда проверяем наличие fs lvm
#lvs -a -o +devices
# "condor", "cvmfs"



# first check the output of swapon -s
LVM_LINES="$(lvs -a -o +devices)" # | grep $DEV $SWAP_LINES -lt 3 | wc -l)"

if [ $? -eq 0 ]
then
   echo "YES ! LVM exists on $DEV"
else

echo "SORRY ! LVM IS NOT exists on $DEV"
fi


