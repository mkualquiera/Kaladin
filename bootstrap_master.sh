#!/bin/bash

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
    mkdir -p ~/.ansible/plugins/modules

    # Install the aur module into the user custom module directory
    curl -o ~/.ansible/plugins/modules/aur.py https://raw.githubusercontent.com/kewlfft/ansible-aur/master/plugins/modules/aur.py
fi

cd Kaladin/bootstrap

ansible-playbook site.yml