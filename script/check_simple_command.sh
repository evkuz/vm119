#!/bin/bash

COMMAND_NAME='hostname'
SCRIPT_NAME="install_6_puppet_agent.sh"
ip_wn=10.93.221.113
#get_answer=$(ssh -o StrictHostKeyChecking=no root@$ip_wn 'hostname')    # Так тоже работает
##get_answer=$(ssh -o StrictHostKeyChecking=no root@$ip_wn $COMMAND_NAME)
echo $get_answer

echo "Start at $(date)"
ssh -o StrictHostKeyChecking=no root@$ip_wn 'bash -s' < $SCRIPT_NAME
echo "Finish at $(date)"
