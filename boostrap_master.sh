#!/bin/bash

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