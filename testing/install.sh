#!/usr/bin/env bash
# Contributeurs :
#  - Babilinx : code
#  - Chevek : vérifications et debuging
#  - Wamuu : vérifications et test
# mars 2022
# Script d'installation pour Orchid Linux
#
# Initialisation des URLs des archives
DWM='https://orchid.juline.tech/stage4-orchid-dwmstandard-latest.tar.bz2'
DWM_GE='https://orchid.juline.tech/stage4-orchid-dwmgaming-latest.tar.bz2'
Gnome='https://orchid.juline.tech/stage4-orchid-gnomefull-latest.tar.bz2'
KDE='https://orchid.juline.tech/stage4-orchid-kde-20032022-r2.tar.gz'
#
# Initialisation des couleurs
COLOR_YELLOW="\033[0;33m"
COLOR_RESET="\033[0m"
# Disclaimer
echo -e "${COLOR_YELLOW}L'équipe d'Orchid Linux n'est en aucun cas responsable de tout les"
echo "problèmes possibles et inimaginables"
echo "qui pourrait arriver en installant Orchid Linux."
echo "Lisez très attentivement les instructions"
echo -e "Merci d'avoir choisi Orchid Linux !${COLOR_RESET}"
echo ""
read -p "Pressez [Entrée] pour commencer l'installation"
clear
#-----Questions de configuration-----#
# Choix du système
echo "Choisissez l'archive du système qui vous convient (ex: 1 pour DWM standard) :"
echo ""
echo "  1) Version standard DWM [2.2Go]"
echo "  2) Version DWM Gaming Edition [2.9Go]"
echo "  3) Version Gnome [2.8Go]"
echo "  4) Version KDE Plasma [3.5Go]"
read no_archive
echo ""
read -p "Quel0est le nom de l'utilisateur que vous voulez créer : " username
# Passage du clavier en AZERTY
loadkeys fr
# Check adresse IP
ip a
read -p "Disposez-vous d'une adresse IP ? [y/n] " question_IP
if [ "$question_ip" = "n" ]
then
        # si non, en générer une
        dhcpcd
fi
clear
#
#------Partitionnement-----#
echo "Partitionnement :"
# Affichage des différents disques
fdisk -l
# Demande du non du disque à utiliser
read -p "Quel est le nom du disque à utiliser pour l'installation ? (ex: sda ou nvme0n1) " disk_name
echo -e "${COLOR_YELLOW}! ATTENTION ! toutes les données sur ${disk_name} seront effacées !${COLOR_RESET}"
echo ""
read -p "Pressez [Entrée] pour continuer si vous avez pris conaisssance des risques..."
echo "Voici le schéma recommandé :"
echo " - Une partition EFI de 256Mo formatée en vfat (si UEFI uniquement)."
echo " - Une partition BIOS boot de 1Mo, en premier (si BIOS uniquement)"
echo " - Une partition swap de quelques GO, en général 2 ou 4Go"
echo " - Le reste en ext4 (linux file system)"
echo ""
read -p "${COLOR_YELLOW}Prenez note si besoin, et notez bien le nom des partitions (ex: sda1) pour plus tard${COLOR_RESET} ; pressez [Entrée] pour continuer"
clear
#
# Lancement de cfdisk pour le partitionnement
cfdisk /dev/${disk_name}
clear
#
echo -e "${COLOR_YELLOW}Evitez de vous tromper lors des étapes qui suivent, sinon vous devrez recommencer.${COLOR_RESET}"
echo ""
read -p "Quel est le nom de la partition swap ? " swap_name
read -p "quel est le nom de la partition ext4 ? " ext4_name
read -p "Utilisez-vous un système BIOS (=non UEFI) ? [y/n] " ifbios
if [ "$ifbios" = n ]
then
  read -p "Quel est le nom de la partition EFI? " EFI_name
  echo ""
  echo "Formatage de la partition EFI..."
  mkfs.vfat -F32 /dev/${EFI_name}
fi
#
# Formatage des partitions
echo "Formatage de la partition swap..."
mkswap /dev/${swap_name}
echo "Formatage de la partition ext4..."
mkfs.ext4 /dev/${ext4_name}
clear
#
# Montage des partitions
echo "Montage des partitions..."
echo "Partition racine..."
mkdir /mnt/orchid && mount /dev/${ext4_name} /mnt/orchid
echo "Activation du swap..."
swapon /dev/${swap_name}
# Pour l'EFI
if [ "$ifbios" = n ]
then
  mkdir -p /mnt/orchid/boot/EFI && mount /dev/${EFI_name} /mnt/orchid/boot/EFI
fi
# Vérification de la date et de l'heure
date
read -p "La date et l'heure sont elles correctes ? (format MMJJhhmmAAAA avec H -1) [y/n] " question_date
if [ "$question_date" = "n" ]
then
  read -p "Entrez la date et l'heure au format suivant : MMJJhhmmAAAA" date
