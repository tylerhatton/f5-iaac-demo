#!/bin/bash

## Setting User Password
echo -e "${password}\n${password}" | passwd ${username}

## Installing Packages
sudo yum -y install ansible-2.9.6-1.el7.noarch libappindicator python-pip dnsmasq bash-completion

mkdir /tmp/downloads

# Hyper
wget https://github.com/zeit/hyper/releases/download/3.0.2/hyper-3.0.2.x86_64.rpm -O /tmp/downloads/hyper.rpm
sudo rpm -i /tmp/downloads/hyper.rpm

## Customizing Chromium Icon
sudo sed -i 's#Exec=/usr/bin/chromium-browser --password-store=basic#Exec=/usr/bin/chromium-browser --ignore-certificate-errors --password-store=basic https://console-openshift-console.apps.aio.wwtlab.biz https://10.0.30.101#g' /home/${username}/Desktop/Chromium.desktop

