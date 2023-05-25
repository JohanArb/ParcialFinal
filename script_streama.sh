#!/bin/bash

# Update
sudo yum -y update

# Install dependencies
sudo yum -y install wget

# Download and install Java JDK 8
wget --no-cookies --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm"
sudo yum -y localinstall jdk-8u131-linux-x64.rpm

# Download Streama
wget https://github.com/dularion/streama/releases/download/v1.1/streama-1.1.war

# Set up Streama
sudo mkdir /opt/streama
sudo mv streama-1.1.war /opt/streama/streama.war
sudo mkdir /opt/streama/media
sudo chmod 664 /opt/streama/media

# Create systemd service file for Streama
sudo bash -c 'cat > /etc/systemd/system/streama.service << EOF
[Unit]
Description=Streama Server
After=syslog.target
After=network.target

[Service]
User=root
Type=simple
ExecStart=/bin/java -jar /opt/streama/streama.war
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=Streama

[Install]
WantedBy=multi-user.target
EOF'

# Start and enable Streama service
sudo systemctl start streama
sudo systemctl enable streama

# Configure firewall
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
