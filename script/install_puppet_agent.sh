#!/bin/bash
echo "Start Time:"
date

#PUPPET_CONF_DIR="/root/puppet/"
PUPPET_CONF_DIR="/etc/puppetlabs/puppet/"

PUPPET_FILE_NAME="$PUPPET_CONF_DIR/puppet.conf"
PUPPETDB_FILE_NAME="$PUPPET_CONF_DIR/puppetdb.conf"
SERVER_NAME="puppet-osg.jinr.ru"
SERVER_IP="10.93.221.8"

IP=$(echo `/sbin/ip a` | sed -n -e 's/^.*inet //p' | cut -d' ' -f1 | cut -d '/' -f1)
SUBN=$(echo $IP | cut -d'.' -f3)
NUM=$(echo $IP | cut -d'.' -f4 | cut -d'/' -f1)
FQDN="wn_"$SUBN"_"$NUM".jinr.ru"
/bin/hostname $FQDN

################### MASTER COMMANDS ###########
# puppet cert clean $FQDN



# set hostname of the agent
# "" Критично именно в 2-ных кавычках
sed -i "s/^HOSTNAME=.*/HOSTNAME=$FQDN/" /etc/sysconfig/network

printf "# Hostname\nkernel.hostname = $FQDN\n" >> /etc/sysctl.conf
/etc/init.d/network restart

rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
export "PATH=/opt/puppetlabs/bin:$PATH"
yum install -y puppet-agent
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
# Install plugins
yum install -y puppetdb-terminus

# need for rsync
#yum install -y openssh-clients

#//+++++++++++++++++++ puppet.conf
cat >> $PUPPET_FILE_NAME << EOF
[main]
server = $SERVER_NAME
  storeconfigs = true
  storeconfigs_backend = puppetdb
  # Optional settings to submit reports to PuppetDB:
  report = true
  reports = puppetdb

environment = production
EOF
#//+++++++++++++++++++ puppetdb.conf
cat >> $PUPPETDB_FILE_NAME << EOF
[main]
server_urls = https://$SERVER_NAME:8081
EOF
#//+++++++++++++++++  SSL 
#1. Clean old certificates of this host on server
#On the master:
# puppet cert clean $FQDN

#2. On the agent:

find /etc/puppetlabs/puppet/ssl -name $FQDN.pem -delete
service puppet start
sleep 3
puppet agent -t

#puppet agent --t

#//++++++++++++++++++++
#SIGN (AUTOSIGN) THE CERTIFICATE 

#puppet resource service puppet ensure=running enable=true
echo "Finish Time:"
date
