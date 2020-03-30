#!/bin/bash
#Скрипт создает swap раздел на диске /dev/vdc
# Диск /dev/vdc добавлен у виртуалок как  volatile, тип fs=raw


# first check the output of swapon -s
SWAP_LINES="$(swapon -s | wc -l)"

if [ $SWAP_LINES -lt 3 ]
then
DEV="/dev/vdc"

mkswap $DEV
# Вывод blkid направляем в sed, получаем UUID swap-раздела/диска
SWAP_UUID="$(blkid $DEV | sed -n 's/.*\(UUID=".*\s\).*TYPE.*$/\1/p' | sed -n 's/"//gp')"

ONLY_UUID=$(echo "${SWAP_UUID}" | sed -n 's/UUID=//p')


swapon -U $ONLY_UUID

echo "${SWAP_UUID}	none	swap	sw	0  0" >> /etc/fstab
fi