fi
date ${date}
date
echo "Partitionnement terminé !"
echo ""
read -p "[Entrée] pour continuer l'installation"
clear
#
#-----Installation du système-----#
echo "Installation du système complet"
cd /mnt/orchid
# Explication de la configuration à faire dans make.conf
echo "Configuration essentielle avent le chroot:"
echo ""
echo -e "${COLOR_YELLOW}Lisez bien attentivement !${COLOR_RESET}"
echo ""
echo "Le fichier /etc/portage/make.conf est le fichier de configuration dans lequel on va définir les variables de notre future architecture (nombre de coeurs, carte vidéo, périphériques d'entrée, langue, choix des variables d'utilisation, etc... ). Par défaut, Orchid est déjà configurée avec les bonnes options par défaut :"
echo " - Détection et optimisation de GCC en fonstion de votre CPU"
echo " - Utilisation des fonctions essentielles comme Pulseaudio, networgmanager, ALSA."
echo " - Choix des pilotes graphiques Nvidia"
echo ""
echo "Configuration du fichier (s'en souvenir ou prendre note) :"
echo "Ici, il faudra juste changer votre nombre de coeurs pour qu'Orchid tire le meilleur profit de votre processeur :"
echo 'MAKEOPTS="-jX" X étant votre nombre de coeurs'
echo ""
echo "Par défaut Orchid supporte la majorité des cartes graphiques. Vous pouvez néanmoins supprimer celles que vous n'utilisez pas (bien garder fbdev et vesa !):"
echo 'VIDEO_CARDS="fbdev vesa intel i915 nvidia nouveau radeon amdgpu radeonsi virtualbox vmware"'
echo ""
echo -e "${COLOR_YELLOW}N'oubliez pas d'enregistrer avant de fermer le fichier !${COLOR_RESET}"
echo ""
read -p "[Entrée] pour accéder au fichier"
nano -w /mnt/orchid/etc/portage/make.conf
read -p "[Entrée] pour continuer l'installation"
clear
# Télégrargement du fichier adéquat
if [ "$no_archive" = "1" ]
then
  wget ${DWM}
elif [ "$no_archive" = "2" ]
then
  wget ${DWM_GE}
elif [ "$no_archive" = "3" ]
then
  wget ${Gnome}
elif [ "$no_archive" = "4" ]
then
  wget ${KDE}
fi
echo "Extraction de l'archive..."
# Extraction de l'archive précédament télégrargée
tar -jxvpf stage4-*.tar.bz2 --xattrs
clear
#
#-----Montage et chroot-----#
echo "On monte les dossiers proc et dev pour le chroot."
mount -t proc /proc /mnt/orchid/proc
mount --rbind /dev /mnt/orchid/dev
mount --rbind /sys /mnt/orchid/sys
# Téléchargement et extraction des scripts d'install pour le chroot
wget "https://github.com/wamuu-sudo/orchid/blob/main/testing/install-chroot.tar.xz?raw=true" --output-document=install-chroot.tar.xz
tar -xvf "install-chroot.tar.xz" -C /mnt/orchid
# On rend les scripts éxécutables
chmod +x /mnt/orchid/UEFI-install.sh && chmod +x  /mnt/orchid/BIOS-install.sh && chmod +x /mnt/orchid/DWM-config.sh && chmod +x /mnt/orchid/GNOME-config.sh
# Lancement des scripts en fonction du système
# UEFI
if [ "$ifbios" = "n" ]
then
	chroot /mnt/orchid ./UEFI-install.sh ${ext4_name} ${swap_name} ${EFI_name} ${username}
# BIOS
elif [ "$ifbios" = "y" ]
then
	chroot /mnt/orchid ./BIOS-install.sh ${ext4_name} ${swap_name} ${disk_name} ${username}
fi
# Configuration pour DWM
if [ "$no_archive" = "1" ]
then
	chroot /mnt/orchid ./DWM-config.sh
fi
# Configuration clavier pour GNOME
if [ "$no_archive" = "3" ]
then
  chroot /mnt/orchid ./GNOME-config.sh
fi
#
#-----Fin de l'installation-----#
rm -f /mnt/orchid/*.tar.bz2 && rm -f /mnt/orchid/*.tar.xz && rm -f /mnt/orchid/UEFI-install.sh && rm -f /mnt/orchid/BIOS-install.sh && rm -f /mnt/orchid/DWM-config.sh && rm -f /mnt/orchid/GNOME-config.sh
cd /
umount -R /mnt/orchid
read -p "Installation terminée !, [Entrée] pour redémarer, pensez bien à enlever le support d'installation. Merci de nous avoir choisi !"
# On redémare pour démarer sur le système fraichement installé
reboot
