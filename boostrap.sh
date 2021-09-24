#!/bin/bash

vagrant ssh radiant -c sudo pacman -S --noconfirm git ansible
vagrant ssh radiant -c git clone https://github.com/mkualquiera/Kaladin.git