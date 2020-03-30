#!/bin/bash

# Скрипт будет сравнивать вывод condor_status с эталонным списком ВМ
# и выдавать пропавший slot

condor_status | cut -d ' ' -f1 | sed -n 's/^slot[0-9]@//p' | awk '!seen[$0]++' | sed -e '/.*execute.*/d'

