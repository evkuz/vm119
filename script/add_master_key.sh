#!/bin/bash

IP=$1
MASTER_KEY_FILE="/root/script/puppet_master_key"
scp -p $IP:/root/.ssh/authorized_keys /root/script/puppet-master/

cat $MASTER_KEY_FILE >> /root/script/puppet-master/authorized_keys

scp -p /root/script/puppet-master/authorized_keys  $IP:/root/.ssh/authorized_keys

