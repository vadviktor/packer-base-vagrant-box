# enable memory and swap cgroup
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g' /etc/default/grub
/usr/sbin/update-grub

# enable Google DNS servers and lock in the default bridge ip
sed -i 's*#DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4"*DOCKER_OPTS="--bip=172.17.42.1/16 --dns 8.8.8.8 --dns 8.8.4.4"*g' /etc/default/docker

# add docker group and add vagrant to it
sudo groupadd docker
sudo usermod -a -G docker vagrant

# install mandatory packages
apt-get update
apt-get install -y apparmor cgroup-lite

curl -sSL https://get.docker.com/ | sh
