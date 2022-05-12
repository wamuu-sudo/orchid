#!/usr/bin/env bash
#===================================================================================
#
# FILE : postinstall-in-chroot.sh
#
# USAGE : Automatique
#
# DESCRIPTION : Script d'installation dans le chroot pour Orchid Linux.
#
# BUGS : ---
# NOTES : Ce script n'est pas à lancer par l'utilisateur, il est lancé automatiquement
#         lors de l'exécution du script d'installation , install.sh.
# CONTRUBUTORS : Babilinx, Chevek, Crystal, Wamuu
# CREATED : mars 2022
# REVISION : 17 avril 2022
#
# LICENCE :
# Copyright (C) 2022 Babilinx, Yannick Defais aka Chevek, Wamuu-sudo, Crystal
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with
# this program. If not, see https://www.gnu.org/licenses/.
#===================================================================================

#=== PRECONFIGURATION ==============================================================

# Initialisation des couleurs
#-----------------------------------------------------------------------------------
COLOR_YELLOW=$'\033[0;33m'
COLOR_GREEN=$'\033[0;32m'
COLOR_RED=$'\033[0;31m'
COLOR_LIGHTBLUE=$'\033[1;34m'
COLOR_WHITE=$'\033[1;37m'
COLOR_RESET=$'\033[0m'
#-----------------------------------------------------------------------------------

# Importation des variables du script principal
#-----------------------------------------------------------------------------------
CHOOSEN_DISK=$1
ROM=$2
ROOT_PASS=$3
USERNAME=$4
USER_PASS=$5
HOSTNAME=$6
ORCHID_LOGIN=$7
ESYNC_SUPPORT=$8
UPDATE_ORCHID=$9
ORCHID_NAME=${10}
FILESYSTEM=${11}

#-----------------------------------------------------------------------------------

#============================================================== PRECONFIGURATION ===

#=== MAIN ==========================================================================

# MAJ des variables d'environnement
#-----------------------------------------------------------------------------------
echo "${COLOR_GREEN}*${COLOR_RESET} Mise à jour des variables d'environnement."
env-update && source /etc/profile
#-----------------------------------------------------------------------------------

# Configuration de fstab
#-----------------------------------------------------------------------------------
# Is this an NVME disk?
if [[ "${CHOOSEN_DISK}" == *"nvme"* ]]; then
	DISK_PARTITIONS="${CHOOSEN_DISK}p"
else
	DISK_PARTITIONS="${CHOOSEN_DISK}"
fi

echo "${COLOR_GREEN}*${COLOR_RESET} Configuration du fichier fstab"
if [ "$FILESYSTEM" = "Btrfs" ]; then
	echo " ${COLOR_GREEN}*${COLOR_RESET} Configuration pour Btrfs"
	btrfs subvolume create root
	snapper -c root create-config /
	echo "${DISK_PARTITIONS}3    /    btrfs    subvol=root,compress=zstd:1,defaults           0 0" >> /etc/fstab
elif [ "$FILESYSTEM" = "ext4" ]; then	
	echo " ${COLOR_GREEN}*${COLOR_RESET} Configuration pour ext4"
	echo "${DISK_PARTITIONS}3    /    ext4    defaults,noatime           0 1" >> /etc/fstab
fi
echo "${DISK_PARTITIONS}2    none    swap    sw    0 0" >> /etc/fstab
if [ "$ROM" = "UEFI" ]; then
  echo "${DISK_PARTITIONS}1    /boot/EFI    vfat    defaults    0 0" >> /etc/fstab
fi

#-----------------------------------------------------------------------------------

# Configuration du nom de la machine (hostname)
#-----------------------------------------------------------------------------------
echo "${COLOR_GREEN}*${COLOR_RESET} Configuration du nom du système sur le réseau."
sed -i "s/orchid/${HOSTNAME}/" /etc/conf.d/hostname
#-----------------------------------------------------------------------------------

# Utilisateurs et mots de passe
#-----------------------------------------------------------------------------------
echo "${COLOR_GREEN}*${COLOR_RESET} Utilisateurs :"
echo ""
echo -e "${ROOT_PASS}\n${ROOT_PASS}" | passwd                                           # Création du mot de passe root
useradd -m -G users,wheel,audio,cdrom,video,portage,lp,lpadmin,plugdev,usb -s /bin/bash $USERNAME # Création d'un utilisateur non privilégié
echo -e "${USER_PASS}\n${USER_PASS}" | passwd $USERNAME                                 # Création du mot de passe utilisateur
#-----------------------------------------------------------------------------------

