#!/bin/bash
# Скрипт проверяет вывод в лог внутреннего скрипта и свой собственный.
# Оба скрипта могут сохранять свой вывод в одном и том же файле.

OUTERLOG="/root/script/outer.log"
touch  $OUTERLOG
cp /dev/null $OUTERLOG
echo "outer script start"
echo "$(date) outer script start" >> $OUTERLOG

/root/script/inner.sh

echo "outer script finish"
