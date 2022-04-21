#!/usr/bin/env bash
#===================================================================================
#
# FILE : install.sh
#
# USAGE : su -
#         ./install.sh
#
# DESCRIPTION : Script d'installation pour Orchid Linux.
#
# BUGS : ---
# NOTES : ---
# CONTRUBUTORS : Babilinx, Chevek, Crystal, Wamuu
# CREATED : mars 2022
# REVISION: 17 avril 2022
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

# Setup all informations from stages
#-----------------------------------------------------------------------------------
ORCHID_VERSION[0]="Version standard DWM [1.9Go]"
ORCHID_URL[0]='https://dl.orchid-linux.org/stage4-orchid-dwmstandard-latest.tar.bz2' 	# DWM
ORCHID_COUNT[0]="https://dl.orchid-linux.org/stage4-orchid-dwmstandard-latest.count"
COUNTED_BY_TREE[0]=326062 	                                                            # Number of files in DWM stage
ORCHID_VERSION[1]="Version DWM Gaming Edition [3.3Go]"
ORCHID_URL[1]='https://dl.orchid-linux.org/stage4-orchid-dwmgaming-latest.tar.bz2' 	    # DWM GE
ORCHID_COUNT[1]="https://dl.orchid-linux.org/stage4-orchid-dwmgaming-latest.count"
COUNTED_BY_TREE[1]=358613 	                                                            # Number of files in DWM GE stage
ORCHID_VERSION[2]="Version Gnome [2.4Go]"
ORCHID_URL[2]='https://dl.orchid-linux.org/stage4-orchid-gnomefull-latest.tar.bz2'       # Gnome
ORCHID_COUNT[2]="https://dl.orchid-linux.org/stage4-orchid-gnomefull-latest.count.txt"
COUNTED_BY_TREE[2]=424438                                                               # Number of files in Gnome stage
ORCHID_VERSION[3]="Version KDE Plasma [3.3Go]"
ORCHID_URL[3]='https://dl.orchid-linux.org/testing/stage4-orchid-kde-20032022-r2.tar.gz' # KDE
#ORCHID_COUNT[3]=
COUNTED_BY_TREE[3]=744068                                                               # Number of files in KDE stage
ORCHID_VERSION[4]="Version Gnome Gaming Edition [9.0Go]"
ORCHID_URL[4]='https://dl.orchid-linux.org/testing/stage4-orchid-gnome-gamingedition-23032022-r2.tar.gz'  # Gnome GE
#ORCHID_COUNT[4]=
COUNTED_BY_TREE[4]=436089                                                               # Number of files in Gnome GE stage
ORCHID_VERSION[5]="Version Gnome Gaming Edition avec Systemd [3.3Go]"
ORCHID_URL[5]="https://dl.orchid-linux.org/testing/stage4-orchid-gnomegaming-systemd-latest.tar.bz2"  # Gnome GE Systemd
ORCHID_COUNT[5]="https://dl.orchid-linux.org/testing/stage4-orchid-gnomegaming-systemd-latest.count.txt"
COUNTED_BY_TREE[5]=452794                                                               # Number of files in Gnome GE SystemD stage
#-----------------------------------------------------------------------------------

# Setup colors
#-----------------------------------------------------------------------------------
COLOR_YELLOW=$'\033[0;33m'
COLOR_GREEN=$'\033[0;32m'
COLOR_RED=$'\033[0;31m'
COLOR_LIGHTBLUE=$'\033[1;34m'
COLOR_WHITE=$'\033[1;37m'
COLOR_RESET=$'\033[0m'
#-----------------------------------------------------------------------------------
CHOICES_ORCHID[0]="${COLOR_GREEN}*${COLOR_RESET}"

BAR='=================================================='                                # This is full bar, i.e. 50 chars

# Setup selectors
#-----------------------------------------------------------------------------------
# Orchid version radiobox selector
declare -a ORCHID_VERSION
declare -a ORCHID_URL
declare -a CHOICES_ORCHID
ERROR_IN_ORCHID_SELECTOR=" "

# GPU drivers selector
ERROR_IN_SELECTOR=" "
declare -a CHOICES
declare -a GPU_DRIVERS
# Menu GPU_DRIVERS
# Available drivers: fbdev vesa intel i915 nvidia nouveau radeon amdgpu radeonsi
# virtualbox vmware
# fbdev & vesa are mandatory
GPU_DRIVERS[0]="intel"
GPU_DRIVERS[1]="i915"
GPU_DRIVERS[2]="nvidia"
GPU_DRIVERS[3]="radeon"
GPU_DRIVERS[4]="amdgpu"
GPU_DRIVERS[5]="radeonsi"
GPU_DRIVERS[6]="virtualbox"
GPU_DRIVERS[7]="vmware"

