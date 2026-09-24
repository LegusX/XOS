#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# VS Code
rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_Rawhide/home:TheLocehiliosan:yadm.repo

dnf copr enable -y avengemedia/dms
dnf copr enable -y avengemedia/danklinux
dnf copr enable -y scottames/ghostty
dnf copr enable -y scottames/awww

dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release terra-gpg-keys

dnf install -y --skip-unavailable \
    dms \
    ghostty \
    dms-greeter \
    quickshell-git \
    dankcalendar-git \
    dgop \
    dsearch \
    matugen \
    qt6-qtmultimedia \
    nautilus \
    greetd \
    zsh \
    niri \
    firefox \
    yadm \
    code \
    helix \
    adw-gtk3-theme \
    awww \
    powerline-fonts \
    dotnet-sdk-10.0 \
    kf6-kimageformats \
    gnome-keyring \
    vesktop


dnf remove -y \
    waybar \
    sddm \
    rofi \
    pipewire-config-raop

# groupadd -f audio
# groupadd -f video
# groupadd -f input

# Create default account
useradd --create-home \
    --home-dir /var/home/logan \
    --groups wheel,greeter \
    --shell /usr/bin/zsh \
    logan

# Set up DMS for the default user's systemd session
mkdir -p /usr/lib/systemd/user/niri.service.wants

ln -sf \
    /usr/lib/systemd/user/dms.service \
    /usr/lib/systemd/user/niri.service.wants/dms.service

chown -R logan:logan /var/home/logan/.config

# System services
systemctl --root=/ enable greetd.service