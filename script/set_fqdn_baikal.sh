#!/bin/bash

# 10.10.2018
# ДОбавил входные параметры
# FUNCTIONAL - индикатор функционального назначения узла - submit, execute, ce, batch и т.д.
# NODE_INDEX - числовой индекс узла с вышеуказанным функционалом - 01, 02, и т.д.
#  Значения этих параметров добавляются к FQDN хоста
#08.08.2018 02


#hostname формируем на основе ip-адреса и прописываем в 
#/etc/hosts
#/etc/sysconfig/network
#/etc/sysctl.conf

#FUNCTIONAL determines whether it submit or execute node
FUNCTIONAL="$1"
NODE_INDEX="$2"


IP=$(echo `/sbin/ip a` | sed -n -e 's/^.*inet //p' | cut -d ' ' -f1 | cut -d '/' -f1)
SUBN=$(echo $IP | cut -d'.' -f3)
NUM=$(echo $IP | cut -d'.' -f4 | cut -d'/' -f1)
FQDN="bkl-${FUNCTIONAL}"_"${NODE_INDEX}".jinr.ru
SHORT="bkl-${FUNCTIONAL}"_"${NODE_INDEX}"
/bin/hostname ${FQDN}

echo "the functional valuse is $1"
echo "the 'functional' variable valuse is ${FUNCTIONAL}"
echo "My name is ${FQDN}"
echo "IP vaile is ${IP}"

################### MASTER COMMANDS ###########
# puppet cert clean $FQDN



# set hostname of the agent
sed -i "s/^HOSTNAME=.*/HOSTNAME=${SHORT}/" /etc/sysconfig/network

sed -i "s/^kernel.hostname.*/kernel.hostname = ${FQDN}/g" /etc/sysctl.conf
sed -i '/^kernel.hostname.*/q' /etc/sysctl.conf



cp /dev/null /etc/hosts

printf "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4\n" >> /etc/hosts
printf "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6\n" >> /etc/hosts
printf "10.93.221.8 puppet-osg.jinr.ru\n" >> /etc/hosts
printf "$IP ${FQDN} localhost\n" >> /etc/hosts

#/etc/init.d/network restart
service network restart

# And push puppet agent to get certificate an retrieve catalogue

#FILE="/etc/puppetlabs/puppet/ssl/certs/${FQDN}.pem"

#if [ ! -f $FILE ]
#then
#    echo "Сертификат для ${FQDN} не существует, создаем новый"
#puppet agent -t --waitforcert 5

#else
#puppet agent -t

#fi
