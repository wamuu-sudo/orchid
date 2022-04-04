#!/usr/bin/env bash
# Contributeurs :
#  - Babilinx : code
#  - Chevek : code
#  - Wamuu : vérifications et test
# mars 2022
# Script d'installation pour Orchid Linux
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

# Available Orchid Linux versions
ORCHID_VERSION[0]="Version standard DWM [1.9Go]"
ORCHID_URL[0]='https://orchid.juline.tech/stage4-orchid-dwmstandard-latest.tar.bz2' # DWM
COUNTED_BY_TREE[0]=326062 #dwms
ORCHID_VERSION[1]="Version DWM Gaming Edition [3.1Go]"
ORCHID_URL[1]='https://orchid.juline.tech/stage4-orchid-dwmgaming-latest.tar.bz2' # DWM_GE
COUNTED_BY_TREE[1]=358613 #dwmgaming
ORCHID_VERSION[2]="Version Gnome [2.8Go]"
ORCHID_URL[2]='https://orchid.juline.tech/stage4-orchid-gnomefull-latest.tar.bz2' # Gnome
COUNTED_BY_TREE[2]=424438 #gnomefull
ORCHID_VERSION[3]="Version KDE Plasma [3.5Go]"
ORCHID_URL[3]='https://orchid.juline.tech/testing/stage4-orchid-kde-20032022-r2.tar.gz' # KDE
COUNTED_BY_TREE[3]=744068 #kde
ORCHID_VERSION[4]="Version Gnome Gaming Edition [9.0Go]"
ORCHID_URL[4]='https://orchid.juline.tech/testing/stage4-orchid-gnome-gamingedition-23032022-r2.tar.gz' # Gnome_GE
COUNTED_BY_TREE[4]=436089 #gnome-ge
ORCHID_VERSION[5]="Version Gnome Gaming Edition avec Systemd [3.3Go]"
ORCHID_URL[5]="https://orchid.juline.tech/testing/stage4-gnomegaming-systemd-latest.tar.bz2"
COUNTED_BY_TREE[5]=452794 #gnomegaming-systemd
# Colors
COLOR_YELLOW=$'\033[0;33m'
COLOR_GREEN=$'\033[0;32m'
COLOR_RED=$'\033[0;31m'
COLOR_LIGHTBLUE=$'\033[1;34m'
COLOR_WHITE=$'\033[1;37m'
COLOR_RESET=$'\033[0m'

CHOICES_ORCHID[0]="${COLOR_GREEN}*${COLOR_RESET}"

BAR='=================================================='   # this is full bar, i.e. 50 chars

# Orchid version radiobox selector
declare -a ORCHID_VERSION
declare -a ORCHID_URL
declare -a CHOICES_ORCHID
ERROR_IN_ORCHID_SELECTOR=" "

# GPU drivers selector
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

