#!/bin/bash

SERVER_NAME="puppet-osg.jinr.ru"
SERVER_IP="10.93.221.8"

IP=$(echo `/sbin/ip a` | sed -n -e 's/^.*inet //p' | cut -d' ' -f1 | cut -d '/' -f1)
SUBN=$(echo $IP | cut -d'.' -f3)
NUM=$(echo $IP | cut -d'.' -f4 | cut -d'/' -f1)
FQDN="wn_"$SUBN"_"$NUM.jinr.ru



#Очищаем файл /etc/hosts
\cp /dev/null /etc/hosts

#echo "$SERVER_IP $SERVER_NAME" >> /etc/hosts
#echo "$IP $FQDN localhost" >> /etc/hosts
cat >> /etc/hosts << EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
$SERVER_IP $SERVER_NAME
$IP $FQDN localhost
EOF

