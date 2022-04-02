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
KDE='https://orchid.juline.tech/testing/stage4-orchid-kde-20032022-r2.tar.gz'
Gnome_GE='https://orchid.juline.tech/testing/stage4-orchid-gnome-gamingedition-23032022-r2.tar.gz'
# 
COLOR_YELLOW=$'\033[0;33m'
COLOR_GREEN=$'\033[0;32m'
COLOR_RED=$'\033[0;31m'
COLOR_LIGHTBLUE=$'\033[1;34m'
COLOR_WHITE=$'\033[1;37m'
COLOR_RESET=$'\033[0m'
# PASSWRD=""
ERROR_IN_SELECTOR=" "
declare -a CHOICES
declare -a GPU_DRIVERS
#Menu GPU_DRIVERS
# Available drivers: fbdev vesa intel i915 nvidia nouveau radeon amdgpu radeonsi virtualbox vmware
# fbdev & vesa are mandatory
GPU_DRIVERS[0]="intel"
GPU_DRIVERS[1]="i915"
GPU_DRIVERS[2]="nvidia"
GPU_DRIVERS[3]="radeon"
GPU_DRIVERS[4]="amdgpu"
GPU_DRIVERS[5]="radeonsi"
GPU_DRIVERS[6]="virtualbox"
GPU_DRIVERS[7]="vmware"

