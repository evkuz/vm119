#!/bin/bash

# Надо запускать на worknode condor_status capable
condor_status | cut -d ' ' -f1 | sed -n 's/^slot[0-9]@//p' | awk '!seen[$0]++' | sed -e '/.*execute.*/d' > /root/ek_slot_list
