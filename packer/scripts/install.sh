#!/bin/bash

apt-get -y update

# Install necessary libraries for guest additions and Vagrant NFS Share
apt-get -y -q install linux-headers-$(uname -r) build-essential dkms nfs-common

# install guest additions
mount -o loop VBoxGuestAdditions.iso /media/cdrom
sh /media/cdrom/VBoxLinuxAdditions.run
umount /media/cdrom

# Installing vagrant keys
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# Setup sudo to allow no-password sudo for "vagrant"
groupadd -r vagrant
usermod -a -G vagrant vagrant
cp /etc/sudoers /etc/sudoers.orig
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=vagrant' /etc/sudoers
sed -i -e 's/%vagrant ALL=(ALL) ALL/%vagrant ALL=NOPASSWD:ALL/g' /etc/sudoers

# install everything for puppet3+hiera+librarian
apt-get install -y puppet

# if a fat packer box should be created than install anything you need here ...
apt-get install -y php5-cli
