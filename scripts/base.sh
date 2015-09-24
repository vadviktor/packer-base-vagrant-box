apt-get update
apt-get -y upgrade
apt-get -y install linux-headers-$(uname -r) \
                   build-essential \
                   acl \
                   curl \
                   wget

sed -i -e 's/noatime,/noatime,acl,/g' /etc/fstab

echo %vagrant ALL=NOPASSWD:ALL > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant
usermod -a -G sudo vagrant

echo "UseDNS no" >> /etc/ssh/sshd_config

echo "fs.inotify.max_user_watches = 524288" >> /etc/sysctl.conf
echo "vm.swappiness = 1" >> /etc/sysctl.conf
