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
ORCHID_VERSION[0]="DWM standard [2.2Go]"
ORCHID_URL[0]='https://dl.orchid-linux.org/stage4-orchid-dwmstandard-latest.tar.bz2' 	# DWM
ORCHID_COUNT[0]="https://dl.orchid-linux.org/stage4-orchid-dwmstandard-latest.count"
COUNTED_BY_TREE[0]=326062 	                                                            # Number of files in DWM stage
ORCHID_ESYNC_SUPPORT[0]="ask"	# Ask for esync support
ORCHID_LOGIN[0]="STANDARD"
ORCHID_NAME[0]="DWM"	# Name to use inside this script for various tests

ORCHID_VERSION[1]="DWM Gaming Edition [3.4Go]"
ORCHID_URL[1]='https://dl.orchid-linux.org/stage4-orchid-dwmgaming-latest.tar.bz2' 	    # DWM GE
ORCHID_COUNT[1]="https://dl.orchid-linux.org/stage4-orchid-dwmgaming-latest.count"
COUNTED_BY_TREE[1]=358613 	                                                            # Number of files in DWM GE stage
ORCHID_ESYNC_SUPPORT[1]="yes"	# Do not ask for esync support, add esync support because this is a Gaming Edition
ORCHID_LOGIN[1]="STANDARD"
ORCHID_NAME[1]="DWM-GE"

ORCHID_VERSION[2]="GNOME [2.4Go]"
ORCHID_URL[2]='https://dl.orchid-linux.org/stage4-orchid-gnomefull-latest.tar.bz2'       # Gnome
ORCHID_COUNT[2]="https://dl.orchid-linux.org/stage4-orchid-gnomefull-latest.count.txt"
COUNTED_BY_TREE[2]=424438                                                               # Number of files in Gnome stage
ORCHID_ESYNC_SUPPORT[2]="ask"	# Ask for esync support
ORCHID_LOGIN[2]="STANDARD"
ORCHID_NAME[2]="GNOME"

ORCHID_VERSION[3]="Xfce Gaming Edition [2.6Go]"
ORCHID_URL[3]='https://dl.orchid-linux.org/stage4-orchid-xfcegaming-latest.tar.bz2'       # Xfce gaming
ORCHID_COUNT[3]="https://dl.orchid-linux.org/stage4-orchid-xfcegaming-latest.count"
#COUNTED_BY_TREE[3]=
ORCHID_ESYNC_SUPPORT[3]="yes"	# Do not ask for esync support, add esync support because this is a Gaming Edition
ORCHID_LOGIN[3]="STANDARD"
ORCHID_NAME[3]="XFCE-GE"

ORCHID_VERSION[4]="KDE Plasma [3.2Go]"
ORCHID_URL[4]='https://dl.orchid-linux.org/testing/stage4-orchid-kdeplasma-latest.tar.bz2' # KDE
#ORCHID_COUNT[3]=
COUNTED_BY_TREE[4]=568451                                                               # Number of files in KDE stage
ORCHID_ESYNC_SUPPORT[4]="ask"	# Ask for esync support
ORCHID_LOGIN[4]="STANDARD"
ORCHID_NAME[4]="KDE"

ORCHID_VERSION[5]="GNOME Gaming Edition [3.1Go]"
ORCHID_URL[5]='https://dl.orchid-linux.org/testing/stage4-orchid-gnomegaming-latest.tar.bz2'  # Gnome GE
#ORCHID_COUNT[4]=
COUNTED_BY_TREE[5]=436089                                                               # Number of files in Gnome GE stage
ORCHID_ESYNC_SUPPORT[5]="yes"	# Do not ask for esync support, add esync support because this is a Gaming Edition
ORCHID_LOGIN[5]="STANDARD"
ORCHID_NAME[5]="GNOME-GE"

ORCHID_VERSION[6]="GNOME Gaming Edition avec Systemd [3.3Go]"
ORCHID_URL[6]="https://dl.orchid-linux.org/testing/stage4-orchid-gnomegaming-systemd-latest.tar.bz2"  # Gnome GE Systemd
ORCHID_COUNT[6]="https://dl.orchid-linux.org/testing/stage4-orchid-gnomegaming-systemd-latest.count.txt"
COUNTED_BY_TREE[6]=452794                                                               # Number of files in Gnome GE SystemD stage
ORCHID_ESYNC_SUPPORT[6]="yes"	# Do not ask for esync support, add esync support because this is a Gaming Edition
ORCHID_LOGIN[6]="SYSTEMD-GNOME"
ORCHID_NAME[6]="GNOME-GE-SYSTEMD"

ORCHID_VERSION[7]="Base (X11 & Network Manager) [1.7Go]"
ORCHID_URL[7]="https://dl.orchid-linux.org/stage4-orchid-base-latest.tar.bz2"  # Base
ORCHID_COUNT[7]="https://dl.orchid-linux.org/stage4-orchid-base-latest.count"
#ORCHID_COUNT[7]=
ORCHID_ESYNC_SUPPORT[7]="ask"	# Ask for esync support
ORCHID_LOGIN[7]="BASE"
ORCHID_NAME[7]="BASE-X11"

ORCHID_VERSION[8]="Base avec Systemd (X11 & Network Manager) [2.0Go]"
ORCHID_URL[8]="https://dl.orchid-linux.org/testing/stage4-orchid-basesystemd-latest.tar.bz2"  # Base Systemd
ORCHID_COUNT[8]="https://dl.orchid-linux.org/testing/stage4-orchid-basesystemd-latest.count"
#ORCHID_COUNT[7]=
ORCHID_ESYNC_SUPPORT[8]="ask"	# Ask for esync support
ORCHID_LOGIN[8]="SYSTEMD-BASE"
ORCHID_NAME[8]="BASE-SYSTEMD-X11"

ORCHID_VERSION[9]="Budgie avec Systemd [2.3Go]"
ORCHID_URL[9]="https://dl.orchid-linux.org/testing/stage4-orchid-budgie-latest.tar.bz2"  # Budgie Systemd
ORCHID_COUNT[9]="https://dl.orchid-linux.org/testing/stage4-orchid-budgie-latest.count"
#ORCHID_COUNT[7]=
ORCHID_ESYNC_SUPPORT[9]="ask"	# Ask for esync support
ORCHID_LOGIN[9]="SYSTEMD-BUDGIE"
ORCHID_NAME[9]="BUDGIE-SYSTEMD"