Cli_selector()
{
echo "Choisissez les pilotes pour votre GPU à installer (par défaut, ils sont tous sélectionnés) :"
for (( i = 0; i < ${#GPU_DRIVERS[@]}; i++ ))
do
  echo "[${CHOICES[$i]:-${COLOR_GREEN}✓${COLOR_RESET}}]" $(($i+1))") ${GPU_DRIVERS[$i]}"
done
echo "$ERROR_IN_SELECTOR"
}

Select_GPU_drivers_to_install()
{
clear
while Cli_selector && read -rp "Sélectionnez les pilotes pour votre GPU avec leur numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider : " NUM && [[ "$NUM" ]]; do
    clear
      if [[ "$NUM" == *[[:digit:]]* && $NUM -ge 1 && $NUM -le ${#GPU_DRIVERS[@]} ]]; then
          ((NUM--))
          if [[ "${CHOICES[$NUM]}" == "${COLOR_RED}✕${COLOR_RESET}" ]]; then
              CHOICES[NUM]="${COLOR_GREEN}✓${COLOR_RESET}"
          else
              CHOICES[NUM]="${COLOR_RED}✕${COLOR_RESET}"
          fi
              ERROR_IN_SELECTOR=" "
      else
          ERROR_IN_SELECTOR="Choix invalide : $NUM"
      fi
done
# Choice has been made by the user, now we need to populate SELECTED_GPU_DRIVERS_TO_INSTALL
# We will use | as a separator for drivers, as we need to pass this to another script in the chroot, thus we avoid spaces in the string.
# fbdev and vesa are required
SELECTED_GPU_DRIVERS_TO_INSTALL="fbdev|vesa"
j=0
for (( i = 0; i < ${#GPU_DRIVERS[@]}; i++ ))
do
  if [[ ! "${CHOICES[$i]}" == "${COLOR_RED}✕${COLOR_RESET}" ]]; then
    SELECTED_GPU_DRIVERS_TO_INSTALL+="|${GPU_DRIVERS[$i]}"
    ((j++))
  fi
done
}

Replace_separator_with_space()
{
SELECTED_GPU_DRIVERS_TO_INSTALL_SPACES=${SELECTED_GPU_DRIVERS_TO_INSTALL//|/" "}
}

###################################################
# Script start here
# Disclaimer
echo "${COLOR_YELLOW}L'équipe d'Orchid Linux n'est en aucun cas responsable de tous les"
echo "problèmes possibles et inimaginables"
echo "qui pourraient arriver en installant Orchid Linux."
echo "Lisez très attentivement les instructions."
echo "Merci d'avoir choisi Orchid Linux !${COLOR_RESET}"
echo ""
read -p "Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour commencer l'installation."
clear
#-----Questions de configuration-----#
# Choix du système
echo "Choisissez l'archive du système qui vous convient (ex: 1 pour DWM standard) :"
echo ""
echo "  ${COLOR_GREEN}1${COLOR_RESET}) Version standard DWM [2.2Go]"
echo "  ${COLOR_GREEN}2${COLOR_RESET}) Version DWM Gaming Edition [2.9Go]"
echo "  ${COLOR_GREEN}3${COLOR_RESET}) Version Gnome [2.8Go]"
echo "${COLOR_YELLOW} Testing :"
echo "          4${COLOR_RESET}) Version KDE Plasma [3.5Go]"
echo "          ${COLOR_YELLOW}5${COLOR_RESET}) Version Gnome Gaming Edition [9.0Go]"
read no_archive
echo ""
read -p "Quel est le nom de l'utilisateur que vous voulez créer : " username
# Passage du clavier en AZERTY
loadkeys fr
# Check adresse IP
ip a
read -p "Disposez-vous d'une adresse IP ? ${COLOR_WHITE}[o/n]${COLOR_RESET} " question_IP
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
echo "${COLOR_YELLOW}! ATTENTION ! Toutes les données sur ${disk_name} seront effacées !${COLOR_RESET}"
echo ""
read -p "Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer si vous avez pris conaisssance des risques..."
echo "Voici le schéma recommandé :"
echo " - Une partition EFI de 100Mo formatée en vfat (si UEFI uniquement)."
echo " - Une partition BIOS boot de 1Mo, en premier (si BIOS uniquement)"
echo " - Une partition swap de quelques GO, en général 2 ou 4Go"
echo " - Le reste en ext4 (linux file system)"
echo ""
read -p "Prenez note si besoin, et notez bien le nom des partitions (ex: sda1) pour plus tard ; pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer"
clear
#
# Lancement de cfdisk pour le partitionnement
cfdisk /dev/${disk_name}
clear
#
echo "${COLOR_YELLOW}Evitez de vous tromper lors des étapes qui suivent, sinon il faudra recommencer.${COLOR_RESET}"
echo ""
read -p "Quel est le nom de la partition swap ? (ex : sda2) " swap_name
read -p "Quel est le nom de la partition ext4 ? (ex : sda3) " ext4_name
read -p "Utilisez-vous un système BIOS (non = UEFI) ? ${COLOR_WHITE}[o/n]${COLOR_RESET} " ifbios
if [ "$ifbios" = n ]
then
  read -p "Quel est le nom de la partition EFI ? (ex : sda1) " EFI_name
  echo ""
  echo "${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition EFI..."
  mkfs.vfat -F32 /dev/${EFI_name}
fi
#
# Formatage des partitions
echo "${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition swap..."
mkswap /dev/${swap_name}
echo "${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition ext4..."
mkfs.ext4 /dev/${ext4_name}
clear
#
# Montage des partitions
echo "${COLOR_GREEN}*${COLOR_RESET} Montage des partitions :"
echo "  ${COLOR_GREEN}*${COLOR_RESET} Partition racine."
mkdir /mnt/orchid && mount /dev/${ext4_name} /mnt/orchid
echo "  ${COLOR_GREEN}*${COLOR_RESET} Activation du swap."
swapon /dev/${swap_name}
# Pour l'EFI
if [ "$ifbios" = n ]
then
  echo "  ${COLOR_GREEN}*${COLOR_RESET} Partition EFI."
  mkdir -p /mnt/orchid/boot/EFI && mount /dev/${EFI_name} /mnt/orchid/boot/EFI
fi
# Vérification de la date et de l'heure
# A priori inutile
#date
#read -p "La date et l'heure sont-elles correctes ? (format MMJJhhmmAAAA, avec hh -1 ou -2) [o/n] " question_date
#if [ "$question_date" = "n" ]
#then
#  read -p "Entrez la date et l'heure au format suivant : MMJJhhmmAAAA." date
#fi
#date ${date}
#date
echo "${COLOR_GREEN}*${COLOR_RESET} Partitionnement terminé !"
echo ""
read -p "${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer l'installation."
clear
#
#-----Installation du système-----#
# echo "${COLOR_GREEN}*${COLOR_RESET} Installation du système complet."
echo "Configuration essentielle avant le chroot:"
cd /mnt/orchid
# Count the number of CPU threads available on the system, to inject into /etc/portage/make.conf at a later stage
PROCESSORS=$(grep -c processor /proc/cpuinfo)
Select_GPU_drivers_to_install
clear
# Téléchargement du fichier adéquat
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
elif [ "$no_archive" = "5" ]
then
  wget ${Gnome_GE}
fi
echo "${COLOR_GREEN}*${COLOR_RESET} Extraction de l'archive..."
# Extraction de l'archive précédemment téléchargée
tar -jxvpf stage4-*.tar.bz2 --xattrs
clear
#
#-----Montage et chroot-----#
echo "${COLOR_GREEN}*${COLOR_RESET} On monte les dossiers proc, dev et sys pour le chroot."
mount -t proc /proc /mnt/orchid/proc
mount --rbind /dev /mnt/orchid/dev
mount --rbind /sys /mnt/orchid/sys
# Téléchargement et extraction des scripts d'install pour le chroot
wget "https://github.com/wamuu-sudo/orchid/blob/main/testing/install-chroot.tar.xz?raw=true" --output-document=install-chroot.tar.xz
tar -xvf "install-chroot.tar.xz" -C /mnt/orchid
# On rend les scripts exécutables
chmod +x /mnt/orchid/UEFI-install.sh && chmod +x  /mnt/orchid/BIOS-install.sh && chmod +x /mnt/orchid/DWM-config.sh && chmod +x /mnt/orchid/GNOME-config.sh
# Lancement des scripts en fonction du système
# UEFI
if [ "$ifbios" = "n" ]
then
	chroot /mnt/orchid ./UEFI-install.sh ${ext4_name} ${swap_name} ${EFI_name} ${username} ${PROCESSORS} ${SELECTED_GPU_DRIVERS_TO_INSTALL}
# BIOS
elif [ "$ifbios" = "o" ]
then
	chroot /mnt/orchid ./BIOS-install.sh ${ext4_name} ${swap_name} ${disk_name} ${username} ${PROCESSORS} ${SELECTED_GPU_DRIVERS_TO_INSTALL}
fi
# Configuration pour DWM
if [ "$no_archive" = "1" ]
then
	chroot /mnt/orchid ./DWM-config.sh
fi
# Configuration clavier pour GNOME
if [ "$no_archive" = "3" || "$no_archive" = "5" ]
then
  chroot /mnt/orchid ./GNOME-config.sh
fi
#
#-----Fin de l'installation-----#
rm -f /mnt/orchid/*.tar.bz2 && rm -f /mnt/orchid/*.tar.xz && rm -f /mnt/orchid/UEFI-install.sh && rm -f /mnt/orchid/BIOS-install.sh && rm -f /mnt/orchid/DWM-config.sh && rm -f /mnt/orchid/GNOME-config.sh
cd /
umount -R /mnt/orchid
read -p "Installation terminée !, [Entrée] pour redémarer, pensez bien à enlever le support d'installation. Merci de nous avoir choisi !"
# On redémarre pour démarrer sur le système fraichement installé
reboot
