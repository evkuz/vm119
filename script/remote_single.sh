#!/bin/bash
# Выполняем скрипт /root/ck_empty_output.sh, лежащий на удаленном хосте, т.е. путь /root/ck_empty_output.sh - это на удаленном хосте

#SCRIPT_NAME=$(ssh root@10.93.221.198 /root/ck_empty_output.sh)
SCRIPT_NAME="/root/script/ck_empty_output.sh"
ip_wn="10.93.221.198"
#echo $?
#echo "$SCRIPT_NAME"
#
# При таком варианте вывод весь считывается нормально.
# Неудобство в том, что если нужно подобный скрипт выполнить последовательно на многих хостах, то надо его сначала туда положить...
# можно бы и черезе puppet, но у нас не все узлы кластера обрабатываются puppet-сервером.

# Можно бы и через condor, но у нас не все узлы кластера имеют startd-роль, т.е. не все узлы - execute

 ssh -o StrictHostKeyChecking=no root@$ip_wn 'bash -s' < $SCRIPT_NAME >> /root/ebury_check.txt

