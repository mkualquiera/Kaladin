#!/bin/bash

sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

systemctl restart sshd

echo "root:root" | chpasswd