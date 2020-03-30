#!/bin/bash
# Set FQDN for all machines
for SUBNET in $(seq 221 223); do # IMPORTANT! Set of allowed subnets ???.???.xxx.???
  for IP in $(seq 1 254); do # IMPORTANT! Iteration through possible IP ???.???.???.xxx
    CN="vmon${SUBNET}x${IP}"
    echo 10.93.${SUBNET}.${IP} wn_${SUBNET}_${IP}.jinr.ru wn${SUBNET}_${IP} >> /etc/hosts
  done
done

