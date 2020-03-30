#!/bin/bash

/etc/puppetlabs/puppet/ssl -name "$HOSTNAME.pem" -delete
sleep 3
puppet agent -t
