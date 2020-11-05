#!/bin/bash
#showmount condor.jinr.ru --exports

umount /dev/mapper/wn-condor
umount /dev/mapper/wn-cvmfs

mount /dev/mapper/wn-condor
mount /dev/mapper/wn-cvmfs

service condor start
