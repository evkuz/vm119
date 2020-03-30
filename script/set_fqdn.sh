#!/bin/bash

#hostname формируем на основе ip-адреса и прописываем в 
#/etc/hosts
#/etc/sysconfig/network
#/etc/sysctl.conf

IP=$(echo `/sbin/ip a` | sed -n -e 's/^.*inet //p' | cut -d' ' -f1 | cut -d '/' -f1)
SUBN=$(echo $IP | cut -d'.' -f3)
NUM=$(echo $IP | cut -d'.' -f4 | cut -d'/' -f1)
FQDN="wn_"${SUBN}"_"${NUM}".jinr.ru"
SHORT="wn_"${SUBN}"_"${NUM}
/bin/hostname ${FQDN}
echo "My name is ${FQDN}"

################### MASTER COMMANDS ###########
# puppet cert clean $FQDN



# set hostname of the agent
sed -i "s/^HOSTNAME=.*/HOSTNAME=${SHORT}/" /etc/sysconfig/network

sed -i "s/^kernel.hostname.*/kernel.hostname = ${FQDN}/" /etc/sysctl.conf




cp /dev/null /etc/hosts

printf "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4\n" >> /etc/hosts
printf "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6\n" >> /etc/hosts
printf "10.93.221.8 puppet-osg.jinr.ru\n" >> /etc/hosts
printf "$IP ${FQDN} localhost\n" >> /etc/hosts

/etc/init.d/network restart

# And push puppet agent to get certificate an retrieve catalogue

FILE="/etc/puppetlabs/puppet/ssl/certs/${FQDN}.pem"

if [ ! -f $FILE ]
then
    echo "Сертификат для ${FQDN} не существует, создаем новый"
puppet agent -t --waitforcert 5

else 
puppet agent -t

fi


