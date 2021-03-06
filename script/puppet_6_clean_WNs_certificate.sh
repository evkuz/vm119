#!/bin/bash

# 09.06.2017
#Скрипт ищет и удаляет сертификаты для работы с puppet server на самом puppet-master и на рабочих узлах - агентах puppet


SCRIPT_NAME="puppet_6_agent_clean_certs.sh"
SSL_LOG="cert_clean.log"
touch $SSL_LOG
cp /dev/null $SSL_LOG

# Файл получаем из скрипта *.rb
# ТУт нужен список ip, преобразование в fqdn делаем на лету.
ARR_FILE=./nodes_for_edit.lst

iparray=($(cat $ARR_FILE))

PUPPET_MASTER="puppet-osg.jinr.ru"

############# server part
#On the master:
echo "First master side"
for index in ${!iparray[*]}
do

FQDN=$(echo ${iparray[$index]} | sed -e 's/\./-/g').jinr.ru
#ssh root@$PUPPET_MASTER "puppetserver ca clean --certname $FQDN"
#rm -f  /etc/puppetlabs/puppet/ssl/ca/signed/wn_221_xxx.jinr.ru.pem

#ssh root@$PUPPET_MASTER "rm -f  /etc/puppetlabs/puppet/ssl/ca/signed/$FQDN.pem"
echo "Master side FQDN=\"$FQDN\""
echo "Master side certname=\"$FQDN.pem\""
ssh root@$PUPPET_MASTER "puppetserver ca clean --certname $FQDN"
sleep 1
done

sleep 2
########### agent part

# Выполняем проверку,что ip пингуется. Иначе весь скрипт дальше не выполняется.
# on every agent from array
echo "Next agent' side"
for index in ${!iparray[*]}
do
echo "Agent side ip=$ip_wn"
ip_wn=${iparray[$index]}

ping -c 2 $ip_wn
        if [ $? -eq 0 ]; then
          # Success
	  ssh -o StrictHostKeyChecking=no root@$ip_wn 'bash -s' < $SCRIPT_NAME
        else
          echo "$(date +"%d-%m-%Y %T") Could not ping $ip_wn" >&2
          echo "$(date +"%d-%m-%Y %T") Could not ping $ip_wn" >> $SSL_LOG
        fi


#ssh -o StrictHostKeyChecking=no root@$ip_wn 'bash -s' < $SCRIPT_NAME

sleep 1

done

