#!/usr/bin/env bash
#===================================================================================
#
# FILE : softwares.sh
#
# USAGE : as user
#         ./softwares.sh
#
# DESCRIPTION : Software Manager for Orchid Linux.
#
# BUGS : ---
# NOTES : ---
# CONTRUBUTORS : Chevek, Crystal
# CREATED : may 2022
# REVISION: may 2022
#
# LICENCE :
# Copyright (C) 2022 Yannick Defais aka Chevek, Crystal
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
SOURCE_CONFIGURATION_FILE="softwares.toml"

declare -A SYSTEM_PORTAGE	# KEY = Human readable item taken from last elementin the TABLES. To print on screen in the basket.
declare -A SYSTEM_FLATHUB	# VALUE = Status in the system: "I"=installed, unset=uninstalled
declare -A SYSTEM_ORCHID

declare -A PACKAGES_PORTAGE	# KEY = Human readable item taken from last elementin the TABLES. To print on screen in the basket.
declare -A PACKAGES_FLATHUB	# VALUE = package
declare -A PACKAGES_ORCHID

declare -A ADD_PACKAGES_PORTAGE # KEY = Human readable item taken from last elementin the TABLES. To print on screen in the basket.
declare -A ADD_PACKAGES_FLATHUB	# VALUE = packages
declare -A ADD_PACKAGES_ORCHID

declare -A REMOVE_PACKAGES_PORTAGE	# List of packages to delete (format for orchid-delete), same format as ADD
declare -A REMOVE_PACKAGES_FLATHUB
declare -A REMOVE_PACKAGES_ORCHID

declare -A PACKAGES_FORMAT

declare -A packages_orchid
declare -A packages_flathub
declare -A packages

declare -A TABLES
declare -A TABLES_PAGE
declare -A TERM_COLORS

REGEXP_TABLE="^[^=]*\[(.*?)\]$"
REGEXP_KEY_VALUE='([A-Za-z0-9_-]+)[[:space:]]*=[[:space:]]*\"(.*?)\"'

SOFTWARES_CACHE="$HOME/.config/orchid/orchid-softwares-cache.sh"
#===================================================================================
# Setting Color Variables
Color_Off=$'\033[0m'       # Text Reset

# Regular Colors
TERM_COLORS[Black]=$'\033[0;30m'        # Black
TERM_COLORS[Red]=$'\033[0;31m'          # Red
TERM_COLORS[Green]=$'\033[0;32m'        # Green
TERM_COLORS[Yellow]=$'\033[0;33m'       # Yellow
TERM_COLORS[Blue]=$'\033[0;34m'         # Blue
TERM_COLORS[Purple]=$'\033[0;35m'       # Purple
TERM_COLORS[Cyan]=$'\033[0;36m'         # Cyan
TERM_COLORS[White]=$'\033[0;37m'        # White

# Bold
TERM_COLORS[BBlack]=$'\033[1;30m'       # Black
TERM_COLORS[BRed]=$'\033[1;31m'         # Red
TERM_COLORS[BGreen]=$'\033[1;32m'       # Green
TERM_COLORS[BYellow]=$'\033[1;33m'      # Yellow
TERM_COLORS[BBlue]=$'\033[1;34m'        # Blue
TERM_COLORS[BPurple]=$'\033[1;35m'      # Purple
TERM_COLORS[BCyan]=$'\033[1;36m'        # Cyan
TERM_COLORS[BWhite]=$'\033[1;37m'       # White

# Underline
TERM_COLORS[UBlack]=$'\033[4;30m'       # Black
TERM_COLORS[URed]=$'\033[4;31m'         # Red
TERM_COLORS[UGreen]=$'\033[4;32m'       # Green
TERM_COLORS[UYellow]=$'\033[4;33m'      # Yellow
TERM_COLORS[UBlue]=$'\033[4;34m'        # Blue
TERM_COLORS[UPurple]=$'\033[4;35m'      # Purple
TERM_COLORS[UCyan]=$'\033[4;36m'        # Cyan
TERM_COLORS[UWhite]=$'\033[4;37m'       # White

# Background
TERM_COLORS[On_Black]=$'\033[40m'       # Black
TERM_COLORS[On_Red]=$'\033[41m'         # Red
TERM_COLORS[On_Green]=$'\033[42m'       # Green
TERM_COLORS[On_Yellow]=$'\033[43m'      # Yellow
TERM_COLORS[On_Blue]=$'\033[44m'        # Blue
TERM_COLORS[On_Purple]=$'\033[45m'      # Purple
TERM_COLORS[On_Cyan]=$'\033[46m'        # Cyan
TERM_COLORS[On_White]=$'\033[47m'       # White

