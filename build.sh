#! /usr/bin/env bash

YAY_PACKAGES=( $(yq -r ".aur[]" /tmp/packages.json) )

git clone https://aur.archlinux.org/yay.git
cd yay || exit 1
makepkg -sri --needed --noconfirm 
cd && rm -rf .cache yay

if command -v yay > /dev/null
then

    yay -Syu --noconfirm ${YAY_PACKAGES[@]}

fi


