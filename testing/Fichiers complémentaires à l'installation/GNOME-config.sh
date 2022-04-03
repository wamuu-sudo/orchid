#!/usr/bin/env bash
# Contributeurs :
#  - Babilinx : code
#  - Chevek : code
#  - Wamuu : vérifications et test
# mars 2022
# Script de configuration GNOME pour passer le clavier en AZERTY
#
#Copyright (C) 2022 Babilinx, Yannick Defais aka Chevek, Wamuu-sudo
#This program is free software: you can redistribute it and/or modify it under
#the terms of the GNU General Public License as published by the Free Software
#Foundation, either version 3 of the License, or (at your option) any later
#version.
#This program is distributed in the hope that it will be useful, but WITHOUT
#ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#You should have received a copy of the GNU General Public License along with
#this program. If not, see https://www.gnu.org/licenses/.
#
# Initialisation des couleurs
COLOR_YELLOW=$'\033[0;33m'
COLOR_GREEN=$'\033[0;32m'
COLOR_RED=$'\033[0;31m'
COLOR_LIGHTBLUE=$'\033[1;34m'
COLOR_WHITE=$'\033[1;37m'
COLOR_RESET=$'\033[0m'
# On prépare le chroot pour openrc-gsettingsd -> dbus
echo "${COLOR_GREEN}*${COLOR_RESET} Configuration de gdm et GNOME pour un clavier fr."
mkdir -p /lib64/rc/init.d
ln -s /lib64/rc/init.d /run/openrc
touch /run/openrc/softlevel
# save default OpenRC setup, and configure for chroot
mv /etc/rc.conf /etc/rc.conf.SAVE
echo 'rc_sys="prefix"' >> /etc/rc.conf
echo 'rc_controller_cgroups="NO"' >> /etc/rc.conf
echo 'rc_depend_strict="NO"' >> /etc/rc.conf
echo 'rc_need="!net !dev !udev-mount !sysfs !checkfs !fsck !netmount !logger !clock !modules"' >> /etc/rc.conf
rc-update --update
rc-service openrc-settingsd start
# On récupère la langue du système
if [ -r /etc/env.d/02locale ]; then source /etc/env.d/02locale; fi
LANG_SYSTEM="${LANG:0:2}"
#read -p "Nom de l'utilisateur précédemment créé : " username
mv /etc/X11/xorg.conf.d/10-keyboard.conf /etc/X11/xorg.conf.d/30-keyboard.conf
source /etc/conf.d/keymaps
KEYMAP=${LANG_SYSTEM}

gdbus call --system                                             \
           --dest org.freedesktop.locale1                       \
           --object-path /org/freedesktop/locale1               \
           --method org.freedesktop.locale1.SetVConsoleKeyboard \
           "$KEYMAP" "$KEYMAP_CORRECTIONS" true true
# On lance dbus en shell
dbus-run-session -- su -c "gsettings set org.gnome.desktop.input-sources sources \"[('xkb', '${LAND_SYSTEM}')]\"" $1 2>&1
rc-service openrc-settingsd stop
# restaure default setup
rm -f /etc/rc.conf
mv /etc/rc.conf.SAVE /etc/rc.conf