# High Intensity
TERM_COLORS[IBlack]=$'\033[0;90m'       # Black
TERM_COLORS[IRed]=$'\033[0;91m'         # Red
TERM_COLORS[IGreen]=$'\033[0;92m'       # Green
TERM_COLORS[IYellow]=$'\033[0;93m'      # Yellow
TERM_COLORS[IBlue]=$'\033[0;94m'        # Blue
TERM_COLORS[IPurple]=$'\033[0;95m'      # Purple
TERM_COLORS[ICyan]=$'\033[0;96m'        # Cyan
TERM_COLORS[IWhite]=$'\033[0;97m'       # White

# Bold High Intensity
TERM_COLORS[BIBlack]=$'\033[1;90m'      # Black
TERM_COLORS[BIRed]=$'\033[1;91m'        # Red
TERM_COLORS[BIGreen]=$'\033[1;92m'      # Green
TERM_COLORS[BIYellow]=$'\033[1;93m'     # Yellow
TERM_COLORS[BIBlue]=$'\033[1;94m'       # Blue
TERM_COLORS[BIPurple]=$'\033[1;95m'     # Purple
TERM_COLORS[BICyan]=$'\033[1;96m'       # Cyan
TERM_COLORS[BIWhite]=$'\033[1;97m'      # White

# High Intensity backgrounds
TERM_COLORS[On_IBlack]=$'\033[0;100m'   # Black
TERM_COLORS[On_IRed]=$'\033[0;101m'     # Red
TERM_COLORS[On_IGreen]=$'\033[0;102m'   # Green
TERM_COLORS[On_IYellow]=$'\033[0;103m'  # Yellow
TERM_COLORS[On_IBlue]=$'\033[0;104m'    # Blue
TERM_COLORS[On_IPurple]=$'\033[0;105m'  # Purple
TERM_COLORS[On_ICyan]=$'\033[0;106m'    # Cyan
TERM_COLORS[On_IWhite]=$'\033[0;107m'   # White

# Text formating 
TEXT_REV="$(tput rev)"
TEXT_DEFAULT="$(tput sgr0)"
#-----------------------------------------------------------------------------------
#cp -rf Script_files/* ~/Desktop/

# Setup functions
#===================================================================================

Install_n_remove_packages()
{
clear
echo_center "Veuillez entrer votre mot de passe ${TERM_COLORS[Green]}root${Color_Off} : " 
tput cup $((${CURSOR_POSITION[1]} - 1)) $((${CURSOR_POSITION[2]} - 1))
read -s PASSWRD
clear
echo_center "${TERM_COLORS[On_Red]}Si l'opération vous semble bloquée, il n'en est rien.
Allez prendre un café, un thé, une vodka ou un verre de vin et ne paniquez pas.${Color_Off}"
echo ""
echo ""
echo -ne "Démarrage dans "
for (( m=5; m>0; m-- ))
do
   echo -ne "${m}... "
   sleep 1
done
echo ""
# delete flatpaks, if any
if [ "${#REMOVE_PACKAGES_FLATHUB[*]}" -ge 1 ]; then
	echo "[${TERM_COLORS[Green]}*${Color_Off}] Suppression des paquets flatpak..."
	flatpak uninstall --assumeyes --noninteractive ${REMOVE_PACKAGES_FLATHUB[*]}
	for nom_de_paquet in "${!REMOVE_PACKAGES_FLATHUB[@]}"; do
		# remove symbolic links (lower case)
		{ sleep 2; echo "$PASSWRD"; } | script -q -c "su -c 'rm -f /usr/bin/${nom_de_paquet,,}'"
	done
fi

# delete ebuild, if any
if [ "${#REMOVE_PACKAGES_PORTAGE[*]}" -ge 1 ]; then
	echo "[${TERM_COLORS[Green]}*${Color_Off}] Suppression des paquets ebuild..."
	{ sleep 2; echo "$PASSWRD"; } | script -q -c "su -c 'emerge -C --ask=n ${REMOVE_PACKAGES_PORTAGE[*]} && emerge --depclean'"
fi

# install flatpaks, if any
if [ "${#ADD_PACKAGES_FLATHUB[*]}" -ge 1 ]; then
	echo "[${TERM_COLORS[Green]}*${Color_Off}] Installation des paquets flatpak..."
	flatpak install --assumeyes --noninteractive --system ${ADD_PACKAGES_FLATHUB[*]}
	for nom_de_paquet in "${!ADD_PACKAGES_FLATHUB[@]}"; do
		# Add symbolic links, all in lower case
		{ sleep 2; echo "$PASSWRD"; } | script -q -c "su -c 'ln -s /var/lib/flatpak/exports/bin/${ADD_PACKAGES_FLATHUB[$nom_de_paquet]} /usr/bin/${nom_de_paquet,,}'"
	done
fi

# install ebuild, if any
if [ "${#ADD_PACKAGES_PORTAGE[*]}" -ge 1 ]; then
	echo "[${TERM_COLORS[Green]}*${Color_Off}] Installation des paquets ebuild..."
	{ sleep 2; echo "$PASSWRD"; } | script -q -c "su -c 'emerge -qv --autounmask-write --autounmask=y --ask=n ${ADD_PACKAGES_PORTAGE[*]}'"
fi

unset REMOVE_PACKAGES_FLATHUB
unset ADD_PACKAGES_FLATHUB
unset REMOVE_PACKAGES_PORTAGE
unset ADD_PACKAGES_PORTAGE
echo "${TERM_COLORS[IGreen]}Opération terminée.${Color_Off}"
exit
}


