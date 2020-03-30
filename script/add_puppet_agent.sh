#!/bin/bash
# Get agent' ip  as parameter

SCRIPT_NAME="install_puppet_agent.sh"
IP=$1
SUBN=$(echo $IP | cut -d'.' -f3)
NUM=$(echo $IP | cut -d'.' -f4 | cut -d'/' -f1)
FQDN="wn_"$SUBN"_"$NUM.jinr.ru

puppet cert clean $FQDN

ssh root@$IP 'bash -s' <  $SCRIPT_NAME
