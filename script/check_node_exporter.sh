#!/bin/bash

comm="node_exporter 2>node_errors.log 1>node.log &"
name="node_exporter"
pgrep $name

if [ ! $? -eq 0 ]
then
cd /home/wntester/node_exporter
bash -c "$comm"
#else
#  echo "running !"
fi

