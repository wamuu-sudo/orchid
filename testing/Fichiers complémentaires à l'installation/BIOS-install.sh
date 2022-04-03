# Contributeurs :
#  - Babilinx : code
#  - Chevek : code
#  - Wamuu : vérifications et test
# mars 2022
# Script d'installation pour BIOS en chroot
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
# MAJ des variables d'environement
echo 'Mise à jour des variables d environement'
env--update && source /etc/profile
clear
# Configuration de fstab
echo "${COLOR_GREEN}*${COLOR_RESET} Configuration du fichier fstab."
echo "/dev/$1    /    ext4    defaults,noatime           0 1" >> /etc/fstab
echo "/dev/$2    none    swap    sw    0 0" >> /etc/fstab
echo ""
read -p "${COLOR_WHITE}[Entrée]${COLOR_RESET} pour configurer le nom de la machine."
# Configuration du nom de la machine
nano -w /etc/conf.d/hostname
clear
# Génération du mot de passe root
echo "${COLOR_GREEN}*${COLOR_RESET} Utilisateurs :"
echo ""
echo "  ${COLOR_GREEN}*${COLOR_RESET} Mot de passe root :"
passwd
# Création d'un utilisateur non privilégié
useradd -m -G users,wheel,audio,cdrom,video,portage -s /bin/bash $4
echo ""
echo "  ${COLOR_GREEN}*${COLOR_RESET} Mot de passe de $4 :"
passwd $4
echo ""
read -p "${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer l'installation."
#-----Configuration de GRUB-----#
echo "${COLOR_GREEN}*${COLOR_RESET} Configuration de GRUB :"
# Installation de GRUB pour BIOS
grub-install /dev/$3
grub-mkconfig -o /boot/grub/grub.cfg
read -p "${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer l'installation."
#-----Activation des services-----#
echo "${COLOR_GREEN}*${COLOR_RESET} Activation de services :"
# Activation des services rc
rc-update add display-manager default && rc-update add dbus default && rc-update add NetworkManager default && rc-update add elogind boot
