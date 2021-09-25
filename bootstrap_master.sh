#!/bin/bash

sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

echo "\nPermitRootLogin yes" >> /etc/ssh/sshd_config

systemctl restart sshd

echo "root:root" | chpasswd

if [[ -d Kaladin ]]; then
    git -C Kaladin pull
else
    pacman -Syuu --noconfirm
    pacman -S --noconfirm git ansible sshpass
    git clone https://github.com/mkualquiera/Kaladin.git
    python Kaladin/sendkeys.py
fi

cd Kaladin/bootstrap

ansible-playbook site.yml