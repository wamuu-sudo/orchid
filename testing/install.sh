#!/usr/bin/env bash
# Contributeurs :
#  - Babilinx : code
#  - Chevek : vérifications
#  - Wamuu : vérifications et test
# mars 2022
# Script d'installation pour Orchid Linux
#
# Initialisation des URLs des archives
DWM='https://orchid.juline.tech/stage4-orchid-dwm-standard-20032022-r1.tar.gz'
DWM_GE='https://orchid.juline.tech/stage4-orchid-dwm-gaming-20032022-r1.tar.gz'
Gnome='https://orchid.juline.tech/stage4-orchid-gnome-full-20032022-r2.tar.gz'
Gnome_lte='https://orchid.juline.tech/stage4-orchid-gnome-light-20032022-r2.tar.gz'
KDE='https://orchid.juline.tech/stage4-orchid-kde-20032022-r2.tar.gz'

#-----Début du script-----#
# Disclamer
echo "L'équipe d'Orchid Linux n'est en aucun cas responsable de tout les problèmes possibles et inimaginables"
echo "qui pourrait arriver en installant Orchid Linux."
echo "Lisez très attentivement les instructions"
echo "Merci d'avoir choisi Orchid Linux !"
echo ""
read -p " Pressez [Entrée] pour commencer l'installation"
clear
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
#------Partitionnement-----#
echo "Partitionnement :"
# Affichage des différents disques
fdisk -l
# Demande du non du disque à utiliser
read -p "Quel est le nom du disque à utiliser pour l'installation ? (ex: sda ou nvme0n1) " disk_name
echo "! ATTENTION ! toutes les données sur ${disk_name} seront éffacées !"
echo ""
read -p "Pressez [Entrée] pour continuer si vous avez pris conaisssance des risques..."
echo "Voici le schéma recommandé :"
echo " - Une partition EFI de 256Mo formatée en vfat (si UEFI uniquement)."
echo " - Une partition BIOS boot de 1Mo, en premier (si BIOS uniquement)"
echo " - Une partition swap de quelques GO, en général 2 ou 4Go"
echo " - Le reste en ext4 (linux file system)"
echo ""
read -p "Prenez note si besoin, et notez bien le nom des partitions (ex: sda1) pour plus tard ; pressez [Entrée] pour lancer cfdisk..."
clear
# Lancement de cfdisk pour le partitionnement
cfdisk /dev/${disk_name}
clear
echo "Evitez de vous tromper lors des étapes qui suivent, sinon vous devrez recommencer."
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
# Formatage des partitions
echo "Formatage de la partition swap..."
mkswap /dev/${swap_name}
echo "Formatage de la partition ext4..."
mkfs.ext4 /dev/${ext4_name}
clear
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
#-----Installation du système-----#
echo "Installation du système complet"
cd /mnt/orchid
# Choix du système
echo ""
echo "Choisissez l'archive du système qui vous convient (ex: 1 pour DWM standard) :"
echo ""
echo "	1) Version standard DWM [2.2Go]"
echo "	2) Version DWM Gaming Edition [2.9Go]"
echo "	3) Version Gnome complète [2.8Go]"
echo "	4) Version Gnome light [2.7Go]"
echo "	5) Version KDE Plasma [3.5Go]"
read no_archive
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
	wget ${Gnome_lte}
elif [ "$no_archive" = "5" ]
then
	wget ${KDE}
