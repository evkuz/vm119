#!/bin/bash
SETUPLOG="/var/log/node_setup.log"

{ pvcreate /dev/vdc ;
vgcreate wn /dev/vdc ;
lvcreate -n cvmfs -L50G wn ;
lvcreate -n condor -L300G wn ;
mkfs.ext4 -L cvmfs /dev/wn/cvmfs ;
mkfs.ext4 -L condor /dev/wn/condor ;
mount /dev/wn/cvmfs /mnt/cvmfs ;
mount /dev/wn/condor /mnt/condor ;
} >> $SETUPLOG
sleep 5
#cp -rp /home/condor/* /mnt/condor

{ echo "/dev/mapper/wn-cvmfs    /mnt/cvmfs              ext4    defaults              0 0" >> /etc/fstab ;
echo "/dev/mapper/wn-condor   /mnt/condor             ext4    defaults              0 0" >> /etc/fstab ;
chown -R cvmfs:cvmfs /mnt/cvmfs ;
chown condor:condor /mnt/condor ;
} >> $SETUPLOG
#ls /cvmfs/nova.opensciencegrid.org
