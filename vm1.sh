#!/bin/bash

apt install ngnix -y -q

openssl req -x509 -newkey rsa:4096 -keyout vm.key -out vm.crt -subj "/C=US/ST=Oregon/L=Portland/O=Company Name/OU=Org/CN=www.example.com/subjectAltName = IP:10.0.0.10"


