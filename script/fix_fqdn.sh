#!/bin/bash

# Почему-то через puppet не везде залился скрипт /root/set_fqdn_no_dns.sh, а при восстановлении узлов после обновления сетевух
# была в качестве образцовой взята ВМ без этого скрипта.
# Соответственно все вновь отлитые узлы имеют неправильное FQDN, т.к. скрипт не отработал.
# Решаем проблему с отсутствием на узлах скрипта /root/set_fqdn_no_dns.sh
# wn_221_243.jinr.ru



# А еще на узлах надо выполнить puppet agent -t
# т.к. имя хоста поменялось, но мастер-сервер не имеет у себя в списке такого имени, поэтому и не спрашивает.
# А может и не надо т.к. в продакшене у них runinterval 30 минут и, возможно, поэтому еще не везде есть нужный скрипт.
# А наличие скрипта

FILE=/root/set_fqdn_no_dns.sh
FILE_SOURCE=/root/script/set_fqdn_no_dns.sh
IP_LIST=vms_for_edit.lst
SCRIPT_NAME=/root/script/make_vms_list_ip.sh
WRONG_FQDN=/root/script/wrong_fqdn.lst
cp /dev/null $WRONG_FQDN
#/nfs/condor/make_vms_list_ip.sh
# Идем на condor.jinr.ru, получаем список ip ВСЕХ рабочих узлов в файле и копируем сюда в файл $IP_LIST

# Так в файл /root/script/vms_output.txt ничего не пишется
#ssh -o StrictHostKeyChecking=no root@condor.jinr.ru 'bash -s' < $SCRIPT_NAME >> /root/script/vms_output.txt

START_TIME="$(date)"
# Получаем файл $IP_LIST
#ssh -o StrictHostKeyChecking=no root@condor.jinr.ru 'bash -s' < $SCRIPT_NAME


# Файл-список ip-адресов получили, теперь проходим по этому списку и проверяем наличие файла /root/set_fqdn_no_dns.sh

iparray=($(cat $IP_LIST))

COMMAND_NAME="rsync -a $FILE ${iparray[$index]}:/root"
PUSH_PUPPET="puppet agent -t"
#COMMAND_NAME="if [ ! -f ${$FILE} ]; then\
# echo ${$HOSTNAME} ${$FILE} does not exist >> $WRONG_FQDN fi"

for index in ${!iparray[*]}
do
 if ! ssh -o StrictHostKeyChecking=no root@${iparray[$index]} stat $FILE \>/dev/null 2\>\&1
      then # $FILE does not exist
           echo "${iparray[$index]}" >> $WRONG_FQDN
   # Если файла нет, то делаем rsync
#   ssh -o StrictHostKeyChecking=no root@${iparray[$index]} $COMMAND_NAME
    rsync -a $FILE_SOURCE ${iparray[$index]}:/root
    ssh -o StrictHostKeyChecking=no root@$ip_wn 'bash -s' < $FILE_SOURCE
   ssh -o StrictHostKeyChecking=no root@${iparray[$index]} $PUSH_PUPPET
 fi

sleep 1
done

echo "Script started ad $START_TIME"
echo "Script  finished at $(date)"
