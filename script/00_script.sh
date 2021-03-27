#!/bin/bash
#
me=`basename "$0"`
echo "$(date +"%d-%m-%Y %T") Start running $me script" |& tee -a $SOMELOG

# place your code here ...

echo "$(date +"%d-%m-%Y %T") Finishing script $me" |& tee -a $SOMELOG
