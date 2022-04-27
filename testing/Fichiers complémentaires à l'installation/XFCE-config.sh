# Script de configuration de Xfce
# CONTRUBUTORS : Babilinx, Chevek, Crystal, Wamuu
# 2022
#
#Copyright (C) 2022 Babilinx, Yannick Defais aka Chevek, Wamuu-sudo, Crystal
#This program is free software: you can redistribute it and/or modify it under
#the terms of the GNU General Public License as published by the Free Software
#Foundation, either version 3 of the License, or (at your option) any later
#version.
#This program is distributed in the hope that it will be useful, but WITHOUT
#ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#You should have received a copy of the GNU General Public License along with
#this program. If not, see https://www.gnu.org/licenses/.

# Initialisation des couleurs
COLOR_YELLOW=$'\033[0;33m'
COLOR_GREEN=$'\033[0;32m'
COLOR_RED=$'\033[0;31m'
COLOR_LIGHTBLUE=$'\033[1;34m'
COLOR_WHITE=$'\033[1;37m'
COLOR_RESET=$'\033[0m'

echo "${COLOR_GREEN}*${COLOR_RESET} Configuration de Xfce."
# Set background image for Lightdm-gtk-greeter
cp -f /usr/share/orchid/wallpapers/orchid_nw_01.jpg /usr/share/lightdm/backgrounds/
sed -i 's/gentoo-bg_65.jpg/orchid_nw_01.jpg/g' /etc/lightdm/lightdm-gtk-greeter.conf
# Add wallpapers to Xfce
cp -f /usr/share/orchid/wallpapers/*.{jpg,png} /usr/share/backgrounds/xfce/
# Set default wallpaper for any new user
cp -f /xfce4-desktop.xml /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/
# Set Firefox-bin as the default web Browser for the user
#runuser -u ${1} -- xdg-settings set default-web-browser firefox-bin.desktop
sed -i 's/firefox/firefox-bin/g' /etc/xdg/xfce4/helpers.rc