fi
echo "Extraction de l'archive..."
# Extraction de l'archive précédament télégrargée
tar xvpf stage4-*.tar.gz --xattrs
clear
# Explication de la configuration à faire dans make.conf
echo "Configuration essentielle avent le chroot:"
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
echo "N'oubliez pas d'enregistrer avant de fermer le fichier !"
echo ""
read -p "[Entrée] pour accéder au fichier"
nano /mnt/orchid/etc/portage/make.conf
read -p "[Entrée] pour continuer l'installation"
clear
#-----Montage et chroot-----#
echo "Montage et chroot :"
# Montage
mount -t proc /proc /mnt/orchid/proc
mount --rbind /dev /mnt/orchid/dev
mount --rbind /sys /mnt/orchid/sys
if [ "$ifbios" = "n" ]
then
# Chroot UEFI
cat << EOF | chroot /mnt/orchid /bin/bash
# MAJ des variables d'environement
echo 'Mise à jour des variables d environement'
env--update && source /etc/profile
clear
# Configurationde fstab
echo "Fichier fstab :"
echo "Cofiguration du fstab"
echo "/dev/${ext4_name}    /    ext4    defaults,noatime           0 1" >> /etc/fstab
echo "/dev/${swap_name}    none    swap    sw    0 0" >> /etc/fstab
echo "/dev/${EFI_name}    /boot/EFI    vfat    defaults    0 0" >> /etc/fstab
echo ""
read -p "[Entrée] pour configurer le nom de la machine"
# Configuration du nom de la machine
nano -w /etc/conf.d/hostname
read -p "[Entrée] pour continuer l'installation"
clear
# Génération du mot de passe root
echo "Utilisateurs :"
echo "Mot de passe root :"
passwd
# Création d'un utilisateur non privilégié
read -p "Nom de l'utilisateur non-privilégié : " username
useradd -m -G users,wheel,audio,cdrom,video,portage -s /bin/bash ${username}
echo "Mot de passe de ${username} :"
passwd ${username}
echo ""
read -p "[Entrée] pour continuer l'installation"
clear
#-----Configuration de GRUB-----#
echo "Configuration de GRUB :"
# Installation de GRUB pour UEFI
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=orchid_grub
read -p "[Entrée] pour continuer l'installation"
clear
#-----Activation des services-----#
echo "Activation de services :"
# Activation des services rc
rc-update add display-manager default && rc-update add dbus default && rc-update add NetworkManager default && rc-update add elogind boot
echo ""
read -p "[Entrée] pour terminer l'installation"
clear
EOF
# Chroot BIOS
elif [ "$ifbios" = "y" ]
then
cat << EOF | chroot /mnt/orchid /bin/bash
# MAJ des variables d'environement
echo 'Mise à jour des variables d environement'
env--update && source /etc/profile
clear
# Configurationde fstab
echo "Fichier fstab :"
echo "Cofiguration du fstab"
echo "/dev/${ext4_name}    /    ext4    defaults,noatime	   0 1" >> /etc/fstab
echo "/dev/${swap_name}    none    swap    sw    0 0" >> /etc/fstab
echo ""
read -p "[Entrée] pour configurer le nom de la machine"
# Configuration du nom de la machine
nano -w /etc/conf.d/hostname
read -p "[Entrée] pour continuer l'installation"
clear
# Génération du mot de passe root
echo "Utilisateurs :"
echo "Mot de passe root :"
passwd
# Création d'un utilisateur non privilégié
read -p "Nom de l'utilisateur non-privilégié : " username
useradd -m -G users,wheel,audio,cdrom,video,portage -s /bin/bash ${username}
echo "Mot de passe de ${username} :"
passwd ${username}
echo ""
read -p "[Entrée] pour continuer l'installation"
clear
#-----Configuration de GRUB-----#
echo "Configuration de GRUB :"
# Installation de GRUB pour BIOS
grub-install /dev/${disk_name}
grub-mkconfig -o /boot/grub/grub.cfg
read -p "[Entrée] pour continuer l'installation"
clear
#-----Activation des services-----#
echo "Activation de services :"
# Activation des services rc
rc-update add display-manager default && rc-update add dbus default && rc-update add NetworkManager default && rc-update add elogind boot
echo ""
read -p "[Entrée] pour terminer l'installation"
clear
EOF
fi
# DWN configuration
if [ "$no_archive" = "1" ]
then
	cat << EOF | chroot /mnt/orchid /bin/bash
	/usr/share/orchid/fonts/applyorchidfonts && /usr/share/orchid/desktop/dwm/set-dwm
	EOF
fi
#-----Fin de l'installation-----#
echo "Finalisation :"
# Nouvelle vérification de la date et de l'heure
date
read -p "La date et l'heure sont elles correctes ? (format MMJJhhmmAAAA avec H -1) [y/n] " question_date
if [ "$question_date" = "n" ]
then
        read -p "Entrez la date et l'heure au format suivant : MMJJhhmmAAAA" date
fi
date ${date}
date
read -p "[Entrée] pour continuer l'installation"
# On nétoie
rm -f /mnt/orchid/*.tar.gz
cd /
unmount -R /mnt/orchid
read -p "Installation terminée !, [Entrée] pour redémarer, pensez bien à enlever le support d'installation ! Merci de nous avoir choisi !"
# On redémare pour démarer sur le système fraichement installé
reboot