# Configuration de GRUB
#-----------------------------------------------------------------------------------
echo "${COLOR_GREEN}*${COLOR_RESET} Configuration de GRUB :"
if [ "$ROM" = "UEFI" ]; then
  # Installation de GRUB pour UEFI
  grub-install --target=x86_64-efi --efi-directory=/boot/EFI --recheck
  grub-mkconfig -o /boot/grub/grub.cfg
elif [ "$ROM" = "BIOS" ]; then
  # Installation de GRUB pour BIOS
  grub-install "${CHOOSEN_DISK}"
  grub-mkconfig -o /boot/grub/grub.cfg
fi

#-----------------------------------------------------------------------------------

# Activation des services et autres optimisations
#-----------------------------------------------------------------------------------
echo "${COLOR_GREEN}*${COLOR_RESET} Activation de services :"
# Activation des services rc
if [ "$ORCHID_LOGIN" = "BASE" ]; then
	rc-update add dbus default && rc-update add NetworkManager default
elif [ "$ORCHID_LOGIN" = "STANDARD" ]; then
	rc-update add display-manager default && rc-update add dbus default && rc-update add NetworkManager default && rc-update add elogind boot
elif [ "$ORCHID_LOGIN" = "SYSTEMD-BUDGIE" ]; then
	systemctl enable lightdm && systemctl enable NetworkManager
elif [ "$ORCHID_LOGIN" = "SYSTEMD-BASE" ]; then
	systemctl enable NetworkManager
elif [ "$ORCHID_LOGIN" = "SYSTEMD-GNOME" ]; then
	systemctl enable NetworkManager && systemctl enable gdm
fi

if [ "${ORCHID_NAME}" = "KDE" -o "${ORCHID_NAME}" = "XFCE-GE" ]; then
	# Lock session password
	echo "${COLOR_GREEN}*${COLOR_RESET} Activation de pam :"
	emerge -q pam
fi

# Change limits for esync support
# This change the configuration file of pam (see above)
if [ "$ESYNC_SUPPORT" = "o" ]; then
	echo "${COLOR_GREEN}*${COLOR_RESET} Activation du support esync pour les jeux pour ${USERNAME}."
	echo "${USERNAME} hard nofile 524288" >> /etc/security/limits.conf
fi

# Add CPU_FLAGS_X86 to make.conf
if ! test -x "$(command -v cpuid2cpuflags 2>/dev/null)"; then
	echo "${COLOR_GREEN}*${COLOR_RESET} Installation de cpuid2cpuflags."
	orchid-sync
	orchid-install app-portage/cpuid2cpuflags
fi

echo "${COLOR_GREEN}*${COLOR_RESET} Ajout des CPU_FLAGS_X86 personnalisés au make.conf."
echo "$(cpuid2cpuflags | sed 's/: /="/')\"" >> /etc/portage/make.conf
# Remove LINGUAS if any to make.conf
sed -i /LINGUAS=/d /etc/portage/make.conf

#-----------------------------------------------------------------------------------

# Mise à jour du système
#-----------------------------------------------------------------------------------
# We do an orchid-sync, in quiet mode:
echo "${COLOR_GREEN}*${COLOR_RESET} Mise à jour des commandes orchid-*."
git -C /usr/share/orchid/desktop/dwm/dwm-st-slstatus pull -q
git -C /usr/share/orchid/wallpapers pull -q
git -C /usr/share/orchid/orchid-bins pull -q 
cp /usr/share/orchid/orchid-bins/bins/* /usr/bin/
if [ "$UPDATE_ORCHID" = "o" ]; then
	echo "${COLOR_GREEN}*${COLOR_RESET} Mise à jour de votre Orchid Linux. Veuillez être patient."
  eix-sync -q
  emerge -qvuDNU @world
  flatpak update --assumeyes --noninteractive 
  grub-mkconfig -o /boot/grub/grub.cfg
  emerge --depclean -q
fi

if [ "$FILESYSTEM" = "Btrfs" ]; then
	echo "${COLOR_GREEN}*${COLOR_RESET} Défragmentation et compression du système de fichiers Btrfs"
	btrfs filesystem defragment -r -v -czstd /
fi
#-----------------------------------------------------------------------------------

#========================================================================== MAIN ===
