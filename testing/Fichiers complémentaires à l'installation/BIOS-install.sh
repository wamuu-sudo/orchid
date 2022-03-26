# Contributeurs :
#  - Babilinx : code
#  - Chevek : vérifications et debuging
#  - Wamuu : vérifications et test
# mars 2022
# Script d'installation pour UEFI en chroot
#
# MAJ des variables d'environement
echo 'Mise à jour des variables d environement'
env--update && source /etc/profile
clear
# Configurationde fstab
echo "Fichier fstab :"
echo "Cofiguration du fstab"
echo "/dev/$1    /    ext4    defaults,noatime           0 1" >> /etc/fstab
echo "/dev/$2    none    swap    sw    0 0" >> /etc/fstab
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
