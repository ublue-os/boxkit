#!/usr/bin/bash

home_dir="$(getent passwd $(id -u) | awk '{print $6}' FS=':')"
OBS_CONFIG_DIR="/opt/obs-portable/config"
OBS_USER_CONFIG_DIR="/run/host/${home_dir}/.config/obs-portable"

if ! [ -d "${OBS_USER_CONFIG_DIR}" ]; then
    mkdir "${OBS_USER_CONFIG_DIR}"
fi

if ! [ -d "${OBS_CONFIG_DIR}" ]; then
    sudo mkdir "${OBS_CONFIG_DIR}"
fi

if ! findmnt "${OBS_CONFIG_DIR}"; then
    sudo mount --bind \
        "${OBS_CONFIG_USER_DIR}" \
        "${OBS_CONFIG_DIR}"
fi
