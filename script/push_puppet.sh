#!/bin/bash

# 21.01.2019 
# Функционал этого скрипта уже заложен в edit_wn.sh
# Можно этот скрипт удалять.
# ...
# Жалко :)
# Пусть будет как каркас для других подобных операций
#service puppet start

echo "This is push_puppet.sh"
echo " "

SETUPLOG="/var/log/node_setup.log"

ARR_FILE=./nodes_for_edit.lst

iparray=($(cat $ARR_FILE))



# on every agent from array

for index in ${!iparray[*]}
do

ssh root@${iparray[$index]} "puppet agent -t"

#--waitforcert 5
# service puppet stop
#echo "FQDN= $FQDN"
done






