#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

dnf copr enable -y avengemedia/dms
dnf copr enable -y avengemedia/danklinux
dnf copr enable -y scottames/ghostty

dnf install -y \
    dms \
    ghostty \
    dms-greeter \
    quickshell-git \
    dankcalendar-git \
    dgop \
    dsearch \
    matugen \
    qt6-qtmultimedia \
    dolphin \
    greetd \
    zsh \
    niri \
    firefox

dnf remove -y \
    waybar \
    sddm

# Create default account
useradd --root=/ \
    --create-home \
    --home-dir /var/home/logan \
    --groups wheel,greeter,video,audio,input \
    --shell /usr/bin/zsh \
    logan

# Set up DMS for the default user's systemd session
mkdir -p /var/home/logan/.config/systemd/user/niri.service.wants

ln -sf \
    /var/home/logan/.config/systemd/user/dms.service \
    /var/home/logan/.config/systemd/user/niri.service.wants/dms.service

chown -R logan:logan /var/home/logan/.config

# System services
systemctl --root=/ enable greetd.service