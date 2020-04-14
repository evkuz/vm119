#!/bin/bash
# get file with random values  and write to file
#shuf -i 2000-65000 -n 1

result="rnd.lst"

bot=67
top=185

shuf -i $bot-$top -n 100 >> $result
