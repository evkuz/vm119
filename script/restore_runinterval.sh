#!/bin/bash

PUPPET_CONF="/etc/puppetlabs/puppet/puppet.conf"
del_string="runinterval=300"

sed -i '/^runinterval=300/d' $PUPPET_CONF

