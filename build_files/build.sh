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
    niri

dnf remove -y \
    sddm \
    waybar \

### Enable various system units
systemctl --root=/ --user add-wants niri.service dms
systemctl --root=/ enable greetd.service power-pruninstallofiles-daemon.service

### Create default account
useradd --root=/ \
        --create-home \
        --home-dir /var/home/logan \
        --groups wheel,greeter,video,audio,input \
        --shell /usr/bin/zsh \
        logan
