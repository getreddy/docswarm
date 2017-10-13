#!/bin/sh
#
# add's docker official ppa package source for Docker engine and install it
# does not include docker-compose or docker-machine
# run as root
#

# ensure we have tools to install
apt-get -y install \
	  apt-transport-https \
	    ca-certificates \
	      curl

# add official package repo key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# add official package repo
# change stable on the last line to edge for beta-like monthly releases
# stable releases are quarterly
add-apt-repository \
	       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	              $(lsb_release -cs) \
		       stable"


apt-get update -q

# install docker community (free) edition
apt-get -y install docker-ce

# start docker service
systemctl restart docker.service		     



#install docker-compose 
curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

