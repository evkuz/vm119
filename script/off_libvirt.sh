#!/bin/bash

brctl show
ip link set virbr0 down
brctl delbr virbr0


service libvirtd stop
chkconfig --list | grep libvirtd
chkconfig libvirtd off

