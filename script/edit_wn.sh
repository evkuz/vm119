#!/bin/bash

# 12.10.2018 уже 70 узлов
# 05.12.2017 уже 50 узлов
# 10.10.2019  94 узла

#Выполнение скрипта на всех wn
#

NODES_LIST="nodes_for_edit.lst"
RESULT="/root/script/output.txt"


REMOTE_SCRIPT="/root/init_lvm_el7.sh"

#SCRIPT_NAME="/root/script/change_route.sh"
#SCRIPT_NAME="install_puppet_agent.sh"
#SCRIPT_NAME="remove_old_puppet.sh"
#SCRIPT_NAME="/root/script/push_puppet.sh"
#SCRIPT_NAME="/root/script/downgrade_xrootd.sh"
#SCRIPT_NAME="/root/script/change_runinterval.sh"
#SCRIPT_NAME="/root/script/restore_runinterval.sh"
#SCRIPT_NAME="add_mu2e_VO_to_cluster.sh"
#SCRIPT_NAME="/root/script/ce_script/reconfig_condor.sh"

#SCRIPT_NAME="update_osg_33_to_34.sh"
#SCRIPT_NAME="/root/script/change_environment_sed.sh"
#SCRIPT_NAME="/root/script/start_service_not_running.sh"
#SCRIPT_NAME="/root/script/ck_empty_output.sh" renamed to "ck_ebury_malware.sh"
#SCRIPT_NAME="ck_ebury_malware.sh"
#SCRIPT_NAME="/root/script/check_file_type.sh"
#SCRIPT_NAME="/root/script/off_libvirt.sh"
#SCRIPT_NAME="/root/script/install_6_puppet_agent.sh"
#SCRIPT_NAME="test_tcp_to_master.sh"

#SCRIPT_NAME="check_os_version.sh"
#SCRIPT_NAME="check_md5.bash"

#COMMAND_NAME="yum -y install libgomp"
#COMMAND_NAME="date"
#COMMAND_NAME="puppet cert clean"

#COMMAND_NAME="service rsyslog restart" # Нужно, чтобы узлы не слетали с синхронизации puppet
#COMMAND_NAME="puppet agent -t" # Для восстановления синхронизации
#COMMAND_NAME="condor_reconfig"
#COMMAND_NAME="/root/./set_fqdn.sh && sleep 1 && service condor restart"
#COMMAND_NAME="/root/./set_fqdn_no_dns.sh"
# "init 6" Нужно, когда ВМ не синхронизирована с мастером, и обращается к нему с "чужим" hostname
#COMMAND_NAME="init 6" # Совсем перегружать необязательно, достаточно перезапустить rsyslog !!!

# restore runinterval to default value
#COMMAND_NAME="sed -i '/^runinterval.*/d' /etc/puppetlabs/puppet/puppet.conf" # Восстанавливаем runinterval до значения по умолчанию
 
#COMMAND_NAME="condor_drain -graceful $HOSTNAME"

COMMAND_NAME="systemctl restart condor"
#iparray=(  4   6  14  24  26  27  28  34  84  85
#          86  87 113 127 129 130 157 158 160 161
#         162 163 165 167 168 169 170 171 172 173
#         174 175 176 177 178 179 180 181 182 183
#         184 185 186 187 188 189 190 191 192 193)

touch $RESULT
cp /dev/null $RESULT
# Файл получаем из скрипта find
ARR_FILE=$NODES_LIST
#./nodes_for_edit.lst

iparray=($(cat $ARR_FILE))

#echo "Array items and indexes:" # Выводим записи массива с их индексами
#sleep 2
START_TIME="$(date)"
echo "Script started ad $START_TIME"

for index in ${!iparray[*]}
do
#    printf "%4d: %s\n" $index ${iparray[$index]}
#echo "Host ${iparray[$index]}.jinr.ru start at"
#date
#    ip_wn=$ipadr_wn${iparray[$index]}
     ip_wn=${iparray[$index]}
# perform remote script
#ssh -o StrictHostKeyChecking=no root@$ip_wn $REMOTE_SCRIPT >> $RESULT
#     ssh -o StrictHostKeyChecking=no root@$ip_wn '/root/init_lvm_el7.sh'  >> $RESULT
#    ssh -o StrictHostKeyChecking=no root@$ip_wn 'bash -s' < $SCRIPT_NAME  >> $RESULT
    ssh -o StrictHostKeyChecking=no root@$ip_wn $COMMAND_NAME >1 >>$RESULT
#    sleep 1
#    printf "  ip: %s\n" ${ip_wn}
done

#echo "Script started ad $START_TIME"
echo "Script finished at $(date)"
#sleep 10
#date


#  ${arr[*]} # Все записи в массиве
#  ${!arr[*]}# Все индексы в массиве
#  ${#arr[*]}# Количество записей в массиве
#  ${#arr[0]}# Длина первой записи (нумерация с нуля)

