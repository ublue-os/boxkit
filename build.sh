#! /usr/bin/env bash

PACMAN_PACKAGES=( $(yq -r ".pacman[]" /tmp/packages.json) )
YAY_PACKAGES=( $(yq -r ".aur[]" /tmp/packages.json) )

# sudo pacman -Syu ${PACMAN_PACKAGES[@]}

git clone https://aur.archlinux.org/yay.git
cd yay || exit 1
makepkg -sri --needed --noconfirm 
cd && rm -rf .cache yay

if command -v yay > /dev/null
then

    yay -Syu ${YAY_PACKAGES[@]}

fi


