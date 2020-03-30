#!/bin/bash

# 09.06.2017
#Скрипт ищет и удаляет сертификаты для работы с puppet server на самом puppet-master и на рабочих узлах - агентах puppet

# ДОбавлено 23.08.2018

# Массив узлов из Партии №1
# Part_1 = (169, 170, 171, 172, 173, 174, 175, 177, 179, 181, 182, 185, 186, 187)

# А это массив узлов из Партии №2
# Part_2 =(4 6 14 24 26 27 28 34 78 84 85 86 87 113 114 119) 

SCRIPT_NAME="puppet_agent_clean_certs.sh"

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

#wn_count=1
ipadr_wn="10.93.221."


############# server part
#On the master:

for index in ${!iparray[*]}
do
FQDN="wn_221_${iparray[$index]}.jinr.ru"
ssh root@$PUPPET_MASTER "puppet cert clean $FQDN"
if [ $? -eq 0] then
        echo "$(date +"%d-%m-%Y %T") Successfully cleaned agent' cert for $FQDN"
   else
       echo "FAILED !!! to clean agent' cert for $FQDN "

fi
echo "Master side FQDN=$FQDN"

sleep 1
done

sleep 5
########### agent part
# on every agent from array
for index in ${!iparray[*]}
do
FQDN="wn_221_${iparray[$index]}.jinr.ru"
ip_wn=$ipadr_wn${iparray[index]}
# String is too long, so moving to a separate script
#ssh -o StrictHostKeyChecking=no root@$ip_wn "service puppet stop && find /etc/puppetlabs/puppet/ssl -name $FQDN.pem -delete && service puppet start && puppet agent -t --waitforcert 5 && exit"
# To exclude question "Are you sure you want to continue connecting (yes/no)? "
ssh -o StrictHostKeyChecking=no root@$ip_wn 'bash -s' < $SCRIPT_NAME

#--waitforcert 5 
# service puppet stop 
echo "Agent side FQDN= $FQDN"
#i=$[$i+1]
sleep 1

done

#service puppet stop
#find /etc/puppetlabs/puppet/ssl -name wn_221_2.jinr.ru.pem -delete
#service puppet start

#puppet agent -t --waitforcert 5
