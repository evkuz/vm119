#!/bin/bash
ARR_FILE=./nodes_for_edit.lst

iparray=($(cat $ARR_FILE))

for index in ${!iparray[*]}
do

FQDN=$(echo ${iparray[$index]} | sed -e 's/\./-/g').jinr.ru
echo "$FQDN"
done
