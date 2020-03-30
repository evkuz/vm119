#!/bin/bash
PUPPET_CONF_DIR="/root/puppet/"
#PUPPET_CONF_DIR="/etc/puppetlabs/puppet/"

PUPPET_FILE_NAME="$PUPPET_CONF_DIR/puppet.conf"
PUPPETDB_FILE_NAME="$PUPPET_CONF_DIR/puppetdb.conf"
#FILE_NAME="/root/puppet_agent.conf"
SERVER_NAME="puppet-osg.jinr.ru"

#//+++++++++++++++++++ puppet.conf
cat >> $PUPPET_FILE_NAME << EOF
[main]
server = $SERVER_NAME
  storeconfigs = true
  storeconfigs_backend = puppetdb
  # Optional settings to submit reports to PuppetDB:
  report = true
  reports = puppetdb

environment = develop
EOF
#//+++++++++++++++++++ puppetdb.conf
cat >> $PUPPETDB_FILE_NAME << EOF
[main]
server_urls = https://$SERVER_NAME:8081
EOF
