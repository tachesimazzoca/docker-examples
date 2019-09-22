#!/bin/sh

set -e

# install base packages
apt-get update && apt-get install -y --no-install-recommends \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

# add vagrant user
id_vagrant=$(id -u vagrant || true)
if [ -z "$id_vagrant" ];
then
  adduser --disabled-password --gecos "" vagrant
  bash -c 'echo "vagrant ALL=(ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)'
fi

# update vagrant/.ssh/authorized_keys
mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
curl -L -o /home/vagrant/.ssh/authorized_keys \
  "https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub"
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

# install docker-ce
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
#apt-key fingerprint 0EBFCD88
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable"
apt-get update && apt-get install -y --no-install-recommends docker-ce 
adduser --disabled-password --gecos "" --ingroup docker docker

# install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.23.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod 755 /usr/local/bin/docker-compose
