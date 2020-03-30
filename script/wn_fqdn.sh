#!/bin/bash
IP=$(echo `/sbin/ip a` | sed -n -e 's/^.*brd //p' | cut -d' ' -f1)
SUBN=$(echo $IP | cut -d'.' -f3)
NUM=$(echo $IP | cut -d'.' -f4)
FQDN=vm`echo $SUBN`_`echo $NUM`.jinr.ru
HOSTNAME=wn_`echo $SUBN`_`echo $NUM` 
/bin/hostname `echo $FQDN` 
echo "$IP" "$FQDN" "$HOSTNAME" >> /etc/hosts
echo "HOSTNAME"=$HOSTNAME >> /etc/sysconfig/network
#Note: add the script for autostart: 
#/etc$ cat
#rc.local sh /tmp/set_hostname.sh
#rm -f /tmp/set_hostname.sh

echo "/root/./wn_fqdn.sh" >> /etc/rc.local

