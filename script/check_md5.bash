#!/bin/bash

# 031b2571662b5e61621f4e09a65655a9  /usr/share/nano/sh.nanorc
ANALIZED="/usr/share/nano/sh.nanorc"
RIGHT_MD5="031b2571662b5e61621f4e09a65655a9"

answer=$(md5sum $ANALIZED | cut -d ' ' -f 1)
#echo $answer
if [[ "$answer" == "$RIGHT_MD5" ]]
then
   echo "$HOSTNAME File is correct"
else
    echo "$HOSTNAME Files are not matched"
fi