Cli_Orchid_selector()
{
echo "Choisissez la version d'Orchid Linux que vous souhaitez installer :"
for (( i = 0; i < ${#ORCHID_VERSION[@]}; i++ ))
do
  if [[ "${ORCHID_URL[$i]}" == *"testing"* ]]; then
    echo "(${CHOICES_ORCHID[$i]:- }) Testing : ${COLOR_YELLOW}$(($i+1))${COLOR_RESET}) ${ORCHID_VERSION[$i]}"
  else
    echo "(${CHOICES_ORCHID[$i]:- }) ${COLOR_WHITE}$(($i+1))${COLOR_RESET}) ${ORCHID_VERSION[$i]}"
  fi
done
echo "$ERROR_IN_ORCHID_SELECTOR"
}

Select_Orchid_version_to_install()
{
clear
while Cli_Orchid_selector && read -rp "Sélectionnez la version d'Orchid Linux avec son numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider : " NUM && [[ "$NUM" ]]; do
    clear
      if [[ "$NUM" == *[[:digit:]]* && $NUM -ge 1 && $NUM -le ${#ORCHID_VERSION[@]} ]]; then
        ((NUM--))
        for (( i = 0; i < ${#ORCHID_VERSION[@]}; i++ ))
        do
          if [[ $NUM -eq $i ]]; then
            CHOICES_ORCHID[$i]="${COLOR_GREEN}*${COLOR_RESET}"
          else
            CHOICES_ORCHID[$i]=""
          fi
        done
        ERROR_IN_ORCHID_SELECTOR=" "
      else
          ERROR_IN_ORCHID_SELECTOR="Choix invalide : $NUM"
      fi
done
# Choice has been made by the user, now we need to populate no_archive
for (( i = 0; i < ${#ORCHID_VERSION[@]}; i++ ))
do
  if [[ "${CHOICES_ORCHID[$i]}" == "${COLOR_GREEN}*${COLOR_RESET}" ]]; then
    no_archive=$i
  fi
done
}

Cli_selector()
{
echo "Choisissez les pilotes pour votre GPU à installer (par défaut, ils sont tous sélectionnés) :"
for (( i = 0; i < ${#GPU_DRIVERS[@]}; i++ ))
do
  echo "[${CHOICES[$i]:-${COLOR_GREEN}+${COLOR_RESET}}]" $(($i+1))") ${GPU_DRIVERS[$i]}"
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
          if [[ "${CHOICES[$NUM]}" == "${COLOR_RED}-${COLOR_RESET}" ]]; then
              CHOICES[NUM]="${COLOR_GREEN}+${COLOR_RESET}"
          else
              CHOICES[NUM]="${COLOR_RED}-${COLOR_RESET}"
          fi
              ERROR_IN_SELECTOR=" "
      else
          ERROR_IN_SELECTOR="Choix invalide : $NUM"
      fi
done
# Choice has been made by the user, now we need to populate SELECTED_GPU_DRIVERS_TO_INSTALL
# We will use | as a separator for drivers, as we need to pass this to another script in the chroot, thus we avoid spaces in the string.
# fbdev and vesa are required
SELECTED_GPU_DRIVERS_TO_INSTALL="fbdev vesa"
for (( i = 0; i < ${#GPU_DRIVERS[@]}; i++ ))
do
  if [[ ! "${CHOICES[$i]}" == "${COLOR_RED}-${COLOR_RESET}" ]]; then
    SELECTED_GPU_DRIVERS_TO_INSTALL+=" ${GPU_DRIVERS[$i]}"
  fi
done
}

Decompress_with_progress_bar()
{
while read line; do
        pct_dash=$(( $processed * 50 / ${COUNTED_BY_TREE[$no_archive]} ))
        pct_num=$(( $processed * 100 / ${COUNTED_BY_TREE[$no_archive]} ))
        # Fail safe
        if [ $pct_num -ge 100 ]; then
          pct_num=99
        fi
        pct_num_pad="   $pct_num%"
        pct_num_lengh=${#pct_num_pad}
        position_to_trim=$(($pct_num_lengh - 4))
        echo -ne "\r${pct_num_pad:$position_to_trim}[${BAR:0:$pct_dash}\033[<1>D>"
        processed=$((processed+1))
        # Fail safe
        if [ $processed -ge ${COUNTED_BY_TREE[$no_archive]} ]; then
          processed=$((${COUNTED_BY_TREE[$no_archive]} -1))
        fi
done
}

###################################################
# Script start here
# Disclaimer
clear
echo "${COLOR_YELLOW}L'équipe d'Orchid Linux n'est en aucun cas responsable de tous les"
echo "problèmes possibles et inimaginables"
echo "qui pourraient arriver en installant Orchid Linux."
echo "Lisez très attentivement les instructions."
echo "Merci d'avoir choisi Orchid Linux !${COLOR_RESET}"
echo ""
read -p "Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour commencer l'installation."

#-----Questions de configuration-----#
# Choix du système
Select_Orchid_version_to_install
echo ""
read -p "${COLOR_WHITE}Quel est le nom de l'utilisateur que vous voulez créer : ${COLOR_RESET}" username
# Passage du clavier en AZERTY
echo "${COLOR_GREEN}*${COLOR_RESET} Passage du clavier en (fr)."
loadkeys fr
# Check adresse IP
ip a
read -p "Disposez-vous d'une adresse IP ? ${COLOR_WHITE}[o/n]${COLOR_RESET} " question_IP
if [ "$question_ip" = "n" ]
then
        # si non, en générer une
        dhcpcd
fi
#
#------Partitionnement-----#
echo "${COLOR_GREEN}*${COLOR_RESET} Partitionnement :"
# Affichage des différents disques
fdisk -l
# Demande du non du disque à utiliser
read -p "${COLOR_WHITE}Quel est le nom du disque à utiliser pour l'installation ? (ex: sda ou nvme0n1)${COLOR_RESET} " disk_name
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
#
# Lancement de cfdisk pour le partitionnement
cfdisk /dev/${disk_name}
#
echo "${COLOR_YELLOW}Evitez de vous tromper lors des étapes qui suivent, sinon il faudra recommencer.${COLOR_RESET}"
echo ""
read -p "${COLOR_WHITE}Quel est le nom de la partition swap ?${COLOR_RESET} (ex : sda2) " swap_name
read -p "${COLOR_WHITE}Quel est le nom de la partition ext4 ?${COLOR_RESET} (ex : sda3) " ext4_name
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
echo "${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition swap."
mkswap /dev/${swap_name}
echo "${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition ext4."
mkfs.ext4 /dev/${ext4_name}
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
#
#-----Installation du système-----#
# echo "${COLOR_GREEN}*${COLOR_RESET} Installation du système complet."
echo "${COLOR_GREEN}*${COLOR_RESET} Configuration essentielle avant le chroot :"
cd /mnt/orchid
# Count the number of CPU threads available on the system, to inject into /etc/portage/make.conf at a later stage
PROCESSORS=$(grep -c processor /proc/cpuinfo)
Select_GPU_drivers_to_install
# Téléchargement du fichier adéquat
echo "${COLOR_GREEN}*${COLOR_RESET} Téléchargement et extraction de la version d'Orchid Linux choisie."
# Extraction de l'archive précédemment téléchargée
processed=0
FILE_TO_DECOMPRESS=${ORCHID_URL[$no_archive]}
FILE_TO_DECOMPRESS=${FILE_TO_DECOMPRESS##*/} # just keep the file from the URL
# tar options to extract: tar.bz2 -jxvp, tar.gz -xvz, tar -xv
echo -ne "\r    [                                                  ]"  # This is an empty bar, i.e. 50 empty chars
if [[ "$no_archive" == "0" ]]; then
  wget -q -O- ${ORCHID_URL[$no_archive]} | tar -jxvp --xattrs 2>&1 | Decompress_with_progress_bar
elif [[ "$no_archive" == "1" ]]; then 
  wget -q -O- ${ORCHID_URL[$no_archive]} | tar -jxvp --xattrs 2>&1 | Decompress_with_progress_bar
elif [[ "$no_archive" == "2" ]]; then
  wget -q -O- ${ORCHID_URL[$no_archive]} | tar -jxvp --xattrs 2>&1 | Decompress_with_progress_bar
elif [[ "$no_archive" == "3" ]]; then
  wget -q -O- ${ORCHID_URL[$no_archive]} | tar -xvz --xattrs 2>&1 | Decompress_with_progress_bar
elif [[ "$no_archive" == "4" ]]; then
  wget -q -O- ${ORCHID_URL[$no_archive]} | tar -xv --xattrs 2>&1 | Decompress_with_progress_bar
elif [[ "$no_archive" == "5" ]]; then
  wget -q -O- ${ORCHID_URL[$no_archive]} | tar -jxvp --xattrs 2>&1 | Decompress_with_progress_bar
fi
# Fail safe
echo -ne "\r100%[${BAR:0:50}]"
# new line
echo -ne "\r\v"
echo "${COLOR_GREEN}*${COLOR_RESET} Extraction terminée."
# Configuration de make.conf
sed "/MAKEOPTS/c\MAKEOPTS=\"-j${PROCESSORS}\"" /mnt/orchid/etc/portage/make.conf > tmp1.conf
sed "/VIDEO_CARDS/c\VIDEO_CARDS=${SELECTED_GPU_DRIVERS_TO_INSTALL}" tmp1.conf > tmp2.conf
cp tmp2.conf /mnt/orchid/etc/portage/make.conf
rm -f tmp1.conf && rm -f tmp2.conf
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
	chroot /mnt/orchid ./UEFI-install.sh ${ext4_name} ${swap_name} ${EFI_name} ${username}
# BIOS
elif [ "$ifbios" = "o" ]
then
	chroot /mnt/orchid ./BIOS-install.sh ${ext4_name} ${swap_name} ${disk_name} ${username}
fi
# Configuration pour DWM
# no_archive use computer convention: start at 0
if [ "$no_archive" = "0" ]
then
	chroot /mnt/orchid ./DWM-config.sh
fi
# Configuration clavier pour GNOME
if [ "$no_archive" = "2" -o "$no_archive" = "4" ]
then
  chroot /mnt/orchid ./GNOME-config.sh ${username}
fi
#
#-----Fin de l'installation-----#
rm -f /mnt/orchid/*.tar.bz2 && rm -f /mnt/orchid/*.tar.xz && rm -f /mnt/orchid/UEFI-install.sh && rm -f /mnt/orchid/BIOS-install.sh && rm -f /mnt/orchid/DWM-config.sh && rm -f /mnt/orchid/GNOME-config.sh
cd /
if [ "$ifbios" = n ]
then
  umount /mnt/orchid/boot/EFI
fi
umount -R /mnt/orchid
read -p "Installation terminée ! ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour redémarrer. Pensez bien à enlever le support d'installation. Merci de nous avoir choisi !"
# On redémarre pour démarrer sur le système fraichement installé
reboot
