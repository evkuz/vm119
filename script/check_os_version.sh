#!/bin/bash

WHICH_RELEASE=$(cat /etc/redhat-release  | cut -d ' ' -f4 | cut -d '.' -f1)

if [ $WHICH_RELEASE -eq 7 -o  $WHICH_RELEASE -eq 6 ]
then
  echo "$HOSTNAME is under Centos $WHICH_RELEASE"
else
  echo "$HOSTNAME is under  Unknown REDHAT version !!!"
fi

