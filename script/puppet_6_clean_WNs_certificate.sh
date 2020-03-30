#!/bin/bash

# 09.06.2017
#Скрипт ищет и удаляет сертификаты для работы с puppet server на самом puppet-master и на рабочих узлах - агентах puppet


SCRIPT_NAME="puppet_6_agent_clean_certs.sh"

# Файл получаем из скрипта *.rb
ARR_FILE=./nodes_for_edit.lst

iparray=($(cat $ARR_FILE))
#oldschool just for memory
#iparray=(13 27 28 75 78)

#IP=$(echo `/sbin/ip a` | sed -n -e 's/^.*inet //p' | cut -d' ' -f1 | cut -d '/' -f1)
#SUBN=$(echo $IP | cut -d'.' -f3)
#NUM=$(echo $IP | cut -d'.' -f4 | cut -d'/' -f1)
#FQDN="wn_"$SUBN"_"$NUM".jinr.ru"


PUPPET_MASTER="puppet-osg.jinr.ru"

############# server part
#On the master:
echo "First master side"
for index in ${!iparray[*]}
do

FQDN=$(echo ${iparray[$index]} | sed -e 's/\./-/g').jinr.ru
ssh root@$PUPPET_MASTER "puppetserver ca clean --certname $FQDN"
echo "Master side FQDN=\"$FQDN\""

sleep 1
done

sleep 2
########### agent part
# on every agent from array
echo "Next agent' side"
for index in ${!iparray[*]}
do
ip_wn=${iparray[$index]}
ssh -o StrictHostKeyChecking=no root@$ip_wn 'bash -s' < $SCRIPT_NAME

#--waitforcert 5 
# service puppet stop 
echo "Agent side ip=$ip_wn"
#i=$[$i+1]
sleep 1

done

#service puppet stop
#find /etc/puppetlabs/puppet/ssl -name wn_221_2.jinr.ru.pem -delete
#service puppet start

#puppet agent -t --waitforcert 5
