#!/bin/bash
# Set FQDN for all machines and fill up with them /etc/hosts file

#delete wrong strings	
#sed -i '/^10\.93.*/d' /etc/hosts

IP=$(echo `/sbin/ip a` | sed -n -e 's/^.*inet //p' | cut -d' ' -f1 | cut -d '/' -f1)
SUBN=$(echo $IP | cut -d'.' -f3)
NUM=$(echo $IP | cut -d'.' -f4 | cut -d'/' -f1)
FQDN="wn_"${SUBN}"_"${NUM}".jinr.ru"
SHORT="wn_"${SUBN}"_"${NUM}

CONDOR="condor.jinr.ru"
CONDOR_CE="cloud-osg-ce.jinr.ru"

#SUBNET="221"

# for IP in $(seq 1 254); do # IMPORTANT! Iteration through possible IP ???.???.???.xxx
#     echo 10.93.${SUBNET}.${IP} wn_${SUBNET}_${IP}.jinr.ru >> /etc/hosts
#  done

cp /dev/null /etc/hosts

printf "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4\n" >> /etc/hosts
printf "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6\n" >> /etc/hosts
printf "159.93.221.22 $CONDOR\n" >> /etc/hosts
printf "159.93.221.21 $CONDOR_CE\n" >> /etc/hosts
printf "10.93.221.8 puppet-osg.jinr.ru\n" >> /etc/hosts
printf "$IP ${FQDN} localhost\n" >> /etc/hosts
printf "\n" >> /etc/hosts
SUBNET="221"

  for IP in $(seq 1 254); do # IMPORTANT! Iteration through possible IP ???.???.???.xxx
     echo 10.93.${SUBNET}.${IP} wn_${SUBNET}_${IP}.jinr.ru >> /etc/hosts
  done

