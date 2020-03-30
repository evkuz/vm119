#!/bin/bash

# Скрипт будет проверять вывод /var/log/messages на предмет соответствия hostname в этом файле и в реале.

CMD_MESSAGES="tail --lines=1 /var/log/messages |  cut -d ' ' -f4"

CMD_SHORT_HOSTNAME="hostname -s"

if [ "$CMD_MESSAGES" == "$CMD_SHORT_HOSTNAME"]; then

# Надо сравнить вывод этих команд

