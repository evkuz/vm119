#!/bin/bash

# Скрипт выполняет очистку puppet ssl сертификатов на АГЕНТЕ.
# Обычно этот скрипт запускается в цикле, внутри скрипта  "puppet_6_clean_WNs_certificate.sh"

#FQDN=$1

SETUPLOG="/var/log/node_setup.log"

########### agent part
#service_array=(puppet)

#service ${service_array[$index]} stop

# stop puppet service
puppet resource service puppet ensure=stopped >&2 >&1 >> $SETUPLOG
if [ $? -eq 0 ]
then
  echo "$(date +"%d-%m-%Y %T") Successfully stopped puppet on $HOSTNAME" >> $SETUPLOG
else
  echo "$(date +"%d-%m-%Y %T") Could not stopped puppet on $HOSTNAME" >&2
  echo "$(date +"%d-%m-%Y %T") Could not stopped puppet on $HOSTNAME" >> $SETUPLOG
  service puppet stop
fi

# clean ssl folder of agent
rm -rf $(puppet config print ssldir --section agent)
if [ $? -eq 0 ]
then
  echo "$(date +"%d-%m-%Y %T") Successfully cleaned puppet certs for $HOSTNAME in /etc/puppetlabs/puppet/ssl" >> $SETUPLOG
else
  echo "$(date +"%d-%m-%Y %T") Could not find certs for $HOSTNAME" >&2
  echo "$(date +"%d-%m-%Y %T") Could not find certs for $HOSTNAME in /etc/puppetlabs/puppet/ssl" >> $SETUPLOG
fi

# clean one more ssl folder of agent
rm -rf /opt/puppetlabs/puppet/ssl/
if [ $? -eq 0 ]
then
  echo "$(date +"%d-%m-%Y %T") Successfully cleaned puppet certs for $HOSTNAME in /opt/puppetlabs/puppet/ssl/" >> $SETUPLOG
else
  echo "$(date +"%d-%m-%Y %T") Could not find certs folder in /opt/puppetlabs/puppet/ssl/" >&2
  echo "$(date +"%d-%m-%Y %T") Could not find certs folder in /opt/puppetlabs/puppet/ssl/" >> $SETUPLOG
fi


# start puppet service
puppet resource service puppet ensure=running >&2 >1 >> $SETUPLOG
if [ $? -eq 0 ]
then
  echo "$(date +"%d-%m-%Y %T") Successfully started puppet service for $HOSTNAME" >> $SETUPLOG
else
  echo "$(date +"%d-%m-%Y %T") Could not start puppet service for this host $HOSTNAME" >&2
  echo "$(date +"%d-%m-%Y %T") Could not start puppet service for this host $HOSTNAME" >> $SETUPLOG
  service puppet start
fi


#sleep 5
#puppet agent -t
# find /etc/puppetlabs/puppet/ssl -name $HOSTNAME.pem -delete


# find /opt/puppetlabs/puppet/ssl/ -name $HOSTNAME.pem -delete


#service puppet start --runinterval=300
#puppet agent -t --waitforcert 5


