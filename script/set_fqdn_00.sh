#!/bin/bash
# Только установка имени хоста. Остальное потом.
IP=$(echo `/sbin/ip a` | sed -n -e 's/^.*inet //p' | cut -d' ' -f1 | cut -d '/' -f1)
SUBN=$(echo $IP | cut -d'.' -f3)
NUM=$(echo $IP | cut -d'.' -f4 | cut -d'/' -f1)
FQDN="wn_"${SUBN}"_"${NUM}".jinr.ru"
/bin/hostname ${FQDN}
echo "My name is ${FQDN}"

################### MASTER COMMANDS ###########
# puppet cert clean $FQDN



# set hostname of the agent
sed -i "s/^HOSTNAME=.*/HOSTNAME=${FQDN}/" /etc/sysconfig/network

sed -i "s/^kernel.hostname.*/kernel.hostname = ${FQDN}/" /etc/sysctl.conf


#printf "# Hostname\kernel.hostname = ${FQDN}\n" >> /etc/sysctl.conf
#/etc/init.d/network restart
service network restart

