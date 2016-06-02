#!/bin/bash

# enable memory and swap cgroup
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g' /etc/default/grub
/usr/sbin/update-grub

# install mandatory packages
apt-get update && \
apt-get install -y apt-transport-https \
                   ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' > /etc/apt/sources.list.d/docker.list
apt-get update && \
apt-get purge lxc-docker && \
apt-get install -y docker-engine \
                   apparmor

# enable Google DNS servers and lock in the default bridge ip
sed -i 's*#DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4"*DOCKER_OPTS="--bip=172.17.42.1/16 --dns 8.8.8.8 --dns 8.8.4.4 -H unix:///var/run/docker.sock -H tcp://0.0.0.0:4242"*g' /etc/default/docker

# add docker group and add vagrant to it
groupadd docker
usermod -a -G docker vagrant
