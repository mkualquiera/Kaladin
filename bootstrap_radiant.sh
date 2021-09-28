#!/bin/bash

cd

if [[ -d Kaladin ]]; then
    git -C Kaladin pull
else
    sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

    systemctl restart sshd

    echo "root:root" | chpasswd
    pacman -Syuu --noconfirm
    pacman -S --noconfirm git ansible sshpass
    git clone https://github.com/mkualquiera/Kaladin.git
    python Kaladin/sendkeys.py
    ansible-galaxy collection install kewlfft.aur
fi

cd Kaladin/bootstrap

ansible-playbook site.yml

reboot