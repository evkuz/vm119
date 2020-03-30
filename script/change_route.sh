#!/bin/bash

# Change default route
sed -i 's/^GATEWAY=.*/GATEWAY=10.93.220.1/' /etc/sysconfig/network-scripts/ifcfg-eth0
service network restart
