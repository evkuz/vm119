#!/bin/bash

FILE=/root/set_fqdn_no_dns.sh
IP_LIST=wrong_fqdn.lst 
iparray=($(cat $IP_LIST))

for index in ${!iparray[*]}
do
  rsync -a $FILE ${iparray[$index]}:/root
 ssh -o StrictHostKeyChecking=no root@ 'bash -s' < $FILE
done

echo "Done !"
