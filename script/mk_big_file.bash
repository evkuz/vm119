#!/bin/bash

file_name="/home/fermilab/test.data"
file_size=1000000000
echo "started at $(date)"

i=0
 while [ $i -lt $file_size ]
do
echo 'A' >> $file_name

i=$[$i+1]
done
#echo "DONE"
echo "finished at $(date)"
