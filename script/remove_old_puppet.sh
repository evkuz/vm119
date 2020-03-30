#!/bin/bash
#Скрипт удаляет на WN следы "предыдущего" puppetdb для SL-6.9
#Подготавливает РУ к получению нового сертификата с нового puppet-foreman сервера

PUPPET_FILE_NAME="/etc/puppetlabs/puppet/puppet.conf"

service puppet stop
yum erase -y puppetdb-termini.noarch
rm -f /etc/puppetlabs/puppet/puppetdb.conf

cp /dev/null $PUPPET_FILE_NAME
#//+++++++++++++++++++ puppet.conf
cat >> $PUPPET_FILE_NAME << EOF
[main]
server = puppet-osg.jinr.ru

environment = develop
#environment = production
EOF

rm -rf  /etc/puppetlabs/puppet/ssl

service puppet start
sleep 5
puppet agent -t --waitforcert 5
