# enable memory and swap cgroup
perl -p -i -e 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g'  /etc/default/grub
/usr/sbin/update-grub

# add docker group and add vagrant to it
sudo groupadd docker
sudo usermod -a -G docker ubuntu
sudo usermod -a -G docker vagrant

# install curl
apt-get update
apt-get install -y curl apparmor cgroup-lite

curl -sSL https://get.docker.com/ubuntu/ | sh