fetch_cursor_position() {
  local pos

  IFS='[;' read -p $'\e[6n' -d R -a pos -rs || echo "failed with error: $? ; ${pos[*]}"
  CURSOR_POSITION[1]=${pos[1]}
  CURSOR_POSITION[2]=${pos[2]}
}


echo_center()
{
TEXT_SIZE=0
COUNT_TEXT_LINES=0
while IFS= read -r TEXT; do
	for l in "${TEXT[@]}"; do
	((COUNT_TEXT_LINES++))
	done
done <<< "${1}"

TEXT_LINE_START=$(( (${TERM_LINES} - ${COUNT_TEXT_LINES}) / 2 ))
while IFS= read -r TEXT; do
	for l in "${TEXT[@]}"; do
		TEXT_ONLY=$(echo -e "$l" | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g')
		TEXT_STEPS_COL_CENTER=$(( ($TERM_COLS - ${#TEXT_ONLY}) / 2 ))
		tput cup $TEXT_LINE_START $TEXT_STEPS_COL_CENTER
		echo -ne "${l}"
		((TEXT_LINE_START++))
	done
done <<< "${1}"
fetch_cursor_position
}

basket()
{
    echo -e "Votre panier (Installation = $((${#ADD_PACKAGES_PORTAGE[@]} + ${#ADD_PACKAGES_FLATHUB[@]})), Supression = $((${#REMOVE_PACKAGES_PORTAGE[@]} + ${#REMOVE_PACKAGES_FLATHUB[@]}))) :\n  Installation = ${!ADD_PACKAGES_PORTAGE[*]} ${!ADD_PACKAGES_FLATHUB[*]}\n  Suppression = ${!REMOVE_PACKAGES_PORTAGE[*]} ${!REMOVE_PACKAGES_FLATHUB[*]}"
}

unset_all_keys()
{
unset DESCRIPTION
unset DESCRIPTION_COLOR
#unset COLOR_ITEMS
unset PORTAGE
unset FLATHUB
unset ORCHID
#unset FOOT_NOTE
#unset FOOT_NOTE_COLOR
}

print_description()
{
# let's print all the datas we collected!
if [[ -v DESCRIPTION_COLOR ]]; then	# test if variable is present
	IFS=' ' read -ra SPLITTED_COLORS <<< "${DESCRIPTION_COLOR}"
	echo -ne "${TERM_COLORS[${SPLITTED_COLORS[0]}]}"	# FIXME: implement multicolor with a function using case and echo -e
fi
if [[ -v DESCRIPTION ]]; then	# test if variable is present
	echo -ne "${DESCRIPTION}${Color_Off}\n"	# a choice
fi
}

package_status()
{
unset PACKAGE_STATUS
if [ -v SYSTEM_PORTAGE[${CURRENT_ITEM}] ]; then
	if [ -v REMOVE_PACKAGES_PORTAGE[${CURRENT_ITEM}] ]; then
		PACKAGE_STATUS="[${TEXT_REV}S${TEXT_DEFAULT}${PRINT_COLOR}]"
	else
		PACKAGE_STATUS="[I]"
	fi

fi

if [ -v ADD_PACKAGES_PORTAGE[${CURRENT_ITEM}] ]; then
	PACKAGE_STATUS="[${TEXT_REV}I${TEXT_DEFAULT}${PRINT_COLOR}]"
fi

if [ -v SYSTEM_FLATHUB[${CURRENT_ITEM}] ]; then
	if [ -v REMOVE_PACKAGES_FLATHUB[${CURRENT_ITEM}] ]; then
		PACKAGE_STATUS="[${TEXT_REV}S${TEXT_DEFAULT}${PRINT_COLOR}]"
	else
		PACKAGE_STATUS="[I]"
	fi
fi

if [ -v ADD_PACKAGES_FLATHUB[${CURRENT_ITEM}] ]; then
	PACKAGE_STATUS="[${TEXT_REV}I${TEXT_DEFAULT}${PRINT_COLOR}]"
fi

if ! [ -v PACKAGE_STATUS ]; then
	PACKAGE_STATUS="[ ]"
fi
}

print_choice()
{
# let's print all the datas we collected!
if [[ -v DESCRIPTION_COLOR ]]; then	# test if variable is present
	IFS=' ' read -ra SPLITTED_COLORS <<< "${DESCRIPTION_COLOR}"
	PRINT_COLOR="${TERM_COLORS[${SPLITTED_COLORS[0]}]}"	# FIXME: implement multicolor with a function using case and echo -e
elif [[ -v COLOR_ITEMS ]];then
	PRINT_COLOR="${TERM_COLORS[${COLOR_ITEMS}]}"
else
	PRINT_COLOR=""
fi
if [[ -v DESCRIPTION ]]; then	# test if variable is present
	if [[ "${CONFIGURATION[$j]}" =~ ${REGEXP_TABLE} ]]; then
		COUNT_CHOICES+=(${BASH_REMATCH[1]})
		unset PACKAGE_STATUS
		if [ -v PORTAGE ] || [ -v FLATHUB ]; then
			package_status
		fi
		if [[ -v PACKAGES_PORTAGE[${CURRENT_ITEM}] && -v PACKAGES_FLATHUB[${CURRENT_ITEM}] ]]; then
			FORMATS="(ebuild & Flatpak)"
		elif [[ -v PACKAGES_PORTAGE[${CURRENT_ITEM}] && ! -v PACKAGES_FLATHUB[${CURRENT_ITEM}] ]]; then
			FORMATS="(ebuild)"
		elif [[ ! -v PACKAGES_PORTAGE[${CURRENT_ITEM}] && -v PACKAGES_FLATHUB[${CURRENT_ITEM}] ]]; then
			FORMATS="(Flatpak)"
		fi
		echo -ne "${PRINT_COLOR}${PACKAGE_STATUS}${PRINT_COLOR} ${#COUNT_CHOICES[@]}. ${DESCRIPTION} ${FORMATS}${Color_Off}\n"	# a choice
		unset FORMATS
	else
		echo "FATAL ERROR!"
	fi
fi
}


read_key_value()
{
if [[ "${CONFIGURATION[$POINTER]}" =~ ${REGEXP_KEY_VALUE} ]]; then # we found a key = "value"
	KEY=${BASH_REMATCH[1]}
	VALUE=${BASH_REMATCH[2]}
	if [[ "$KEY" == "description" ]]; then
		DESCRIPTION=$VALUE
	fi
	if [[ "$KEY" == "description_color" ]]; then
		DESCRIPTION_COLOR=$VALUE
	fi
	if [[ "$KEY" == "color_items" ]]; then
		COLOR_ITEMS=$VALUE
	fi
	CURRENT_ITEM=${CONFIGURATION[${j}]##*.}
	CURRENT_ITEM=${CURRENT_ITEM%]}
	if [[ "$KEY" == "portage" ]]; then
		PORTAGE=$VALUE
		PACKAGES_PORTAGE+=([${CURRENT_ITEM}]="$VALUE")
		ls -d /var/db/pkg/${PORTAGE}* &> /dev/null	# Test if this package is installed
		if [ $? -eq 0 ]; then
		 SYSTEM_PORTAGE+=([${CURRENT_ITEM}]="I")
		fi
	fi
	if [[ "$KEY" == "flathub" ]]; then
		FLATHUB=$VALUE
		PACKAGES_FLATHUB+=([${CURRENT_ITEM}]="$VALUE")
		ls -d /var/lib/flatpak/app/${FLATHUB} &> /dev/null
		if [ $? -eq 0 ]; then
			SYSTEM_FLATHUB+=([${CURRENT_ITEM}]="I")
		fi
		ls -d $HOME/.local/share/flatpak/app/${FLATHUB} &> /dev/null
		if [ $? -eq 0 ]; then
			SYSTEM_FLATHUB+=([${CURRENT_ITEM}]="I")
		fi
		ls -d /var/lib/flatpak/runtime/${FLATHUB} &> /dev/null
		if [ $? -eq 0 ]; then
			SYSTEM_FLATHUB+=([${CURRENT_ITEM}]="I")
		fi
		
	fi
	if [[ "$KEY" == "orchid" ]]; then
		ORCHID=$VALUE
		PACKAGES_ORCHID+=([${CURRENT_ITEM}]="$VALUE")
	fi
	if [[ "$KEY" == "foot_note" ]]; then
		FOOT_NOTE=$VALUE
	fi
	if [[ "$KEY" == "foot_note_color" ]]; then
		FOOT_NOTE_COLOR=$VALUE
	fi
fi
}

selector()
{
# Read the array stuffed into the array
FIRST=0
IFS=',' read -ra LINES_EXPENDED <<< ${TABLES_PAGE[${LEVEL_TO_DISPLAY}]}
for j in "${LINES_EXPENDED[@]}"
do
	POINTER=$(($j + 1))
	until [[ "${CONFIGURATION[$POINTER]}" =~ ${REGEXP_TABLE} || ${POINTER} -gt ${#CONFIGURATION[@]} ]]; do	# Let's find the next TABLE in the configuration file, OR reach EndOfFile
		read_key_value
		((POINTER++))
	done
	NEXT_TABLE="${BASH_REMATCH[1]}"
	if ! [[ "$POINTER" -gt ${#CONFIGURATION[@]} ]]; then	# We did not reach End Of File
		IFS='.' read -ra SPLITTED_NEXT_TABLE <<< "${NEXT_TABLE}" # split the table name to count how many levels it has
		IFS='.' read -ra SPLITTED_CURRENT_TABLE <<< "${CONFIGURATION[$j]}" # split the table name to count how many levels it has
		if [[ "${NEXT_TABLE}" == *".page" || ${#SPLITTED_CURRENT_TABLE[@]} -ge ${#SPLITTED_NEXT_TABLE[@]} ]] && [[ $FIRST == 1 ]]; then	# If the next TABLE is a .page, or the TABLE is greater or equal than the next TABLE
			# This is a valid choice to make
			print_choice
			unset_all_keys
		else	# this is just a description to print
			print_description
			if [[ $FIRST = 0 ]]; then
				echo ""
				BACK_APPLY_COLOR=$DESCRIPTION_COLOR
			fi
			FIRST=1
			unset_all_keys
		fi
	else	# We reached end of configuration file ; the very last TABLE in the configuraiton file HAS TO BE a choice
		print_choice
		unset_all_keys
	fi	
done
APPLY=$((${#COUNT_CHOICES[@]} + 1))
RETURN_EXIT=$((${#COUNT_CHOICES[@]} + 2))
echo ""
if [[ -n "$BACK_APPLY_COLOR" ]]; then	# test if non empty
	IFS=' ' read -ra SPLITTED_COLORS <<< "${BACK_APPLY_COLOR}"
	echo -ne "${TERM_COLORS[${SPLITTED_COLORS[0]}]}"	# FIXME: implement multicolor with a function using case and echo -e
fi
echo -ne "${APPLY}. Appliquer tous les choix et quitter.\n"
IFS='.' read -ra SPLITTED <<< "$LEVEL_TO_DISPLAY"
if [[ ${#SPLITTED[@]} -eq 2 ]]; then	# Test if we are at root in the TABLE hierarchy
	MSG_BACK="Sortie."
else
	MSG_BACK="Retour en arrière."
fi
echo -ne "${RETURN_EXIT}. ${MSG_BACK}${Color_Off}\n"
unset COLOR_ITEMS

if [[ -n "$FOOT_NOTE" ]]; then	# test if non empty
	if [[ -n "$FOOT_NOTE_COLOR" ]]; then	# test if non empty
		IFS=' ' read -ra SPLITTED_COLORS <<< "${FOOT_NOTE_COLOR}"
	fi
	echo -ne "${TERM_COLORS[${SPLITTED_COLORS[0]}]}${FOOT_NOTE}${Color_Off}\n"	# FIXME: implement multicolor with a function using case and echo -e
	unset FOOT_NOTE
	unset FOOT_NOTE_COLOR
fi
echo ""
basket
echo "$ERROR_IN_SELECTOR"
}


Select_ebuild_or_flatpak()
{
clear
# SPACES ARE IMPORTANT BELOW to center the text!!!
TEXT_SELECT_PACKAGE="Choisissez le format de packet
que vous voulez pour ${TERM_COLORS[Green]}${CURRENT_ITEM}${Color_Off} :

1. ebuild de Gentoo      
2. Flatpak de flathub.org

Saisissez votre choix :  "
while echo_center "$TEXT_SELECT_PACKAGE" && tput cup $((${CURSOR_POSITION[1]} - 1)) $((${CURSOR_POSITION[2]} - 2)) && read -rp "" NUM_PACK && [[ -v NUM_PACK ]]; do
	clear
	if [[ "$NUM_PACK" == *[[:digit:]]* && $NUM_PACK -ge 1 && $NUM_PACK -le 2 ]]; then

		if [[ $NUM_PACK -eq 1 ]]; then	# ebuild
			if [[ ! -v SYSTEM_PORTAGE[${CURRENT_ITEM}] ]]; then # If not already installed
				ADD_PACKAGES_PORTAGE+=([${CURRENT_ITEM}]="${PACKAGES_PORTAGE[${CURRENT_ITEM}]}")
				if [[ -v SYSTEM_FLATHUB[${CURRENT_ITEM}] && ! -v REMOVE_PACKAGES_FLATHUB[${CURRENT_ITEM}] ]]; then # We switch package format
					REMOVE_PACKAGES_FLATHUB+=([${CURRENT_ITEM}]="${PACKAGES_FLATHUB[${CURRENT_ITEM}]}")[${CURRENT_ITEM}]	# in case user want to change installed package format
				fi
			elif [[ ! -v REMOVE_PACKAGES_PORTAGE[${CURRENT_ITEM}] ]]; then # flatpak is installed
				REMOVE_PACKAGES_PORTAGE+=([${CURRENT_ITEM}]="${PACKAGES_PORTAGE[${CURRENT_ITEM}]}")[${CURRENT_ITEM}]	# in case user want to change installed package format
			else
				unset REMOVE_PACKAGES_PORTAGE[${CURRENT_ITEM}]
			fi
		fi

		if [[ $NUM_PACK -eq 2 ]]; then	# flatpak
			if [[ ! -v SYSTEM_FLATHUB[${CURRENT_ITEM}] ]]; then # If not already installed
				ADD_PACKAGES_FLATHUB+=([${CURRENT_ITEM}]="${PACKAGES_FLATHUB[${CURRENT_ITEM}]}")
				if [[ -v SYSTEM_PORTAGE[${CURRENT_ITEM}] && ! -v REMOVE_PACKAGES_PORTAGE[${CURRENT_ITEM}] ]]; then # We switch package format
					REMOVE_PACKAGES_PORTAGE+=([${CURRENT_ITEM}]="${PACKAGES_PORTAGE[${CURRENT_ITEM}]}")[${CURRENT_ITEM}]	# in case user want to change installed package format
				fi
			elif [[ ! -v REMOVE_PACKAGES_FLATHUB[${CURRENT_ITEM}] ]]; then # flatpak is installed
				REMOVE_PACKAGES_FLATHUB+=([${CURRENT_ITEM}]="${PACKAGES_FLATHUB[${CURRENT_ITEM}]}")[${CURRENT_ITEM}]	# in case user want to change installed package format
			else
				unset REMOVE_PACKAGES_FLATHUB[${CURRENT_ITEM}]
			fi
		fi

		break
	fi
done
}

set_term_size()
{
TERM_LINES=$(tput lines)
TERM_COLS=$(tput cols)

return 0
}

############################################################
# Script start here

TERM_LINES=$(tput lines)
TERM_COLS=$(tput cols)

trap set_term_size WINCH	# We trap window changing size to adapt our interface

clear
echo "Initialisation d'Orchid Software..."
mkdir -p $HOME/.config/orchid

if [ -f "$SOFTWARES_CACHE" ]; then
	CONFIGURATION_VERSION=$(date -r ${SOURCE_CONFIGURATION_FILE})
	CACHED_CONFIGURATION_VERSION="$(sed "2q;d" ${SOFTWARES_CACHE})"
	if [[ "${CACHED_CONFIGURATION_VERSION}" =~ =\"(.*?)\" ]]; then
		CACHED_CONFIGURATION_VERSION="${BASH_REMATCH[1]}"
	else
		echo "FATAL ERROR"
		exit
	fi
fi

if [ -f "$SOFTWARES_CACHE" ] && [ "${CONFIGURATION_VERSION}" == "${CACHED_CONFIGURATION_VERSION}" ]; then	# Do we have a cache ?
	source -- "$SOFTWARES_CACHE"
else
	CONFIGURATION_FILE=$(<${SOURCE_CONFIGURATION_FILE})
	# Clean the configuration file -> indexed array $CONFIGURATION[] will contain the cleared configuration, indexed array $TABLES[] will contain only table lines
	i=0	# count configuration file line number
	while IFS= read -r line
	do
		line=$(echo "$line" | sed 's/^[ \t]*//') #remove all tabs or spaces in the beginning
		line=$(echo "$line" | sed 's/#[^\"]*$//') #remove trailing comment, if there is not any "
		line=$(echo "$line" | sed 's/[ \t]*$//') #remove all tabs or spaces in the trailling
		# Does this line do not start with a # and is not empty/spaces only
		if [[ ! "$line" == "#"* && ! -z "${line// }" ]]; then
			CONFIGURATION+=("$line")	# $CONFIGURATION[] is our clean version of the config file, in an associative array, each meaningful line of the configuration file in each array entry, ordered.
			if [[ "$line" =~ ${REGEXP_TABLE} ]]; then	# We found a table, that is not in a line containing = before it
				TABLES+=(["${BASH_REMATCH[1]}"]="${i}")	# Build associative array of [tables]=line number pointing in $CONFIGURATION[]. This is an helper to faster process the configuration.
				IFS='.' read -ra SPLITTED <<< "${BASH_REMATCH[1]}" # split the table name to count how many levels it has
				if [[ "${BASH_REMATCH[1]}" == *".page" ]]; then	# This is a new page for our selector!
					TABLES_PAGE+=([${BASH_REMATCH[1]}]="${i}")
					if [[ ${#SPLITTED[@]} -eq 2 ]]; then		#Starting point to display on screen in the level of the table hierarchy. We start at level 2
						LEVEL_TO_DISPLAY=${BASH_REMATCH[1]}
					fi
				else	# This is a node we need to attach to some page
					if [[ ${#SPLITTED[@]} -gt 1 ]]; then		# our pages building do not apply to the root of the document
						NODE=${BASH_REMATCH[1]}
						until [ ${TABLES_PAGE["${NODE%.*}.page"]+abc} ]; do	# test if this key value exist in the associative array
							NODE=${NODE%.*}	# strip the node from its last element
						done
						TABLES_PAGE["${NODE%.*}.page"]="${TABLES_PAGE["${NODE%.*}.page"]},${i}"	# we are building an array of array here! In the later, values are separated by comma
					fi
				fi
			fi
			((i++))
		fi
	done <<< "$CONFIGURATION_FILE"
	echo "# This is a cache file for the orchid-softwares command" > "$SOFTWARES_CACHE"	# This is the creation of the cache file
	CONFIGURATION_VERSION=$(date -r ${SOURCE_CONFIGURATION_FILE})
	declare -p CONFIGURATION_VERSION >> "$SOFTWARES_CACHE"
	declare -p CONFIGURATION >> "$SOFTWARES_CACHE"
	declare -p TABLES >> "$SOFTWARES_CACHE"
	declare -p LEVEL_TO_DISPLAY >> "$SOFTWARES_CACHE"
	declare -p TABLES_PAGE >> "$SOFTWARES_CACHE"
fi
clear
#read root to first level to display: welcome message
i=0
while :; do	# Welcome message
if [[ "${CONFIGURATION[$i]}" =~ ^[^=]*\[.*?\] ]] && [[ -v DESCRIPTION_COLOR || -v DESCRIPTION ]]; then	# Found a table
		IFS=' ' read -ra SPLITTED_COLORS <<< "${DESCRIPTION_COLOR}"
		echo -ne "${TERM_COLORS[${SPLITTED_COLORS[0]}]}${DESCRIPTION}${Color_Off}\n"	# implement with a function using case and echo -e
		break	# We print just the welcome message, then break this loop
fi
	
if [[ "${CONFIGURATION[$i]}" =~ ([A-Za-z0-9_-]+)[[:space:]]*=[[:space:]]*\"(.*?)\" ]]; then # we fournd a key = "value"
	KEY=${BASH_REMATCH[1]}
	VALUE=${BASH_REMATCH[2]}
	if [[ "$KEY" == "description" ]]; then
		DESCRIPTION=$VALUE
	fi
	if [[ "$KEY" == "description_color" ]]; then
		DESCRIPTION_COLOR=$VALUE
	fi
fi
((i++))
done

i=${TABLES[$LEVEL_TO_DISPLAY]}
IFS='.' read -ra SPLITTED_TO_DISPLAY <<< "${LEVEL_TO_DISPLAY}"
while selector && read -rp "Saisissez votre choix : " NUM && [[ -v NUM ]]; do
	if [[ "$NUM" == *[[:digit:]]* && $NUM -ge 1 && $NUM -le $((${#COUNT_CHOICES[@]}+2)) ]]; then
		if [[ $NUM -le ${#COUNT_CHOICES[@]} ]]; then
			((NUM--))
			CURRENT_ITEM=${COUNT_CHOICES[$NUM]##*.}
			if [[ ( -v SYSTEM_PORTAGE[${CURRENT_ITEM}] && -v PACKAGES_PORTAGE[${CURRENT_ITEM}] ) || ( -v SYSTEM_FLATHUB[${CURRENT_ITEM}] && -v PACKAGES_FLATHUB[${CURRENT_ITEM}] ) ]]; then	# is installed
				# the package is installed, user asked to delete it and now user ask to install but there is both ebuild and flatpak:
				if [[ ( -v PACKAGES_PORTAGE[${CURRENT_ITEM}] && -v PACKAGES_FLATHUB[${CURRENT_ITEM}] ) && ( -v REMOVE_PACKAGES_PORTAGE[${CURRENT_ITEM}] || -v REMOVE_PACKAGES_FLATHUB[${CURRENT_ITEM}] ) && ( ! -v ADD_PACKAGES_PORTAGE[${CURRENT_ITEM}] && ! -v ADD_PACKAGES_FLATHUB[${CURRENT_ITEM}] )  ]]; then	# is installed, can be installed in both ebuild & flatpak, is flaged to remove
					Select_ebuild_or_flatpak
				elif [[ ( -v PACKAGES_PORTAGE[${CURRENT_ITEM}] && -v PACKAGES_FLATHUB[${CURRENT_ITEM}] ) && ( -v ADD_PACKAGES_PORTAGE[${CURRENT_ITEM}] || -v ADD_PACKAGES_FLATHUB[${CURRENT_ITEM}] ) ]]; then	# is installed, can be installed in both ebuild & flatpak, is flaged to add
					unset ADD_PACKAGES_PORTAGE[${CURRENT_ITEM}]
					unset ADD_PACKAGES_FLATHUB[${CURRENT_ITEM}]
					unset REMOVE_PACKAGES_PORTAGE[${CURRENT_ITEM}]
					unset REMOVE_PACKAGES_FLATHUB[${CURRENT_ITEM}]
				elif [[ -v SYSTEM_PORTAGE[${CURRENT_ITEM}] ]]; then
					if [[ -v REMOVE_PACKAGES_PORTAGE[${CURRENT_ITEM}] ]]; then
						unset REMOVE_PACKAGES_PORTAGE[${CURRENT_ITEM}]
					else
						REMOVE_PACKAGES_PORTAGE+=([${CURRENT_ITEM}]="${PACKAGES_PORTAGE[${CURRENT_ITEM}]}")
					fi
				elif [[ -v SYSTEM_FLATHUB[${CURRENT_ITEM}] ]]; then
					if [[ -v REMOVE_PACKAGES_FLATHUB[${CURRENT_ITEM}] ]]; then
						unset REMOVE_PACKAGES_FLATHUB[${CURRENT_ITEM}]
					else
						REMOVE_PACKAGES_FLATHUB+=([${CURRENT_ITEM}]="${PACKAGES_FLATHUB[${CURRENT_ITEM}]}")
					fi
				fi
				
			elif [[ -v PACKAGES_PORTAGE[${CURRENT_ITEM}] || -v PACKAGES_FLATHUB[${CURRENT_ITEM}] ]]; then # is not installed
				# the package is not installed, user asked to install it
				if [[ -v PACKAGES_PORTAGE[${CURRENT_ITEM}] && ! -v PACKAGES_FLATHUB[${CURRENT_ITEM}] ]]; then
					# This is a portage package only
					if [[ -v ADD_PACKAGES_PORTAGE[${CURRENT_ITEM}] ]]; then
						unset ADD_PACKAGES_PORTAGE[${CURRENT_ITEM}]
					else
						ADD_PACKAGES_PORTAGE+=([${CURRENT_ITEM}]="${PACKAGES_PORTAGE[${CURRENT_ITEM}]}")
					fi
				fi
				if [[ -v PACKAGES_FLATHUB[${CURRENT_ITEM}] && ! -v PACKAGES_PORTAGE[${CURRENT_ITEM}] ]]; then
					# This is a flathub package only				
					if [[ -v ADD_PACKAGES_FLATHUB[${CURRENT_ITEM}] ]]; then
						unset ADD_PACKAGES_FLATHUB[${CURRENT_ITEM}]
					else
						ADD_PACKAGES_FLATHUB+=([${CURRENT_ITEM}]="${PACKAGES_FLATHUB[${CURRENT_ITEM}]}")
					fi
				fi
				if [[ -v PACKAGES_FLATHUB[${CURRENT_ITEM}] && -v PACKAGES_PORTAGE[${CURRENT_ITEM}] ]]; then
					if [[ -v ADD_PACKAGES_PORTAGE[${CURRENT_ITEM}] || -v ADD_PACKAGES_FLATHUB[${CURRENT_ITEM}] ]]; then
						unset ADD_PACKAGES_PORTAGE[${CURRENT_ITEM}]
						unset ADD_PACKAGES_FLATHUB[${CURRENT_ITEM}]
					else
						# This is a portage package and a flathub package available
						Select_ebuild_or_flatpak
					fi
				fi

			else
				LEVEL_TO_DISPLAY="${COUNT_CHOICES[$NUM]}.page"
				#echo "not a leaf"
			fi
		elif [[ $NUM == $((${#COUNT_CHOICES[@]}+1)) ]]; then	# Apply choices
			Install_n_remove_packages
		else	# Go back or exit
			IFS='.' read -ra SPLITTED <<< "$LEVEL_TO_DISPLAY"
				if [[ ${#SPLITTED[@]} -eq 2 ]]; then	# we are at the root already, EXIT then!
					exit
				else	# Go the previoux .page in the hierarchy
					LEVEL_TO_DISPLAY=${LEVEL_TO_DISPLAY%.*}	# strip the node from its last element: Remove the .page
					LEVEL_TO_DISPLAY=${LEVEL_TO_DISPLAY%.*}	# strip the node from its last element: Remove last element
					until [ ${TABLES_PAGE["${LEVEL_TO_DISPLAY}.page"]+abc} ]; do	# test if this key value exist in the associative array
						LEVEL_TO_DISPLAY=${LEVEL_TO_DISPLAY%.*}	# strip the node from its last element
					done
					LEVEL_TO_DISPLAY="${LEVEL_TO_DISPLAY}.page"
				fi
		fi
		ERROR_IN_SELECTOR=" "
	else
		ERROR_IN_SELECTOR="Choix invalide : $NUM"
	fi
	unset COUNT_CHOICES
	CURRENT_TABLE=$LEVEL_TO_DISPLAY
	i=${TABLES[$LEVEL_TO_DISPLAY]}
clear
done

exit
