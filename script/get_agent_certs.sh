#!/bin/bash

# Скрипт нужно запускать на puppet-osg.jinr.ru, чтобы он копировал ключи на мастере
# Скрипт стягиват с агентов сертификат для работы с puppet master сервером.

CERT_SOURCE_DIR="/etc/puppetlabs/puppet/ssl/certs/" # НА АГЕНТЕ
CERT_DEST_DIR="/root/agent_certs"                   # НА МАСТЕРЕ
DEST_HOST="puppet-osg.jinr.ru"

# ЦИКЛ перебора всех fqdn агентов.

#rsync $FQDN:$CERT_SOURCE_DIR$FQDN.pem $DEST_HOST:$CERT_DEST_DIR


iparray=(4 6 14 24 26 27 28 34 78 84 85 86 87 113 114 119)
wn_count=16
ipadr_wn="10.93.221."
# on every agent from array
i=0
 while [ $i -lt $wn_count ]
do
FQDN="wn_221_${iparray[$i]}.jinr.ru"
ip_wn=$ipadr_wn${iparray[i]}
ssh root@$ip_wn "rsync $FQDN:$CERT_SOURCE_DIR$FQDN.pem $DEST_HOST:$CERT_DEST_DIR" 
#echo "FQDN= $FQDN"
i=$[$i+1]
done
