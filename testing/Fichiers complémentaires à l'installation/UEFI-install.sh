#!/usr/bin/env bash
# Contributeurs :
#  - Babilinx : code
#  - Chevek : vérifications et debuging
#  - Wamuu : vérifications et test
# mars 2022
# Script d'installation pour UEFI en chroot
#
# Initialisation des couleurs
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_RESET="\033[0m"
# Récupération des variables du script précédent
PROCESSORS="$5"
SELECTED_GPU_DRIVERS_TO_INSTALL="$6"
# MAJ des variables d'environnement
echo -e "${COLOR_GREEN}*${COLOR_RESET} Mise à jour des variables d'environnement."
env--update && source /etc/profile
clear
# Configuration de fstab
echo -e "${COLOR_GREEN}*${COLOR_RESET} Configuration du fichier fstab"
echo "/dev/$1    /    ext4    defaults,noatime           0 1" >> /etc/fstab
echo "/dev/$2    none    swap    sw    0 0" >> /etc/fstab
echo "/dev/$3    /boot/EFI    vfat    defaults    0 0" >> /etc/fstab
echo ""
read -p "[Entrée] pour configurer le nom de la machine."
# Configuration du nom de la machine
nano -w /etc/conf.d/hostname
read -p "[Entrée] pour continuer l'installation."
clear
# Génération du mot de passe root
echo -e "${COLOR_GREEN}*${COLOR_RESET} Utilisateurs :"
echo -e "  Mot de passe root :"
passwd
# Création d'un utilisateur non privilégié
useradd -m -G users,wheel,audio,cdrom,video,portage -s /bin/bash $4
echo "  Mot de passe de $4 :"
passwd $4
echo ""
read -p "[Entrée] pour continuer l'installation."
clear
#-----Configuration de GRUB-----#
echo -e "${COLOR_GREEN}*${COLOR_RESET} Configuration de GRUB :"
# Installation de GRUB pour UEFI
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=orchid_grub
read -p "[Entrée] pour continuer l'installation."
clear
#-----Activation des services-----#
echo -e "${COLOR_GREEN}*${COLOR_RESET} Activation de services :"
# Activation des services rc
rc-update add display-manager default && rc-update add dbus default && rc-update add NetworkManager default && rc-update add elogind boot
echo ""
read -p "[Entrée] pour terminer l'installation."
clear
