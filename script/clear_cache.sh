#!/bin/bash
#Скрипт очистки кэша environment см тут https://docs.puppet.com/puppetserver/latest/admin-api/v1/environment-cache.html
#Запускать скрипт надо на мастер сервере puppet-osg.jinr.ru
PATH_TO_CERT="/etc/puppetlabs/puppet/ssl/certs/puppet-osg.jinr.ru.pem"
PATH_TO_KEY="/etc/puppetlabs/puppet/ssl/private_keys/puppet-osg.jinr.ru.pem"
PATH_TO_PUPPET_CA_CERT="/etc/puppetlabs/puppet/ssl/ca/ca_crt.pem"
curl -i --cert $PATH_TO_CERT --key $PATH_TO_KEY --cacert $PATH_TO_PUPPET_CA_CERT -X DELETE https://puppet-osg.jinr.ru:8140/puppet-admin-api/v1/environment-cache?environment=develop

