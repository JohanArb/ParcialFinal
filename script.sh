#!/bin/bash

# Update
sudo yum update -y

# Install firewalld
sudo yum install firewalld -y
sudo systemctl start firewalld

# Configure firewalld rules
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --permanent --add-masquerade
sudo firewall-cmd --reload
sudo firewall-cmd --permanent --zone=public --add-forward-port=port=8080:proto=tcp:toaddr=192.168.50.33:toport=8080
sudo firewall-cmd --reload
