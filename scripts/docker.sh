#!/bin/bash

# enable memory and swap cgroup
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g' /etc/default/grub
/usr/sbin/update-grub

# install mandatory packages
aptitude update && \
aptitude install -y apt-transport-https \
                    ca-certificates \
                    curl \
                    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

aptitude update && \
aptitude install -y docker-ce

# add docker group and add vagrant to it
groupadd docker
usermod -a -G docker vagrant