CHOICES_DISK[0]="${COLOR_GREEN}*${COLOR_RESET}"
# Disks radiobox selector
declare -a CHOICES_DISK
ERROR_IN_DISK_SELECTOR=" "

# Regular Expression to test a valid hostname, as per RFC-952 and RFC-1123
# https://stackoverflow.com/questions/106179/regular-expression-to-match-dns-hostname-or-ip-address
VALID_HOSTNAME_REGEX="^([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])(\.([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]{0,61}[a-zA-Z0-9]))*$"

# Regular Expression to test a valid username
# https://unix.stackexchange.com/questions/157426/what-is-the-regex-to-validate-linux-users
# It should start (^) with only a lowercase letter or an underscore ([a-z_]). This occupies exactly 1 character.
# Then it should be one of either ( ... ):
# 	From 0 to 31 characters ({0,31}) of lowercase letters, numbers, underscores, and/or hyphens ([a-z0-9_-]),
# OR (|)
# 	From 0 to 30 characters of the above plus a US dollar sign symbol (\$) at the end,
# and then
# No more characters past this pattern ($).
VALID_USERNAME_REGEX="^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\\$)$"

#-----------------------------------------------------------------------------------

# Setup functions
#-----------------------------------------------------------------------------------

CLI_orchid_selector()
{
	echo "Choisissez la version d'Orchid Linux que vous souhaitez installer :"
	for (( i = 0; i < ${#ORCHID_VERSION[@]}; i++ )); do
		if [[ "${ORCHID_URL[$i]}" == *"testing"* ]]; then
			echo "(${CHOICES_ORCHID[$i]:- }) Testing : ${COLOR_YELLOW}$(($i+1))${COLOR_RESET}) ${ORCHID_VERSION[$i]}"
		else
			echo "(${CHOICES_ORCHID[$i]:- }) ${COLOR_WHITE}$(($i+1))${COLOR_RESET}) ${ORCHID_VERSION[$i]}"
		fi
	done

	echo "$ERROR_IN_ORCHID_SELECTOR"
}


select_orchid_version_to_install()
{
	clear
	while CLI_orchid_selector && read -rp "Sélectionnez la version d'Orchid Linux avec son numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider : " NUM && [[ "$NUM" ]]; do
		clear
		if [[ "$NUM" == *[[:digit:]]* && $NUM -ge 1 && $NUM -le ${#ORCHID_VERSION[@]} ]]; then
			((NUM--))
			for (( i = 0; i < ${#ORCHID_VERSION[@]}; i++ )); do
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
	for (( i = 0; i < ${#ORCHID_VERSION[@]}; i++ )); do
		if [[ "${CHOICES_ORCHID[$i]}" == "${COLOR_GREEN}*${COLOR_RESET}" ]]; then
			no_archive=$i
		fi
	done
}


CLI_selector()
{
	echo "Choisissez les pilotes pour votre GPU à installer (par défaut, il n'y en a aucun) :"
	for (( i = 0; i < ${#GPU_DRIVERS[@]}; i++ )); do
		echo "[${CHOICES[$i]:-${COLOR_RED}-${COLOR_RESET}}]" $(($i+1))") ${GPU_DRIVERS[$i]}"
	done

	echo "$ERROR_IN_SELECTOR"
}


select_GPU_drivers_to_install()
{
	clear
	while CLI_selector && read -rp "Sélectionnez les pilotes pour votre GPU avec leur numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider : " NUM && [[ "$NUM" ]]; do
		clear
		if [[ "$NUM" == *[[:digit:]]* && $NUM -ge 1 && $NUM -le ${#GPU_DRIVERS[@]} ]]; then
			((NUM--))
			if [[ "${CHOICES[$NUM]}" == "${COLOR_GREEN}+${COLOR_RESET}" ]]; then
				CHOICES[NUM]="${COLOR_RED}-${COLOR_RESET}"
			else
				CHOICES[NUM]="${COLOR_GREEN}+${COLOR_RESET}"
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
	for (( i = 0; i < ${#GPU_DRIVERS[@]}; i++ )); do
	  	if [[ "${CHOICES[$i]}" == "${COLOR_GREEN}+${COLOR_RESET}" ]]; then
			SELECTED_GPU_DRIVERS_TO_INSTALL+=" ${GPU_DRIVERS[$i]}"
	 	fi
	done
}


decompress_with_progress_bar()
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
		echo -ne "\r${pct_num_pad:$position_to_trim}[${BAR:0:$pct_dash}>"
		processed=$((processed+1))
		# Fail safe
		if [ $processed -ge ${COUNTED_BY_TREE[$no_archive]} ]; then
		  	processed=$((${COUNTED_BY_TREE[$no_archive]} -1))
		fi
	done
}


test_internet_access()
{
	if ping -c 1 82.65.199.131 &> /dev/null; then                                       # This is orchid.juline.tech
	  	test_ip=1                                                                       # We have internet access
	else
	  	test_ip=0                                                                       # We don't have internet access
	fi
}


CLI_disk_selector()
{
	echo "Choisissez le disque sur lequel vous souhaitez installer Orchid Linux :"
	echo "${COLOR_YELLOW}! ATTENTION ! Toutes les données sur le disque choisi seront effacées !${COLOR_RESET}"
	for (( i = 0; i < ${#DISKS[@]}; i++ )); do
	  	if [[ ${CHOICES_DISK[$i]} == "${COLOR_GREEN}*${COLOR_RESET}" ]]; then
			echo "(${CHOICES_DISK[$i]:- }) ${COLOR_GREEN}$(($i+1))) ${DISKS[$i]}${COLOR_RESET}"
	  	else
			echo "(${CHOICES_DISK[$i]:- }) ${COLOR_WHITE}$(($i+1))${COLOR_RESET}) ${DISKS[$i]}"
	  	fi
	done

	echo "$ERROR_IN_DISK_SELECTOR"
}


select_disk_to_install()
{
	clear
	while CLI_disk_selector && read -rp "Sélectionnez le disque pour installer Orchid Linux avec son numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider : " NUM && [[ "$NUM" ]]; do
		clear
		if [[ "$NUM" == *[[:digit:]]* && $NUM -ge 1 && $NUM -le ${#DISKS[@]} ]]; then
			((NUM--))
			for (( i = 0; i < ${#DISKS[@]}; i++ )); do
				if [[ $NUM -eq $i ]]; then
			  		CHOICES_DISK[$i]="${COLOR_GREEN}*${COLOR_RESET}"
				else
			  		CHOICES_DISK[$i]=""
				fi
		  	done

		  	ERROR_IN_DISK_SELECTOR=" "
		else
		  	ERROR_IN_DISK_SELECTOR="Choix invalide : $NUM"
	  	fi
	done
	# Choice has been made by the user, now we need to populate $CHOOSEN_DISK and $CHOOSEN_DISK_LABEL (human readable)
	for (( i = 0; i < ${#DISKS[@]}; i++ )); do
		if [[ "${CHOICES_DISK[$i]}" == "${COLOR_GREEN}*${COLOR_RESET}" ]]; then
			CHOOSEN_DISK=${DISKS_LABEL[$i]}
			CHOOSEN_DISK_LABEL=${DISKS[$i]}
	  	fi
	done
}


auto_partitionning_full_disk()
{
	SFDISK_CONFIG="label: gpt
	"                                                                                   # We only do GPT
	SFDISK_CONFIG+="device: ${CHOOSEN_DISK}
	"
	if [ "$ROM" = "UEFI" ]; then
		SFDISK_CONFIG+="${CHOOSEN_DISK}1: size=512M,type=uefi
		"                                                                               # EFI System
		SFDISK_CONFIG+="${CHOOSEN_DISK}2: size=${SWAP_SIZE_GB}G,type=swap
		"                                                                               # Linux SWAP
		SFDISK_CONFIG+="${CHOOSEN_DISK}3: type=linux
		"                                                                               # Linux filesystem data
	elif [ "$ROM" = "BIOS" ]; then
		SFDISK_CONFIG+="${CHOOSEN_DISK}1: size=8M,type=21686148-6449-6E6F-744E-656564454649
		"                                                                               # BIOS Boot partition
	  	SFDISK_CONFIG+="${CHOOSEN_DISK}2: size=${SWAP_SIZE_GB}G,type=swap
		"                                                                               # Linux SWAP
	 	 SFDISK_CONFIG+="${CHOOSEN_DISK}3: type=linux
		"                                                                               # Linux filesystem data
	fi

	echo "${COLOR_GREEN}*${COLOR_RESET} Partitionnement du disque."
	echo "$SFDISK_CONFIG" | sfdisk ${CHOOSEN_DISK}
	if [ "$ROM" = "UEFI" ]; then
	  	echo " ${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition EFI."
	  	mkfs.vfat -F32 "${CHOOSEN_DISK}1"
	fi

	echo " ${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition swap."
	mkswap "${CHOOSEN_DISK}2"
	echo " ${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition ext4."
	mkfs.ext4 "${CHOOSEN_DISK}3"
}

ask_yes_or_no_and_validate() # question en $1 (string), réponse par défaut en $2 ( o | n ),
{
while true; do
	local __ANSWER
	read -p "$1" __ANSWER
	if [ -z $__ANSWER ]; then
		__ANSWER=$2
	fi

  case $__ANSWER in
      "o" | "n" ) echo $__ANSWER; break;;
      * ) ;;
  esac
done
}

ask_for_numeric_and_validate() # question en $1 (string), nombre par défaut en $2 ( digit ),
{
while true; do
	local __ANSWER
	read -p "$1" __ANSWER
	if [ -z $__ANSWER ]; then
		__ANSWER=$2
	fi

  case $__ANSWER in
      [[:digit:]]* ) echo $__ANSWER; break;;
      * ) ;;
  esac
done
}


swap_size_hibernation()
{
	if (( ${RAM_SIZE_GB} >= 2 && ${RAM_SIZE_GB} < 8 )); then	                        # Pour une taille de RAM comprise entre 2 et 8 Go
		(( SWAP_SIZE_GB = ${RAM_SIZE_GB}*2 )) 	                                        # 2 fois la taille de la RAM

	elif (( ${RAM_SIZE_GB} >= 8 && ${RAM_SIZE_GB} < 64 )); then	                        # Pour une taille de RAM comprise entre 8 et 64 Go
		(( SWAP_SIZE_GB = ${RAM_SIZE_GB}*3/2 ))		                                    # 1.5 (3/2) fois la taille de la RAM

	elif (( ${RAM_SIZE_GB} >= 64 )); then	                                            # Pour une taille de RAM supérieure à 64 Go
		(( SWAP_SIZE_GB = ${RAM_SIZE_GB}*3/2 ))
		echo "Nous ne recommandons pas d'utiliser l'hibernation avec vos ${RAM_SIZE_GB} Go de RAM, car il faudrait une partition SWAP de ${SWAP_SIZE_GB} Go sur le disque."
		HIBERNATION_HIGH=$(ask_yes_or_no_and_validate "Voulez-vous créer une partition SWAP de ${SWAP_SIZE_GB} Go pour permettre l'hibernation ? (Si non, la partition SWAP sera beaucoup plus petite et vous ne pourrez pas utiliser l'hibernation) ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET} " n)
		if [ "$HIBERNATION_HIGH" = "n" ]; then
			swap_size_no_hibernation

		elif [ "$HIBERNATION_HIGH" = "o" ]; then
			SWAP_SIZE_GB=$(ask_for_numeric_and_validate "Entrez la taille de la partition SWAP que vous souhaitez créer (en Go) ${COLOR_WHITE}[${COLOR_GREEN}${SWAP_SIZE_GB} Go${COLOR_WHITE}]${COLOR_RESET} : " $SWAP_SIZE_GB)
		fi
	fi
}


swap_size_no_hibernation()
{
	if (( ${RAM_SIZE_GB} >= 2 && ${RAM_SIZE_GB} < 8 )); then	                        # Pour une taille de RAM comprise entre 2 et 8 Go
		(( SWAP_SIZE_GB = ${RAM_SIZE_GB} ))		                                        # 1 fois la taille de la RAM

	elif (( ${RAM_SIZE_GB} >= 8 && ${RAM_SIZE_GB} < 64 )); then	                        # Pour une taille de RAM comprise entre 8 et 64 Go
		(( SWAP_SIZE_GB = ${RAM_SIZE_GB}*1/2 ))		                                    # 0.5 (1/2) fois la taille de la RAM

	elif (( ${RAM_SIZE_GB} >= 64 )); then	                                            # Pour une taille de RAM supérieure à 64 Go
		(( SWAP_SIZE_GB = ${RAM_SIZE_GB}*1/2 ))
		SWAP_SIZE_GB=$(ask_for_numeric_and_validate "Entrez la taille de la partition SWAP que vous souhaitez créer (en Go) ${COLOR_WHITE}[${COLOR_GREEN}${SWAP_SIZE_GB} Go${COLOR_WHITE}]${COLOR_RESET} : " $SWAP_SIZE_GB)
	fi
}


test_if_hostname_is_valid()
{
if [ ${#HOSTNAME} -le 255 ]; then																								# Total length must not exceed 255
	if [[ "$HOSTNAME" =~ $VALID_HOSTNAME_REGEX ]]; then
		IS_HOSTNAME_VALID=1																													# hostname is valid
	else
		IS_HOSTNAME_VALID=0																													# hostname is not valid
	fi
else
		IS_HOSTNAME_VALID=0																													# hostname is not valid
fi
}

test_if_username_is_valid()
{
if [[ "$USERNAME" =~ $VALID_USERNAME_REGEX ]]; then
		IS_USERNAME_VALID=1																													# username is valid
	else
		IS_USERNAME_VALID=0																													# username is not valid
	fi
}

create_passwd() # Spécifier le nom de l'utilisateur en $1
{
    echo "${COLOR_WHITE}Saisisez le mot de passe pour l'utilisateur ${1} : ${COLOR_YELLOW}(le mot de passe n'apparaîtrera pas)${COLOR_RESET}"
    read -s ATTEMPT1
    echo "${COLOR_WHITE}Resaisisez le mot de passe pour le confirmer :${COLOR_RESET}"
    read -s ATTEMPT2
}


verify_password_concordance() # Spécifier le nom de l'utilisateur en $1
{
    while [[ "${ATTEMPT1}" != "${ATTEMPT2}" ]]; do
    	echo "${COLOR_YELLOW}Les mots de passe ne concordent pas, réessayez.${COLOR_RESET}"
    	create_passwd "${1}"
	done
}


#-----------------------------------------------------------------------------------

#============================================================== PRECONFIGURATION ===

#=== MAIN ==========================================================================

# Disclaimer
#-----------------------------------------------------------------------------------

clear
echo "${COLOR_YELLOW}L'équipe d'Orchid Linux n'est en aucun cas responsable de tous les"
echo "problèmes possibles et inimaginables"
echo "qui pourraient arriver en installant Orchid Linux."
echo "Lisez très attentivement les instructions."
echo "Merci d'avoir choisi Orchid Linux !${COLOR_RESET}"
echo ""
read -p "Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour commencer l'installation."

#-----------------------------------------------------------------------------------

# Questions de configuration
#===================================================================================

RAM_SIZE_GB=$(($(cat /proc/meminfo|grep MemTotal|sed "s/[^[[:digit:]]*//g")/1000000))   # Total Memory in GB
if (( $RAM_SIZE_GB < 2 )); then
	echo "${COLOR_YELLOW}Désolé, il faut au minimum 2 Go de RAM pour utiliser Orchid Linux. Fin de l'installation.${COLOR_RESET}"
	exit
fi

# Check Internet connection
#-----------------------------------------------------------------------------------

test_internet_access
while [ $test_ip = 0 ]; do
	echo "${COLOR_RED}*${COLOR_RESET} Test de la connection internet KO. Soit vous n'avez pas de conenction à l'internet, soit notre serveur est à l'arrêt."
	read -p "Nous allons tenter de vous trouver une connection à l'internet ; pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer"
	dhcpcd                                                                              # Génération d'une addresse IP
	test_internet_access
done
#-----------------------------------------------------------------------------------

echo "${COLOR_GREEN}*${COLOR_RESET} Internet OK."
# Choix du système
select_orchid_version_to_install
echo ""
# Passage du clavier en AZERTY
echo "${COLOR_GREEN}*${COLOR_RESET} Passage du clavier en (fr)."
loadkeys fr

# Partitionnement
#-----------------------------------------------------------------------------------

# Split an output on new lines:
SAVEIFS=$IFS	                                                                        # Save current IFS (Internal Field Separator)
IFS=$'\n'	# New line
DISKS=($(lsblk -d -p -n -o MODEL,SIZE,NAME -e 1,3,7,11,252))                            # Create an array with Disks: MODELs, SIZEs, NAMEs
IFS=$SAVEIFS	                                                                        # Restore original IFS

for (( i = 0; i < ${#DISKS[@]}; i++ )); do
	DISKS_LABEL[$i]=$(echo "${DISKS[$i]}" | awk '{printf $NF}')		                    # Extract NAME into DISKS_LABEL, e.g. /dev/sda
done

if [[ ${#DISKS[@]} == 1 ]]; then
	CHOOSEN_DISK=${DISKS_LABEL[0]}
	CHOOSEN_DISK_LABEL=${DISKS[0]}
else
    select_disk_to_install
fi

echo "${COLOR_GREEN}*${COLOR_RESET} Orchid Linux va s'installer sur ${COLOR_GREEN}${CHOOSEN_DISK} : ${CHOOSEN_DISK_LABEL}${COLOR_RESET}"
echo "${COLOR_YELLOW}                                  ^^ ! ATTENTION ! Toutes les données sur ce disque seront effacées !${COLOR_RESET}"
echo "${COLOR_GREEN}*${COLOR_RESET} Préparation pour le partionnement :"
if [ -d /sys/firmware/efi ]; then	                                                    # Test for UEFI or BIOS
	ROM="UEFI"
else
	ROM="BIOS"
fi

echo " ${COLOR_GREEN}*${COLOR_RESET} Le démarrage du système d'exploitation est de type ${ROM}."
echo " ${COLOR_GREEN}*${COLOR_RESET} Votre RAM a une taille de ${RAM_SIZE_GB} Go."
HIBERNATION=$(ask_yes_or_no_and_validate "Voulez-vous pouvoir utiliser l'hibernation (enregistrement de la mémoire sur le disque avant l'arrêt) ? ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET} " n)
#-----------------------------------------------------------------------------------

# Calcul de la mémoire SWAP idéale
#-----------------------------------------------------------------------------------

if [ "$HIBERNATION" = "o" ]; then	                                                    # Si hibernation
	swap_size_hibernation
elif [ "$HIBERNATION" = "n" ]; then		                                                # Si pas d'hibernation
	swap_size_no_hibernation
fi
#-----------------------------------------------------------------------------------
echo " ${COLOR_GREEN}*${COLOR_RESET} Votre SWAP aura une taille de ${SWAP_SIZE_GB} Go."
#=================================================
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
#=================================================
select_GPU_drivers_to_install                                                           # Select GPU

# Utilisateurs et mots de passe
#-----------------------------------------------------------------------------------

clear
echo "${COLOR_GREEN}*${COLOR_RESET} Création des utilisateurs"
echo ""
IS_USERNAME_VALID=0
while  [ $IS_USERNAME_VALID = 0 ]; do
	read -p "${COLOR_WHITE}Nom de l'utilisateur que vous voulez créer : ${COLOR_RESET}" USERNAME
	test_if_username_is_valid
	if [ $IS_USERNAME_VALID = 0 ]; then
		echo "${COLOR_RED}*${COLOR_RESET} Désolé, \"${COLOR_WHITE}${USERNAME}${COLOR_RESET}\" est invalide. Veuillez recommencer."
	fi
done

echo ""
create_passwd "${USERNAME}"
echo ""
verify_password_concordance "${USERNAME}"
USER_PASS="${ATTEMPT1}"
create_passwd "root"
verify_password_concordance "root"
ROOT_PASS="${ATTEMPT1}"
clear
#-----------------------------------------------------------------------------------

# choose your hostname
#-----------------------------------------------------------------------------------

IS_HOSTNAME_VALID=0
while  [ $IS_HOSTNAME_VALID = 0 ]; do
	read -e -p "Entrez le nom de ce système (hostname) pour l'identifier sur le réseau [${COLOR_WHITE}orchid${COLOR_RESET}] : " HOSTNAME
	HOSTNAME=${HOSTNAME:-orchid}
	test_if_hostname_is_valid
	if [ $IS_HOSTNAME_VALID = 0 ]; then
		echo "${COLOR_RED}*${COLOR_RESET} Désolé, \"${COLOR_WHITE}${HOSTNAME}${COLOR_RESET}\" est invalide. Veuillez recommencer."
	fi
done

#-----------------------------------------------------------------------------------

# Option pour la configuration d'esync (limits)
#-----------------------------------------------------------------------------------

if [ "$no_archive" = "1" -o "$no_archive" = "4" -o "$no_archive" = "5" ]; then
	ESYNC_SUPPORT="o"
elif [ "$no_archive" = "0" -o "$no_archive" = "2" -o "$no_archive" = "3" ]; then
	ESYNC_SUPPORT=$(ask_yes_or_no_and_validate "Voulez-vous configurer votre installation avec esync qui améliore les performances de certains jeux ? ${COLOR_WHITE}[${COLOR_GREEN}o${COLOR_WHITE}/n]${COLOR_RESET} " o)
fi

# Option pour la mise à jour d'Orchid Linux dans l'installateur
#-----------------------------------------------------------------------------------
UPDATE_ORCHID=$(ask_yes_or_no_and_validate "Voulez-vous mettre à jour votre Orchid Linux durant cette installation (cela peut être très long) ? ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET} " n)

# Summary
#-----------------------------------------------------------------------------------

clear
echo "${COLOR_WHITE}Résumé de l'installation :${COLOR_RESET}"
echo ""
echo "[${COLOR_GREEN}OK${COLOR_RESET}] Test de la connection internet."
echo "[${COLOR_GREEN}OK${COLOR_RESET}] Version d'Orchid Linux choisie : ${COLOR_GREEN}${ORCHID_VERSION[$no_archive]}${COLOR_RESET}."
echo "[${COLOR_GREEN}OK${COLOR_RESET}] Passage du clavier en ${COLOR_GREEN}(fr)${COLOR_RESET}."
echo "[${COLOR_GREEN}OK${COLOR_RESET}] Orchid Linux va s'installer sur ${COLOR_GREEN}${CHOOSEN_DISK} : ${CHOOSEN_DISK_LABEL}${COLOR_RESET}"

if [ "$HIBERNATION" = o ]; then
	echo "[${COLOR_GREEN}OK${COLOR_RESET}] Vous pourrez utiliser l'${COLOR_GREEN}hibernation${COLOR_RESET} (votre RAM a une taille de ${RAM_SIZE_GB} Go, votre SWAP sera de ${COLOR_GREEN}${SWAP_SIZE_GB} Go${COLOR_RESET})."
elif [ "$HIBERNATION" = n ]; then
	echo "[${COLOR_GREEN}OK${COLOR_RESET}] Votre RAM a une taille de ${RAM_SIZE_GB} Go, votre SWAP sera de ${COLOR_GREEN}${SWAP_SIZE_GB} Go${COLOR_RESET}. (pas d'hibernation possible)"
fi

echo "[${COLOR_GREEN}OK${COLOR_RESET}] Les pilotes graphiques suivants vont être installés : ${COLOR_GREEN}${SELECTED_GPU_DRIVERS_TO_INSTALL}${COLOR_RESET}"
echo "[${COLOR_GREEN}OK${COLOR_RESET}] En plus de l'administrateur root, l'utilisateur suivant va être créé : ${COLOR_GREEN}${USERNAME}${COLOR_RESET}"
echo "[${COLOR_GREEN}OK${COLOR_RESET}] Sur le réseau, ce système aura pour nom ${COLOR_GREEN}${HOSTNAME}${COLOR_RESET}."
if [ "$ESYNC_SUPPORT" = o ]; then
	echo "[${COLOR_GREEN}OK${COLOR_RESET}] La configuration ${COLOR_GREEN}esync${COLOR_RESET} qui améliore les performances de certains jeux sera faite sur votre Orchid Linux pour ${COLOR_GREEN}${USERNAME}${COLOR_RESET}."
fi

if [ "$UPDATE_ORCHID" = o ]; then
	echo "[${COLOR_GREEN}OK${COLOR_RESET}] Orchid Linux sera ${COLOR_GREEN}mise à jour${COLOR_RESET} durant cette installation. Cela peut être très long."
fi

echo ""
echo "Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour commencer l'installation sur le disque, ${COLOR_WHITE}ou toute autre touche${COLOR_RESET} pour quitter l'installateur."
read -s -n 1 key	# -s: do not echo input character. -n 1: read only 1 character (separate with space)
if [[ ! $key = "" ]]; then	# Input is not the [Enter] key, aborting installation!
	echo "${COLOR_YELLOW}Installation d'Orchid Linux annulée. Vos disques n'ont pas été écrits. Nous espérons vous revoir bientôt !${COLOR_RESET}"
	exit
fi
#-----------------------------------------------------------------------------------
                                                        # Questions de configuration
#===================================================================================

# Installation du système
#===================================================================================
# NOTES : No more user input after this point!

clear
echo "${COLOR_GREEN}*${COLOR_RESET} Partitionnement du disque."
auto_partitionning_full_disk

# Montage des partitions
#-----------------------------------------------------------------------------------

echo "${COLOR_GREEN}*${COLOR_RESET} Montage des partitions :"
echo "  ${COLOR_GREEN}*${COLOR_RESET} Partition racine."
mkdir /mnt/orchid && mount "${CHOOSEN_DISK}3" /mnt/orchid
echo "  ${COLOR_GREEN}*${COLOR_RESET} Activation du SWAP."
swapon "${CHOOSEN_DISK}2"
# Pour l'EFI
if [ "$ROM" = "UEFI" ]; then
	echo "  ${COLOR_GREEN}*${COLOR_RESET} Partition EFI."
	mkdir -p /mnt/orchid/boot/EFI && mount "${CHOOSEN_DISK}1" /mnt/orchid/boot/EFI
fi

echo "${COLOR_GREEN}*${COLOR_RESET} Partitionnement terminé !"
echo "${COLOR_GREEN}*${COLOR_RESET} Configuration essentielle avant le chroot :"
cd /mnt/orchid
#-----------------------------------------------------------------------------------
# Count the number of CPU threads available on the system, to inject into /etc/portage/make.conf at a later stage
PROCESSORS=$(grep -c processor /proc/cpuinfo)

# Download & extraction of the stage4
#-----------------------------------------------------------------------------------

echo "${COLOR_GREEN}*${COLOR_RESET} Téléchargement et extraction de la version d'Orchid Linux choisie."
processed=0
FILE_TO_DECOMPRESS=${ORCHID_URL[$no_archive]}
FILE_TO_DECOMPRESS=${FILE_TO_DECOMPRESS##*/}	                                        # Just keep the file from the URL
if [ -n "${ORCHID_COUNT[$no_archive]}" ]; then
	COUNTED_BY_TREE[$no_archive]=$(wget -q -O- ${ORCHID_COUNT[$no_archive]})
fi

# tar options to extract: tar.bz2 -jxvp, tar.gz -xvz, tar -xv
echo -ne "\r    [                                                  ]"	                # This is an empty bar, i.e. 50 empty chars
if [[ "$no_archive" == "0" ]]; then
	wget -q -O- ${ORCHID_URL[$no_archive]} | tar -jxvp --xattrs 2>&1 | decompress_with_progress_bar
elif [[ "$no_archive" == "1" ]]; then
	wget -q -O- ${ORCHID_URL[$no_archive]} | tar -jxvp --xattrs 2>&1 | decompress_with_progress_bar
elif [[ "$no_archive" == "2" ]]; then
	wget -q -O- ${ORCHID_URL[$no_archive]} | tar -jxvp --xattrs 2>&1 | decompress_with_progress_bar
elif [[ "$no_archive" == "3" ]]; then
	wget -q -O- ${ORCHID_URL[$no_archive]} | tar -xvz --xattrs 2>&1 | decompress_with_progress_bar
elif [[ "$no_archive" == "4" ]]; then
	wget -q -O- ${ORCHID_URL[$no_archive]} | tar -xv --xattrs 2>&1 | decompress_with_progress_bar
elif [[ "$no_archive" == "5" ]]; then
	wget -q -O- ${ORCHID_URL[$no_archive]} | tar -jxvp --xattrs 2>&1 | decompress_with_progress_bar
fi

# Fail safe
echo -ne "\r100%[${BAR:0:50}]"
# New line
echo -ne "\r\v"
echo "${COLOR_GREEN}*${COLOR_RESET} Extraction terminée."
#-----------------------------------------------------------------------------------

# Configuration de make.conf
#-----------------------------------------------------------------------------------

sed "/MAKEOPTS/c\MAKEOPTS=\"-j${PROCESSORS}\"" /mnt/orchid/etc/portage/make.conf > tmp1.conf
sed "/VIDEO_CARDS/c\VIDEO_CARDS=\"${SELECTED_GPU_DRIVERS_TO_INSTALL}\"" tmp1.conf > tmp2.conf
cp tmp2.conf /mnt/orchid/etc/portage/make.conf
rm -f tmp1.conf && rm -f tmp2.conf
#-----------------------------------------------------------------------------------
                                                           # Installation du système
#===================================================================================

# Montage et chroot
#===================================================================================

echo "${COLOR_GREEN}*${COLOR_RESET} On monte les dossiers proc, dev, sys et run pour le chroot."
mount -t proc /proc /mnt/orchid/proc
mount --rbind /dev /mnt/orchid/dev
mount --rbind /sys /mnt/orchid/sys
mount --bind /run /mnt/orchid/run
# Téléchargement et extraction des scripts d'install pour le chroot
wget "https://github.com/wamuu-sudo/orchid/blob/ched/testing/install-chroot.tar.xz?raw=true" --output-document=install-chroot.tar.xz
tar -xvf "install-chroot.tar.xz" -C /mnt/orchid
# On rend les scripts exécutables
chmod +x /mnt/orchid/postinstall-in-chroot.sh && chmod +x /mnt/orchid/DWM-config.sh && chmod +x /mnt/orchid/GNOME-config.sh


# Lancement des scripts en fonction du système
#-----------------------------------------------------------------------------------

# Postinstall: UEFI or BIOS, /etc/fstab, hostname, create user, assign groups, grub, activate services
chroot /mnt/orchid ./postinstall-in-chroot.sh ${CHOOSEN_DISK} ${ROM} ${USERNAME} ${ESYNC_SUPPORT} ${HOSTNAME} ${ROOT_PASS} ${USER_PASS} ${UPDATE_ORCHID}
# Configuration pour DWM
# no_archive use computer convention: start at 0
if [ "$no_archive" = "0" -o "$no_archive" = "1" ]; then
	chroot /mnt/orchid ./DWM-config.sh ${USERNAME}
fi

# Configuration clavier pour GNOME
if [ "$no_archive" = "2" -o "$no_archive" = "4" ]; then
	chroot /mnt/orchid ./GNOME-config.sh ${USERNAME}
fi
#-----------------------------------------------------------------------------------
                                                                 # Montage et chroot
#===================================================================================

# Fin de l'installation
#===================================================================================

# Nétoyage
#-----------------------------------------------------------------------------------

rm -f /mnt/orchid/*.tar.bz2 && rm -f /mnt/orchid/*.tar.xz && rm -f /mnt/orchid/postinstall-in-chroot.sh
rm -f /mnt/orchid/DWM-config.sh && rm -f /mnt/orchid/GNOME-config.sh
rm -f /mnt/orchid/orchid-backgrounds.xml && rm -f /mnt/orchid/orchid-logo.png
cd /
if [ "$ROM" = "UEFI" ]; then
	umount /mnt/orchid/boot/EFI
fi
umount -f /mnt/orchid/run > /dev/null
umount -f /mnt/orchid/sys > /dev/null
umount -f /mnt/orchid/dev > /dev/null
umount -f /mnt/orchid/proc > /dev/null
umount -R /mnt/orchid
#-----------------------------------------------------------------------------------
# Finish
read -p "Installation terminée ! ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour redémarrer. Pensez bien à enlever le support d'installation. Merci de nous avoir choisi !"
# On redémarre pour démarrer sur le système fraichement installé
reboot
                                                             # Fin de l'installation
#===================================================================================

#========================================================================== MAIN ===
