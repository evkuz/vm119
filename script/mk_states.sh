#!/bin/bash

\cp  -p /root/states.csv /root/states.bdf

sed -i 's/;/ = /' /root/states.bdf

sed -i 's/\n/,/' /root/states.bdf
