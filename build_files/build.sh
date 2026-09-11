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
    zsh

dnf remove \
    sddm \
    waybar \

### Enable various system units
systemctl --user add-wants niri.service dms
systemctl enable greetd.service power-pruninstallofiles-daemon.service

### Create default account
useradd --root=/ \
        --create-home \
        --home-dir /var/home/logan \
        --groups wheel,greeter,video,audio,input \
        --shell /usr/bin/zsh \
        logan

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
