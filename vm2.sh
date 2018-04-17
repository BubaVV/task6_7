#!/bin/bash
IS_APACHE_INSTALLED=$(dpkg -l apache2 | grep ii |wc -l)
if [ $IS_APACHE_INSTALLED = 0 ]
then
echo "Updating apt"
apt update
echo "Installing apache2"
apt install apache2 -y -q
fi

cp -f /etc/apache2/sites-enabled/000-default.conf 000-default.conf

source vm2.config
export $(cut -d= -f1 vm2.config)
envsubst < 000-default.conf '$APACHE_VLAN_IP' > /etc/apache2/sites-enabled/000-default.conf

modprobe 8021q
vconfig add enp0s4 278
ip addr add 10.0.0.2/24 dev enp0s4:278
ip link set up enp0s:278


