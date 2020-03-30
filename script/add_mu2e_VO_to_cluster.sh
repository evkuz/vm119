#!/bin/bash
# script 'add_mu2e_VO_to_cluster.sh'

cvmfs_file="/etc/cvmfs/default.local"

NOVA_REPO="nova.opensciencegrid.org"

MU2E_REPO="mu2e.opensciencegrid.org"

echo "Host $HOSTNAME start"

# add repo to current list
sed -i "s/^\(CVMFS_REPOSITORIES=\).*/\1$NOVA_REPO, $MU2E_REPO/" $cvmfs_file
cvmfs_config probe $NOVA_REPO
cvmfs_config probe $MU2E_REPO
ls /cvmfs/$MU2E_REPO
ls /cvmfs/$NOVA_REPO

echo "Host $HOSTNAME finish"
echo " "

