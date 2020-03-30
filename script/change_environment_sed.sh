#!/bin/bash

echo "This is change_environment_sed.sh"
echo " "

PUPPET_FILE="/etc/puppetlabs/puppet/puppet.conf"

#PUPPET_FILE="/root/puppet.conf"
sed -i 's/^#environment = production$/environment = production/' $PUPPET_FILE
sed -i 's/^environment = develop$/#environment = develop/' $PUPPET_FILE
