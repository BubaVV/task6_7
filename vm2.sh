#!/bin/bash
IS_APACHE_INSTALLED=$(dpkg -l apache2 | grep ii |wc -l)
if [ $IS_APACHE_INSTALLED = 0 ]
then
echo "Updating apt"
apt update
echo "Installing apache2"
apt install apache2 -y -q
fi
