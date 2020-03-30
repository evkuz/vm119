#!/bin/bash

# Тот случай, когда все узлы уже имеют свой FQDN, а puppet старой (4.10.12)версии.
# Меняем репозиторий, Ставим puppet последней версиию


PUPPET_CONF_DIR="/etc/puppetlabs/puppet/"

PUPPET_FILE_NAME="$PUPPET_CONF_DIR/puppet.conf"
PUPPETDB_FILE_NAME="$PUPPET_CONF_DIR/puppetdb.conf"
SERVER_NAME="puppet-osg.jinr.ru"
SERVER_IP="10.93.221.8"

REPO_PATH="https://yum.puppet.com/puppet6-release-el-6.noarch.rpm"

IP=$(echo `/sbin/ip a` | sed -n -e 's/^.*inet //p' | cut -d' ' -f1 | cut -d '/' -f1)
FQDN=$(hostname)

# Enable the Puppet platform repository
cd /etc/yum.repos.d
# But first disable the previous
sed -i 's/enabled=1/enabled=0/' puppetlabs-pc1.repo
rpm -Uvh $REPO_PATH
yum -y install puppet-agent
chkconfig puppet on
#Очищаем файл /etc/hosts
\cp /dev/null /etc/hosts
# Заполняем файл /etc/hosts
cat >> /etc/hosts << EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
$SERVER_IP $SERVER_NAME
$IP $FQDN localhost
EOF


# stop puppet service
puppet resource service puppet ensure=stopped
# clean ssl folder of agent
rm -rf $(puppet config print ssldir --section agent)
mkdir /etc/puppetlabs/code/environments/develop
echo "runinterval = 180" >> $PUPPET_FILE_NAME
#mkdir /etc/puppetlabs/code/environments/productionpuppet resource service puppet ensure
# start puppet service
puppet resource service puppet ensure=running
sleep 5
puppet agent -t