#-----------------------------------------------------------------------------------

# Setup colors
#-----------------------------------------------------------------------------------
COLOR_YELLOW=$'\033[0;33m'
COLOR_GREEN=$'\033[0;32m'
COLOR_RED=$'\033[0;31m'
COLOR_LIGHTBLUE=$'\033[1;34m'
COLOR_WHITE=$'\033[1;37m'
COLOR_LIGHTGREY=$'\e[37m'
COLOR_RESET=$'\033[0m'
C_RESET=$'\e[0m'
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

# Filesystem type radiobox selector
declare -a CHOICES_FILESYSTEM
declare -a FILESYSTEM_TYPE
ERROR_IN_FILESYSTEM_SELECTOR=" "

FILESYSTEM_TYPE[0]="Btrfs"
FILESYSTEM_TYPE[1]="ext4"

CHOICES_FILESYSTEM[0]="${COLOR_GREEN}*${COLOR_RESET}"

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

# Colors and text formating for the upper part of the installer
BG_BLUE="$(tput setab 4)"
BG_BLACK="$(tput setab 0)"
BG_GREEN="$(tput setab 2)"
FG_GREEN="$(tput setaf 2)"
FG_WHITE="$(tput setaf 7)"

TEXT_BOLD="$(tput bold)"
TEXT_DIM="$(tput dim)"
TEXT_REV="$(tput rev)"
TEXT_DEFAULT="$(tput sgr0)"

INSTALLER_STEPS="Welcome|Connecting to internet|Selection of the Orchid Linux Edition|Disk selection|File system selection|Hibernation|Graphics card selection|System name|esync|Updates|User creation|Root password|Resume|Installation"

# Default Gentoo Live CD:
#TERM_COLS=128
#TERM_LINES=48
TERM_LINES=$(tput lines)
TERM_COLS=$(tput cols)

LOGO_COLS=30
LOGO_LINES=15

BANNER="  ___           _     _     _   _     _                  
 / _ \ _ __ ___| |__ (_) __| | | |   (_)_ __  _   ___  __
