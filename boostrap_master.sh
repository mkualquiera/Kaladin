#!/bin/bash

pacman -Syuu --noconfirm
pacman -S --noconfirm git ansible

if [[ -d Kaladin ]]; then
    git -C Kaladin pull
else
    git clone https://github.com/mkualquiera/Kaladin.git
fi

cd Kaladin

ansible-playbook bootstrap/site.yml