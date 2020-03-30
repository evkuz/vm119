#!/bin/bash
# this script goes to edit_wn.sh as $SCRIPT_NAME

IP_LIST=vms_for_edit.lst

# enable repo

rpm -Uvh https://yum.puppet.com/puppet6-release-el-6.noarch.rpm
# switch of old repo
sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/puppetlabs-pc1.repo
yum clean all
yum update
#check puppet version

VER=$(puppet --version)
if [$VER eq "4.10.12"] then
   echo "$HOSTNAME failed to upgrade puppet version"

else 
     puppet agent -t >&2>1
fi
# if  eq 4.10.12 than it's error , so echo message about this node
# if 6 and more than 


