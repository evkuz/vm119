#!/bin/bash

OLD_ADDR="10.93.221.8"
NEW_ADDR="10.220.16.5"

#sed -i 's/10.93.221.8/10.220.16.5/' /etc/hosts
sed -i "s/$OLD_ADDR/$NEW_ADDR/" /etc/hosts