| | | | '__/ __| '_ \| |/ _\` | | |   | | '_ \| | | \ \/ /
| |_| | | | (__| | | | | (_| | | |___| | | | | |_| |>  < 
 \___/|_|  \___|_| |_|_|\__,_| |_____|_|_| |_|\__,_/_/\_\\"

#-----------------------------------------------------------------------------------

# Setup functions
#-----------------------------------------------------------------------------------

set_term_size() {
        TERM_LINES=`tput lines`
        TERM_COLS=`tput cols`
				draw_installer_steps
        return 0
}

clear_under_menu()
{
  # Clear area beneath menu
  tput cup ${LOGO_LINES} 0 # Move cursor to position row col
  echo -n ${TEXT_DEFAULT}
  tput ed # Clear from the cursor to the end of the screen
  tput cup $((${LOGO_LINES}+1)) 0 # Move cursor to position row col
}

echo_center()
{
TEXT_SIZE=0
TEXT_LINE_START=$(( $LOGO_LINES + 1 ))
while IFS= read -r TEXT; do
	for l in "${TEXT[@]}"; do
		TEXT_ONLY=$(echo -e "$l" | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g')
		#echo "$TEXT_ONLY"
		TEXT_STEPS_COL_CENTER=$(( ($TERM_COLS - ${#TEXT_ONLY}) / 2 ))
		#echo "${#l}**$TEXT_STEPS_COL_CENTER"
		tput cup $TEXT_LINE_START $TEXT_STEPS_COL_CENTER
		echo "${l}"
		((TEXT_LINE_START++))
	done
done <<< "${1}"
}

echo_banner()
{
echo "${COLOR_WHITE}"
TEXT_LINE_START=0	# the banner is at the top
while IFS= read -r TEXT; do
	for l in "${TEXT[@]}"; do
		BANNER_COL_CENTER=$(( $LOGO_COLS + (($TERM_COLS - $LOGO_COLS - ${#l} ) / 2) ))
		tput cup $TEXT_LINE_START $BANNER_COL_CENTER
		echo "${l}"
		((TEXT_LINE_START++))
	done
done <<< "${BANNER}"
echo "${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}"
}

echo_logo()
{
cat <<- _EOF_
                              
             :${COLOR_WHITE}##${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}:             
           -${COLOR_WHITE}#@@@@#${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}-           
          ${COLOR_WHITE}#@@=${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}..${COLOR_WHITE}=@@#${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}          
          ${COLOR_WHITE}+@@${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}-  -${COLOR_WHITE}@@+${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}          
     -${COLOR_WHITE}#@@*${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}..${COLOR_WHITE}*@${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}..${COLOR_WHITE}@*${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}..${COLOR_WHITE}*@@#${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}-     
   :${COLOR_WHITE}#@@*+%@=${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY} .  . ${COLOR_WHITE}=@%+*@@#${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}:   
  ${COLOR_WHITE}+@@@${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}:   :-.    .-:   :${COLOR_WHITE}@@@+${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}  
   :${COLOR_WHITE}#@@*+%@=${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY} .  . ${COLOR_WHITE}=@%+*@@#${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}:   
     -${COLOR_WHITE}#@@*${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}..${COLOR_WHITE}*@${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}..${COLOR_WHITE}@*${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}..${COLOR_WHITE}*@@#${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}-     
          ${COLOR_WHITE}+@@${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}-  -${COLOR_WHITE}@@+${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}          
          ${COLOR_WHITE}#@@=${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}..${COLOR_WHITE}=@@#${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}          
           -${COLOR_WHITE}#@@@@#${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}-           
             :${COLOR_WHITE}##${COLOR_RESET}${BG_GREEN}${COLOR_LIGHTGREY}:             
                              
_EOF_
}

draw_installer_steps()
{
echo -n ${BG_GREEN}${FG_WHITE}
clear

echo_logo

echo_banner

clear_under_menu

TEXT_STEPS_RAW_START_MINIMUM=5

i=1
TEXT_SIZE=0
TEXT_STEPS=""
STEPS_SEPARATOR=" -> "
MAX_COLS_BANNER_AREA=$(( $TERM_COLS - $LOGO_COLS - ${#STEPS_SEPARATOR} ))
TEXT_STEPS_COL_WIDTH=$(( $TERM_COLS - $LOGO_COLS ))

TEXT_STEPS_RAW_COUNT=0

while IFS='|' read -ra STEPS; do	# We will count how many lines we need to print all the steps on the screen
	for l in "${STEPS[@]}"; do
		if [ $((${#l} + $TEXT_SIZE)) -gt $MAX_COLS_BANNER_AREA ]; then	# We will exceed our limit if we add a new step!
			((TEXT_STEPS_RAW_COUNT++))
			TEXT_SIZE=0 # reset text size
		fi
		TEXT_SIZE=$((${#l} + $TEXT_SIZE))
		if [[ ! $i = ${#STEPS[*]} ]]; then # If not the last item, add a separator, e.g. " -> "
			TEXT_SIZE=$(( $TEXT_SIZE + ${#STEPS_SEPARATOR} ))
		fi
		((i++))
	done
done <<< "${INSTALLER_STEPS}"

TEXT_STEPS_RAW_START=$(( $TEXT_STEPS_RAW_START_MINIMUM + (($LOGO_LINES - $TEXT_STEPS_RAW_START_MINIMUM - $TEXT_STEPS_RAW_COUNT) / 2) ))
# reset usefull variables
i=1
TEXT_SIZE=0
TEXT_STEPS=""

echo -n ${BG_GREEN}${FG_WHITE}
while IFS='|' read -ra STEPS; do
	for l in "${STEPS[@]}"; do

		if [ $((${#l} + $TEXT_SIZE)) -gt $MAX_COLS_BANNER_AREA ]; then	# We will exceed our limit if we add a new step!
			TEXT_STEPS_COL_CENTER=$(( $LOGO_COLS + (($TEXT_STEPS_COL_WIDTH - ${TEXT_SIZE}) / 2) ))
			tput cup $TEXT_STEPS_RAW_START $TEXT_STEPS_COL_CENTER
			((TEXT_STEPS_RAW_START++))
			echo "$TEXT_STEPS"	# Print text
			TEXT_STEPS="" # reset text to print on screen
			TEXT_SIZE=0 # reset text size
		fi

		TEXT_SIZE=$((${#l} + $TEXT_SIZE))

		if [[ $UI_PAGE = $(($i-1)) ]]; then	# We are at this step
			TEXT_STEPS+="${TEXT_REV}${l}${TEXT_DEFAULT}${BG_GREEN}${FG_WHITE}"
		elif [[ $UI_PAGE -gt $(($i-1)) ]]; then # We have already done those steps
			TEXT_STEPS+="${TEXT_BOLD}${l}${TEXT_DEFAULT}${BG_GREEN}${FG_WHITE}"
		else	# We have not done those yet
			TEXT_STEPS+="${l}"
		fi

		if [[ ! $i = ${#STEPS[*]} ]]; then # If not the last item, add a separator, e.g. " -> "
			TEXT_STEPS+=$STEPS_SEPARATOR
			TEXT_SIZE=$(( $TEXT_SIZE + ${#STEPS_SEPARATOR} ))
		else	# this is the end of installer STEPS
			TEXT_STEPS_COL_CENTER=$(( $LOGO_COLS + (($TEXT_STEPS_COL_WIDTH - ${TEXT_SIZE}) / 2) ))
			tput cup $TEXT_STEPS_RAW_START $TEXT_STEPS_COL_CENTER
			echo "$TEXT_STEPS"	# Print text
		fi

		((i++))
	done
done <<< "${INSTALLER_STEPS}"
echo ${TEXT_DEFAULT}
tput cup $((${LOGO_LINES}+1)) 0 # Move cursor to position row col
}

CLI_filesystem_selector()
{
	WHAT_IS_FILESYSTEM="A file system organizes the way data is stored on your disk.

Btrfs is new. It allows you to take automatic snapshots of the system
of the system to revert if an update goes wrong.
All data will be compressed transparently.
It is possible to resize the system on the fly.

Ext4 is robust thanks to operation logging,
minimizes data fragmentation and is widely tested.
"
	echo_center "$WHAT_IS_FILESYSTEM"
	echo "Select the file system you want to use : [${COLOR_GREEN}Btrfs${COLOR_RESET}]"
	for (( i = 0; i < ${#FILESYSTEM_TYPE[@]}; i++ )); do
		echo "(${CHOICES_FILESYSTEM[$i]:- }) ${COLOR_WHITE}$(($i+1))${COLOR_RESET}) ${FILESYSTEM_TYPE[$i]}"
	done

	echo "$ERROR_IN_FILESYSTEM_SELECTOR"
}


select_filesystem_to_install()
{
	clear_under_menu
	while CLI_filesystem_selector && read -rp "Select the file system you want to use with it corresponding number , hit ${COLOR_WHITE}[Enter]${COLOR_RESET}  : to continue" NUM && [[ "$NUM" ]]; do
		clear_under_menu
		if [[ "$NUM" == *[[:digit:]]* && $NUM -ge 1 && $NUM -le ${#FILESYSTEM_TYPE[@]} ]]; then
			((NUM--))
			for (( i = 0; i < ${#FILESYSTEM_TYPE[@]}; i++ )); do
				if [[ $NUM -eq $i ]]; then
					CHOICES_FILESYSTEM[$i]="${COLOR_GREEN}*${COLOR_RESET}"
				else
					CHOICES_FILESYSTEM[$i]=""
				fi
			done

			ERROR_IN_FILESYSTEM_SELECTOR=" "
		else
			ERROR_IN_FILESYSTEM_SELECTOR="Invalid choice : $NUM"
		fi
	done

# Choice has been made by the user, now we need to populate FILESYSTEM
	for (( i = 0; i < ${#FILESYSTEM_TYPE[@]}; i++ )); do
		if [[ "${CHOICES_FILESYSTEM[$i]}" == "${COLOR_GREEN}*${COLOR_RESET}" ]]; then
			FILESYSTEM=${FILESYSTEM_TYPE[$i]}
		fi
	done
}

CLI_orchid_selector()
{
	echo "Choose the Orchid Linux Edition you want to install :"
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
	clear_under_menu
	while CLI_orchid_selector && read -rp "Select the Orchid version with it number, and hit ${COLOR_WHITE}[Enter]${COLOR_RESET} to validate : " NUM && [[ "$NUM" ]]; do
		clear_under_menu
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
			ERROR_IN_ORCHID_SELECTOR="Invalid Choice : $NUM"
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
	echo "${COLOR_GREEN}*${COLOR_RESET} Your GPU : ${COLOR_GREEN}${GPU_TYPE}${COLOR_RESET}"
	echo ""
	echo "Choose the GPU drivers you want to use :"
	for (( i = 0; i < ${#GPU_DRIVERS[@]}; i++ )); do
		echo "[${CHOICES[$i]:-${COLOR_RED}-${COLOR_RESET}}]" $(($i+1))") ${GPU_DRIVERS[$i]}"
	done

	echo "$ERROR_IN_SELECTOR"
}


select_GPU_drivers_to_install()
{
  GPU_TYPE=$(lspci | grep -E "VGA|3D" | cut -d ":" -f3)
  if [[ $GPU_TYPE =~ "NVIDIA" ]]; then           # if nvidia GPU
    CHOICES[2]="${COLOR_GREEN}+${COLOR_RESET}"   # set "nvidia" to install
  elif [[ $GPU_TYPE =~ "AMD" ]]; then            # if AMD GPU
    CHOICES[3]="${COLOR_GREEN}+${COLOR_RESET}"   # set "radeon" and "amdgpu" to install
    CHOICES[4]="${COLOR_GREEN}+${COLOR_RESET}"
  elif [[ $GPU_TYPE =~ "INTEL" ]]; then          # If Intel GPU (need to change "INTEL" to true value)
    CHOICES[0]="${COLOR_GREEN}+${COLOR_RESET}"
    CHOICES[1]="${COLOR_GREEN}+${COLOR_RESET}"
  elif [[ $GPU_TYPE =~ "VMware" || $GPU_TYPE =~ "QXL" ]]; then          # If virtualisation
    CHOICES[6]="${COLOR_GREEN}+${COLOR_RESET}"
    CHOICES[7]="${COLOR_GREEN}+${COLOR_RESET}"
  fi

	clear_under_menu
	while CLI_selector && read -rp "Select your GPU drivers with their number, and hit ${COLOR_WHITE}[Enter]${COLOR_RESET} to validate : " NUM && [[ "$NUM" ]]; do
		clear_under_menu
		if [[ "$NUM" == *[[:digit:]]* && $NUM -ge 1 && $NUM -le ${#GPU_DRIVERS[@]} ]]; then
			((NUM--))
			if [[ "${CHOICES[$NUM]}" == "${COLOR_GREEN}+${COLOR_RESET}" ]]; then
				CHOICES[NUM]="${COLOR_RED}-${COLOR_RESET}"
			else
				CHOICES[NUM]="${COLOR_GREEN}+${COLOR_RESET}"
			fi

			ERROR_IN_SELECTOR=" "
		else
			ERROR_IN_SELECTOR="Invalid Choice : $NUM"
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
	echo "Choose the disk where you want to install Orchid Linux :"
	echo "${COLOR_YELLOW}! WARNING ! All data on this disk will be deleted, proceed with caution !${COLOR_RESET}"
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
	clear_under_menu
	while CLI_disk_selector && read -rp "Select the disk where you want to install Orchid to with it number, and hit ${COLOR_WHITE}[Enter]${COLOR_RESET} to validate : " NUM && [[ "$NUM" ]]; do
		clear_under_menu
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
		  	ERROR_IN_DISK_SELECTOR="Invalid Choice : $NUM"
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
		SFDISK_CONFIG+="${DISK_PARTITIONS}1: size=512M,type=uefi
		"                                                                               # EFI System
		SFDISK_CONFIG+="${DISK_PARTITIONS}2: size=${SWAP_SIZE_GB}G,type=swap
		"                                                                               # Linux SWAP
		SFDISK_CONFIG+="${DISK_PARTITIONS}3: type=linux
		"                                                                               # Linux filesystem data
	elif [ "$ROM" = "BIOS" ]; then
		SFDISK_CONFIG+="${DISK_PARTITIONS}1: size=8M,type=21686148-6449-6E6F-744E-656564454649
		"                                                                               # BIOS Boot partition
	  	SFDISK_CONFIG+="${DISK_PARTITIONS}2: size=${SWAP_SIZE_GB}G,type=swap
		"                                                                               # Linux SWAP
	 	 SFDISK_CONFIG+="${DISK_PARTITIONS}3: type=linux
		"                                                                               # Linux filesystem data
	fi

	echo "${COLOR_GREEN}*${COLOR_RESET} Disk partitioning ."
	echo "$SFDISK_CONFIG" | sfdisk ${CHOOSEN_DISK}
	if [ "$ROM" = "UEFI" ]; then
	  	echo " ${COLOR_GREEN}*${COLOR_RESET} EFI partition wiping ."
	  	mkfs.vfat -F32 "${DISK_PARTITIONS}1"
	fi

	echo " ${COLOR_GREEN}*${COLOR_RESET} Swap partition wiping."
	mkswap "${DISK_PARTITIONS}2"
	
	if [ "$FILESYSTEM" = "Btrfs" ]; then
		echo " ${COLOR_GREEN}*${COLOR_RESET} BTRFS partition wiping."
		mkfs.btrfs -f "${DISK_PARTITIONS}3"
	elif [ "$FILESYSTEM" = "ext4" ]; then
		echo " ${COLOR_GREEN}*${COLOR_RESET} EXT4 partition wiping."
		mkfs.ext4 -F "${DISK_PARTITIONS}3"
	fi
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
      "y" | "n" ) echo $__ANSWER; break;;
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

set_totalmemory_against_processors()
{
# For some packages (e.g. webkit-gtk) to compile succesfully, we MUST have at least: available RAM (including SWAP) > 2*CPU(threads)
# see: https://wiki.gentoo.org/wiki/MAKEOPTS
if ! (( ${RAM_SIZE_GB} + ${SWAP_SIZE_GB} >= (${PROCESSORS} * 2)  + 2 )); then # we add 2GB for margin
	(( SWAP_SIZE_GB=(${PROCESSORS} * 2 ) - ${RAM_SIZE_GB} + 2 )) # we add 2GB for margin
fi
}

swap_size_hibernation()
{
	if (( ${RAM_SIZE_GB} >= 2 && ${RAM_SIZE_GB} < 8 )); then	                        # Pour une taille de RAM comprise entre 2 et 8 Go
		(( SWAP_SIZE_GB = ${RAM_SIZE_GB}*2 )) 	                                        # 2 fois la taille de la RAM

	elif (( ${RAM_SIZE_GB} >= 8 && ${RAM_SIZE_GB} < 64 )); then	                        # Pour une taille de RAM comprise entre 8 et 64 Go
		(( SWAP_SIZE_GB = ${RAM_SIZE_GB}*3/2 ))		                                    # 1.5 (3/2) fois la taille de la RAM

	elif (( ${RAM_SIZE_GB} >= 64 )); then	                                            # Pour une taille de RAM supérieure à 64 Go
		(( SWAP_SIZE_GB = ${RAM_SIZE_GB}*3/2 ))
		set_totalmemory_against_processors
		echo "We do not recommend using hibernation with your ${RAM_SIZE_GB} Go of RAM, because it would need a swap partition of ${SWAP_SIZE_GB} Go on the disk."
		HIBERNATION_HIGH=$(ask_yes_or_no_and_validate "Would you want to create a swap partition of ${SWAP_SIZE_GB} Go to make hibernation usable ? (If no, the swap partition will be a lot smaller and hibernation wont work) ${COLOR_WHITE}[y/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET} " n)
		if [ "$HIBERNATION_HIGH" = "n" ]; then
			swap_size_no_hibernation

		elif [ "$HIBERNATION_HIGH" = "y" ]; then
			SWAP_SIZE_GB=$(ask_for_numeric_and_validate "Enter the size of the swap partition you want to create (in Go) ${COLOR_WHITE}[${COLOR_GREEN}${SWAP_SIZE_GB} Go${COLOR_WHITE}]${COLOR_RESET} : " $SWAP_SIZE_GB)
		fi
	fi
set_totalmemory_against_processors
}


swap_size_no_hibernation()
{
	if (( ${RAM_SIZE_GB} >= 2 && ${RAM_SIZE_GB} < 8 )); then	                        # Pour une taille de RAM comprise entre 2 et 8 Go
		(( SWAP_SIZE_GB = ${RAM_SIZE_GB} ))		                                        # 1 fois la taille de la RAM

	elif (( ${RAM_SIZE_GB} >= 8 && ${RAM_SIZE_GB} < 64 )); then	                        # Pour une taille de RAM comprise entre 8 et 64 Go
		(( SWAP_SIZE_GB = ${RAM_SIZE_GB}*1/2 ))		                                    # 0.5 (1/2) fois la taille de la RAM

	elif (( ${RAM_SIZE_GB} >= 64 )); then	                                            # Pour une taille de RAM supérieure à 64 Go
		(( SWAP_SIZE_GB = ${RAM_SIZE_GB}*1/2 ))
		set_totalmemory_against_processors
		SWAP_SIZE_GB=$(ask_for_numeric_and_validate  "Enter the size of the swap partition you want to create (in Go) ${COLOR_WHITE}[${COLOR_GREEN}${SWAP_SIZE_GB} Go${COLOR_WHITE}]${COLOR_RESET} : " $SWAP_SIZE_GB)
	fi
set_totalmemory_against_processors
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
    echo "${COLOR_WHITE}Enter the user password ${1} : ${COLOR_YELLOW}(the password won't get displayed)${COLOR_RESET}"
    read -s ATTEMPT1
    echo "${COLOR_WHITE}Confirm the password :${COLOR_RESET}"
    read -s ATTEMPT2
}


verify_password_concordance() # Spécifier le nom de l'utilisateur en $1
{
    while [[ "${ATTEMPT1}" != "${ATTEMPT2}" ]]; do
    	echo "${COLOR_YELLOW}The two passwords don't match, please try again.${COLOR_RESET}"
    	create_passwd "${1}"
	done
}


#-----------------------------------------------------------------------------------

#============================================================== PRECONFIGURATION ===

#=== MAIN ==========================================================================

if [ "$EUID" -ne 0 ]
  then echo "Please launch the script with root rights. (su,sudo or doas)"
  exit
fi


trap set_term_size WINCH	# We trap window changing size to adapt our interface
tput smcup	# save the screen

UI_PAGE=0		# This variable point us to the current step

while :; do	# infinite loop
draw_installer_steps		# we draw the upper part of the menu
  case $UI_PAGE in
	0)  # Bienvenue
	# Disclaimer
	#-----------------------------------------------------------------------------------

	WELCOME="${COLOR_YELLOW}The Orchid Linux team is in no way responsible for
for any problems that may occur during the installation or
installation or use of Orchid Linux.
(License GPL 3.0 or higher)

Please read the instructions very carefully.
Thank you for choosing Orchid Linux !${COLOR_RESET}"
	echo_center "$WELCOME"
	echo ""
	read -p "Hit ${COLOR_WHITE}[Enter]${COLOR_RESET} to start the installation."

	#-----------------------------------------------------------------------------------

	# Questions de configuration
	#===================================================================================

	RAM_SIZE_GB=$(( ($(cat /proc/meminfo|grep MemTotal|sed "s/[^[[:digit:]]*//g")+1000000/2)/1000000 ))   # Total Memory in GB, round half-up
	if (( $RAM_SIZE_GB < 2 )); then
		echo "${COLOR_YELLOW}Sorry, you need at least 2 Go of RAM to use Orchid Linux. End of installation.${COLOR_RESET}"
		exit
	fi

	UI_PAGE=1		# Point to the next step
	;;
	1)
	# Check Internet connection
	#-----------------------------------------------------------------------------------

	test_internet_access
	while [ $test_ip = 0 ]; do
		echo "${COLOR_RED}*${COLOR_RESET} Connexion test failed, you either don't have internet access, or our servers are down."
		read -p "We will try to connect to the internet again, hit ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue"
		dhcpcd                                                                              # Génération d'une addresse IP
		test_internet_access
	done
	echo "${COLOR_GREEN}*${COLOR_RESET} Connexion test succeeded."
	echo ""
	read -p "Hit ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue"
	UI_PAGE=2
	;;
	2)

	# Choix du système
	select_orchid_version_to_install
	echo ""
	UI_PAGE=3
	;;
	3)
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

	echo "${COLOR_GREEN}*${COLOR_RESET} Orchid Linux will be installed on ${COLOR_GREEN}${CHOOSEN_DISK} : ${CHOOSEN_DISK_LABEL}${COLOR_RESET}"
	echo "${COLOR_YELLOW}                                  ^^ ! Warning ! All data on this drive will get erased !${COLOR_RESET}"
	if [ -d /sys/firmware/efi ]; then	                                                    # Test for UEFI or BIOS
		ROM="UEFI"
	else
		ROM="BIOS"
	fi

	echo "${COLOR_GREEN}*${COLOR_RESET} Your boot mode is set to ${ROM}."
	echo ""
	echo "Hit ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue, ${COLOR_WHITE}or any key${COLOR_RESET} to quit the installation."
	read -s -n 1 key	# -s: do not echo input character. -n 1: read only 1 character (separate with space)
	if [[ ! $key = "" ]]; then	# Input is not the [Enter] key, aborting installation!
		echo "${COLOR_YELLOW}Orchid Linux installation canceled, nothing has been written to your disk. We hope to see you soon !${COLOR_RESET}"
		exit
	fi

	UI_PAGE=4
	;;
	4)
	# FileSystem
	#-----------------------------------------------------------------------------------
	select_filesystem_to_install
	UI_PAGE=5
	;;
	5)
	WHAT_IS_HIBERNATION="Hibernation is turning off the computer while maintaining its state.
When you turn it on, you will find your desktop exactly as it was before the shutdown.

To do this, it is necessary to copy all the RAM to a disk (SWAP).

By default, we suggest that you do not use hibernation.
"
	echo_center "$WHAT_IS_HIBERNATION"
	HIBERNATION=$(ask_yes_or_no_and_validate "Would you want to use hibernation ? ${COLOR_WHITE}[y/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET} " n)
	#-----------------------------------------------------------------------------------

	# Calcul de la mémoire SWAP idéale
	#-----------------------------------------------------------------------------------
	#-----------------------------------------------------------------------------------
	# Count the number of CPU threads available on the system, for SWAP formula and to inject into /etc/portage/make.conf at a later stage
	PROCESSORS=$(grep -c processor /proc/cpuinfo)
	if [ "$HIBERNATION" = "y" ]; then	                                                    # Si hibernation
		swap_size_hibernation
	elif [ "$HIBERNATION" = "n" ]; then		                                                # Si pas d'hibernation
		swap_size_no_hibernation
	fi
	#-----------------------------------------------------------------------------------
	echo " ${COLOR_GREEN}*${COLOR_RESET} Your swap partition will have a size of ${SWAP_SIZE_GB} Go."
	UI_PAGE=6
	;;
	6)
	select_GPU_drivers_to_install                                                           # Select GPU
	UI_PAGE=7
	;;
	7)
	#-----------------------------------------------------------------------------------

	# choose your hostname
	#-----------------------------------------------------------------------------------

	IS_HOSTNAME_VALID=0
	WHAT_IS_HOSTNAME="The hostname is a name you give to your device so that it gets identified on the network.

By default, we suggest calling it ${COLOR_GREEN}orchid${COLOR_RESET}.
"
	echo_center "$WHAT_IS_HOSTNAME"

	while  [ $IS_HOSTNAME_VALID = 0 ]; do
		read -e -p "Enter the hostname [${COLOR_GREEN}orchid${COLOR_RESET}] : " HOSTNAME
		HOSTNAME=${HOSTNAME:-orchid}
		test_if_hostname_is_valid
		if [ $IS_HOSTNAME_VALID = 0 ]; then
			echo "${COLOR_RED}*${COLOR_RESET} Sorry, \"${COLOR_WHITE}${HOSTNAME}${COLOR_RESET}\" is invalid. Try again."
		fi
	done
	UI_PAGE=8
	;;
	8)
	#-----------------------------------------------------------------------------------

	# Option pour la configuration d'esync (limits)
	#-----------------------------------------------------------------------------------
	WHAT_IS_ESYNC=" Esync is a technology created to improve the performance of games
that make heavy use of parallelism. It is especially useful if you use your computer for
if you use your computer for gaming.

It requires a small modification of a security parameter
(the significant increase of the number of file descriptors per process).

By default, we suggest you to activate it: ${COLOR_GREEN}o${COLOR_RESET}.
"
	echo_center "$WHAT_IS_ESYNC"

	if [ "${ORCHID_ESYNC_SUPPORT[$no_archive]}" = "yes" ]; then	# Do not ask for esync support because this is a Gaming Edition
		ESYNC_SUPPORT="y"
		echo "For the gaming editions, Orchid Linux enables esync by default."
		echo ""
		read -p "Hit ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue"
	elif [ "${ORCHID_ESYNC_SUPPORT[$no_archive]}" = "ask" ]; then	# This is not a Gaming Edition, ask for esync support
		ESYNC_SUPPORT=$(ask_yes_or_no_and_validate "Would you want to enable Esync ? ${COLOR_WHITE}[${COLOR_GREEN}y${COLOR_WHITE}/n]${COLOR_RESET} " o)
	else
		echo "FATAL ERROR: what about esync ?"
		exit 1
	fi
	UI_PAGE=9
	;;
	9)
	# Option pour la mise à jour d'Orchid Linux dans l'installateur
	#-----------------------------------------------------------------------------------
	WHAT_IS_UPDATE="La mise à jour de votre ordinateur est une opération qui consiste à vérifier
que les logiciels de votre ordinateur utilisent bien la dernière version disponible.
Ceci est particulièrement important pour la sécurité du système,
sa cohérence et fourni aussi parfois de nouvelles fonctionnalités.

Par défaut, nous conseillons de faire la mise à jour juste après l'installation,
car cette opération peut être longue et si vous choisissez de la faire pendant
l'installation vous devrez attendre sans rien pouvoir faire d'autre.
"
	echo_center "$WHAT_IS_UPDATE"
	UPDATE_ORCHID=$(ask_yes_or_no_and_validate "Voulez-vous mettre à jour votre Orchid Linux durant cette installation ? ${COLOR_WHITE}[y/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET} " n)
	UI_PAGE=10
	;;
	10)
	WHAT_IS_USERNAME="On a Linux system, such as Orchid Linux, each user must have his own account
its own account that identifies it and separates its files from others.

By default, the first user you create will have
administrative rights with the ${COLOR_WHITE}sudo${COLOR_RESET} command.
"
	echo_center "$WHAT_IS_USERNAME"
	IS_USERNAME_VALID=0
	while  [ $IS_USERNAME_VALID = 0 ]; do
		read -p "${COLOR_GREEN}*${COLOR_RESET} ${COLOR_WHITE}Username : ${COLOR_RESET}" USERNAME
		test_if_username_is_valid
		if [ $IS_USERNAME_VALID = 0 ]; then
			echo "${COLOR_RED}*${COLOR_RESET} Sorry, \"${COLOR_WHITE}${USERNAME}${COLOR_RESET}\" is invalid. Try again."
		fi
	done

	echo ""
	create_passwd "${USERNAME}"
	echo ""
	verify_password_concordance "${USERNAME}"
	USER_PASS="${ATTEMPT1}"
	UI_PAGE=11
	;;
	11)
	WHAT_IS_ROOT="You will now choose the root account password

This account will have full rights to your system, so choose a strong and complicated password
"
	echo_center "$WHAT_IS_ROOT"
	echo ""
	create_passwd "root"
	verify_password_concordance "root"
	ROOT_PASS="${ATTEMPT1}"
	UI_PAGE=12
	;;
	12)
	echo_center "${COLOR_WHITE}Installation Summary${COLOR_RESET}"
	echo "Internet connection test : [${COLOR_GREEN}OK${COLOR_RESET}]"
	echo "Orchid Linux Edition : ${COLOR_GREEN}${ORCHID_VERSION[$no_archive]}${COLOR_RESET}."
	echo "Keyboard layout ${COLOR_GREEN}(us)${COLOR_RESET} : [${COLOR_GREEN}OK${COLOR_RESET}]"
	echo "Orchid Linux will be installed to : ${COLOR_GREEN}${CHOOSEN_DISK_LABEL}${COLOR_RESET}"
	echo "Prefered file system : ${COLOR_GREEN}${FILESYSTEM}${COLOR_RESET}"
	if [ "$HIBERNATION" = y ]; then
		echo "You will be able to use ${COLOR_GREEN}hibernation${COLOR_RESET} : RAM capacity : ${RAM_SIZE_GB} Go, ${PROCESSORS} processor cores, SWAP partition ${COLOR_GREEN}${SWAP_SIZE_GB} Go${COLOR_RESET})."
	elif [ "$HIBERNATION" = n ]; then
		echo "RAM capacity ${RAM_SIZE_GB} Go with ${PROCESSORS} processor cores. SWAP partition of ${COLOR_GREEN}${SWAP_SIZE_GB} Go${COLOR_RESET}."
	fi

	echo "These graphics cards drivers will be installed : ${COLOR_GREEN}${SELECTED_GPU_DRIVERS_TO_INSTALL}${COLOR_RESET}"
	echo "Your system will have the following hostname on the network : ${COLOR_GREEN}${HOSTNAME}${COLOR_RESET}."
	if [ "$ESYNC_SUPPORT" = y ]; then
		echo "${COLOR_GREEN}ESYNC${COLOR_RESET} will be configured for this account : ${COLOR_GREEN}${USERNAME}${COLOR_RESET}."
	fi

	if [ "$UPDATE_ORCHID" = y ]; then
		echo "Orchid Linux will get ${COLOR_GREEN}updated${COLOR_RESET} in this installation."
		echo "                                ^^ ${COLOR_YELLOW}Might take some time.${COLOR_RESET}"
	fi

	echo "This user account will get created : ${COLOR_GREEN}${USERNAME}${COLOR_RESET}"
	echo ""
	echo "Hit ${COLOR_WHITE}[Enter]${COLOR_RESET} to start the installation, ${COLOR_WHITE}or any other key${COLOR_RESET} to quit the installation."
	read -s -n 1 key	# -s: do not echo input character. -n 1: read only 1 character (separate with space)
	if [[ ! $key = "" ]]; then	# Input is not the [Enter] key, aborting installation!
		echo "${COLOR_YELLOW}Orchid linux installation cancelled, nothing has been written to your disk. Hope to see you soon !${COLOR_RESET}"
		exit
	fi
	UI_PAGE=13
	;;
	13)	# Print Installation in the upper side of the UI.
	break
	;;
	esac
done

# installation
echo ""
echo "${COLOR_GREEN}*${COLOR_RESET} Disk partitionning."
# Is this an NVME disk?
if [[ "${CHOOSEN_DISK}" == *"nvme"* ]]; then
	DISK_PARTITIONS="${CHOOSEN_DISK}p"
else
	DISK_PARTITIONS="${CHOOSEN_DISK}"
fi
auto_partitionning_full_disk

# Montage des partitions
#-----------------------------------------------------------------------------------

echo "${COLOR_GREEN}*${COLOR_RESET} Monting the partitions :"
echo "  ${COLOR_GREEN}*${COLOR_RESET} Root partition"
mkdir /mnt/orchid 
UUID="$(blkid ${DISK_PARTITIONS}3 -o value -s UUID)"
if [ "$FILESYSTEM" = "Btrfs" ]; then
	mount -o compress=zstd:1 UUID="${UUID}" /mnt/orchid
elif [ "$FILESYSTEM" = "ext4" ]; then
	mount UUID="${UUID}" /mnt/orchid
fi
echo "  ${COLOR_GREEN}*${COLOR_RESET} SWAP activation."
UUID="$(blkid ${DISK_PARTITIONS}2 -o value -s UUID)"
swapon -U "${UUID}"
# Pour l'EFI
if [ "$ROM" = "UEFI" ]; then
	echo "  ${COLOR_GREEN}*${COLOR_RESET} EFI Partition."
	mkdir -p /mnt/orchid/boot/EFI
	UUID="$(blkid ${DISK_PARTITIONS}1 -o value -s UUID)"
	mount UUID="${UUID}" /mnt/orchid/boot/EFI
fi

echo "${COLOR_GREEN}*${COLOR_RESET} Partitionning completed!"
cd /mnt/orchid
#-----------------------------------------------------------------------------------
# Count the number of CPU threads available on the system, to inject into /etc/portage/make.conf at a later stage
#PROCESSORS=$(grep -c processor /proc/cpuinfo)

# Download & extraction of the stage4
#-----------------------------------------------------------------------------------

echo "${COLOR_GREEN}*${COLOR_RESET} Downloading and extracting of the desired Orchid Linux Edition."
processed=0
FILE_TO_DECOMPRESS=${ORCHID_URL[$no_archive]}
FILE_TO_DECOMPRESS=${FILE_TO_DECOMPRESS##*/}	                                        # Just keep the file from the URL
if [ -n "${ORCHID_COUNT[$no_archive]}" ]; then
	COUNTED_BY_TREE[$no_archive]=$(wget -q -O- ${ORCHID_COUNT[$no_archive]})
fi

# tar options to extract: tar.bz2 -jxvp, tar.gz -xvz, tar -xv
echo -ne "\r    [                                                  ]"	                # This is an empty bar, i.e. 50 empty chars
wget -q -O- ${ORCHID_URL[$no_archive]} | tar -jxvp --xattrs 2>&1 | decompress_with_progress_bar

# Fail safe
echo -ne "\r100%[${BAR:0:50}]"
# New line
echo -ne "\r\v"
echo "${COLOR_GREEN}*${COLOR_RESET} Extraction completed."
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

echo "${COLOR_GREEN}*${COLOR_RESET} Mounting the proc dev sys and run directories"
mount -t proc /proc /mnt/orchid/proc
mount --rbind /dev /mnt/orchid/dev
mount --rbind /sys /mnt/orchid/sys
mount --bind /run /mnt/orchid/run
# Téléchargement et extraction des scripts d'install pour le chroot
wget "https://github.com/wamuu-sudo/orchid/raw/main/testing/install-chroot-en.tar.xz" --output-document=install-chroot.tar.xz
tar -xvf "install-chroot.tar.xz" -C /mnt/orchid
# On rend les scripts exécutables
chmod +x /mnt/orchid/postinstall-in-chroot.sh && chmod +x /mnt/orchid/DWM-config.sh && chmod +x /mnt/orchid/GNOME-config.sh && chmod +x /mnt/orchid/XFCE-config.sh


# Lancement des scripts en fonction du système
#-----------------------------------------------------------------------------------

# Postinstall: UEFI or BIOS, /etc/fstab, hostname, create user, assign groups, grub, activate services
chroot /mnt/orchid ./postinstall-in-chroot.sh ${CHOOSEN_DISK} ${ROM} ${ROOT_PASS} ${USERNAME} ${USER_PASS} ${HOSTNAME} ${ORCHID_LOGIN[$no_archive]} ${ESYNC_SUPPORT} ${UPDATE_ORCHID} ${ORCHID_NAME[$no_archive]} ${FILESYSTEM} ${COUNTED_BY_TREE[$no_archive]}
# Configuration pour DWM
# no_archive use computer convention: start at 0
if [ "${ORCHID_NAME[$no_archive]}" = "DWM" -o "${ORCHID_NAME[$no_archive]}" = "DWM-GE" ]; then
	chroot /mnt/orchid ./DWM-config.sh ${USERNAME}
fi

# Configuration clavier pour GNOME
if [ "${ORCHID_NAME[$no_archive]}" = "GNOME" -o "${ORCHID_NAME[$no_archive]}" = "GNOME-GE" -o "${ORCHID_NAME[$no_archive]}" = "GNOME-GE-SYSTEMD" ]; then
	chroot /mnt/orchid ./GNOME-config.sh ${USERNAME} ${ORCHID_LOGIN[$no_archive]}
fi

# Configuration pour Xfce (Firefox-bin as default Web Browser)
if [ "${ORCHID_NAME[$no_archive]}" = "XFCE-GE" ]; then
	chroot /mnt/orchid ./XFCE-config.sh ${USERNAME}
fi


#-----------------------------------------------------------------------------------
                                                                 # Montage et chroot
#===================================================================================

# Fin de l'installation
#===================================================================================

# Nettoyage
#-----------------------------------------------------------------------------------

rm -f /mnt/orchid/*.tar.bz2 && rm -f /mnt/orchid/*.tar.xz && rm -f /mnt/orchid/postinstall-in-chroot.sh
rm -f /mnt/orchid/DWM-config.sh && rm -f /mnt/orchid/GNOME-config.sh && rm -f /mnt/orchid/XFCE-config.sh
rm -f /mnt/orchid/orchid-backgrounds.xml && rm -f /mnt/orchid/orchid-logo.png && rm -f /mnt/orchid/xfce4-desktop.xml
cd /

umount -R /mnt/orchid
#-----------------------------------------------------------------------------------
# Finish
echo ""
read -p "Installation completed ! ${COLOR_WHITE}[Enter]${COLOR_RESET} to reboot . Don't forget to plug out the installation medium. Thanks for choosing us !"
# On redémarre pour démarrer sur le système fraichement installé
reboot
exit
# Restore screen
#tput rmcup # Restore screen contents

                                                             # Fin de l'installation
#===================================================================================

#========================================================================== MAIN ===
