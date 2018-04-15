#!/bin/bash
IS_NGINX_INSTALLED=$(dpkg -l nginx | grep ii |wc -l)
if [ $IS_NGINX_INSTALLED = 0 ]
then
echo "Updating apt"
apt update
echo "Installing nginx"
apt install nginx -y -q
fi

mkdir -p /etc/ssl/certs

openssl genrsa -out /etc/ssl/certs/root-ca.key 4096
openssl req -x509 -new -nodes -key /etc/ssl/certs/root-ca.key -sha256 -days 365 -out /etc/ssl/certs/root-ca.crt -subj "/C=UA/ST=Kharkov/L=Kharkov/O=Mirantis/OU=dev_ops/CN=vm1/"
openssl genrsa -out /etc/ssl/certs/web.key 2048
openssl req -new\
       -out /etc/ssl/certs/web.csr\
       -key /etc/ssl/certs/web.key -subj "/C=UA/ST=Kharkov/L=Kharkov/O=Mirantis/OU=dev_ops/CN=vm1/"
openssl x509 -req\
       -in /etc/ssl/certs/web.csr\
       -CA /etc/ssl/certs/root-ca.crt\
       -CAkey /etc/ssl/certs/root-ca.key\
       -CAcreateserial\
       -out /etc/ssl/certs/web.crt
cat /etc/ssl/certs/root-ca.crt /etc/ssl/certs/web.crt> \
    /etc/ssl/certs/web-ca-chain.pem



