#!/bin/bash
OUTERLOG="/root/script/outer.log"

date

echo "inner script output"
echo "$(whoami) inner script output" >> $OUTERLOG
