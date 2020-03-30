#!/bin/bash


journal_number_start=1
journal_number_stop=5

# wget https://xakep.ru/download/?pdf=xa-004

i=$journal_number_start 
while [ $i -lt $journal_number_stop ]
do
 wget https://xakep.ru/download/?pdf=xa-00$i

i=$[$i+1] 
done
echo "DONE"
