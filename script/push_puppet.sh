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



#iparray=(13 21 75 80 115 130 133 134 171 175 185)
iparray=(6 75)
wn_count=2
ipadr_wn="10.93.221."

# on every agent from array
i=0
 while [ $i -lt $wn_count ]
do
FQDN="wn_221_${iparray[$i]}.jinr.ru"
ip_wn=$ipadr_wn${iparray[i]}
ssh root@$ip_wn "puppet agent -t"

#--waitforcert 5
# service puppet stop
#echo "FQDN= $FQDN"
i=$[$i+1]
done






