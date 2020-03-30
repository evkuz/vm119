#!/bin/bash

#service="puppet"
service="condor"

if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
echo "$service is running!!!"
else
#/etc/init.d/$service start
echo "Host $HOSTNAME starting $service"
service $service start
fi
