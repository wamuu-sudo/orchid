#!/bin/bash

#===================================================================================
#
# FILE : .bashrc
#
# USAGE : N/A
#
# DESCRIPTION : BASHRC for the root user
#
# BUGS : ---
# NOTES : ---
# CONTRUBUTORS : Chevek, Wamuu, Maite
# CREATED : july 2022
# REVISION: 10 july 2022
#
# LICENCE :
# Copyright (C) 2022 Yannick Defais aka Chevek, Wamuu-sudo, Maite
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

if [ ! "$(grep nox /proc/cmdline)" ]
then
	if [ -x /usr/bin/X ]
	then
		if [ -e /etc/startx -a $(tty) = "/dev/tty1" ];
		then
			rm -f /etc/startx
			##STARTX
			[ -f /etc/motd ] && cat /etc/motd
		fi
	fi
fi

declare -a BRANCHES
declare -a CHOICES_BRANCH
REGEXP_BRANCHE='[[:space:]]*\"name\":[[:space:]]*"(.*?)\",'
COLOR_WHITE=$'\033[1;37m'
COLOR_GREEN=$'\033[0;32m'
COLOR_RESET=$'\033[0m'
ERROR_IN_BRANCH_SELECTOR=" "
CHOICES_BRANCH[0]="${COLOR_GREEN}*${COLOR_RESET}"

CLI_branche_selector()
{
	echo "Select the branch to test:"
	for (( i = 0; i < ${#BRANCHES[@]}; i++ )); do
		echo "(${CHOICES_BRANCH[$i]:- }) ${COLOR_WHITE}$(($i+1))${COLOR_RESET}) ${BRANCHES[$i]}"
	done

	echo "$ERROR_IN_BRANCH_SELECTOR"
}


select_branche_to_test()
{
	while CLI_branche_selector && read -rp "Select the branch with its number, ${COLOR_WHITE}[Enter]${COLOR_RESET} to validate: " NUM && [[ "$NUM" ]]; do
		clear
		if [[ "$NUM" == *[[:digit:]]* && $NUM -ge 1 && $NUM -le ${#BRANCHES[@]} ]]; then
			((NUM--))
			for (( i = 0; i < ${#BRANCHES[@]}; i++ )); do
				if [[ $NUM -eq $i ]]; then
					CHOICES_BRANCH[$i]="${COLOR_GREEN}*${COLOR_RESET}"
				else
					CHOICES_BRANCH[$i]=""
				fi
			done

			ERROR_IN_BRANCH_SELECTOR=" "
		else
			ERROR_IN_BRANCH_SELECTOR="Invalid input: $NUM"
		fi
	done

	for (( i = 0; i < ${#BRANCHES[@]}; i++ )); do
		if [[ "${CHOICES_BRANCH[$i]}" == "${COLOR_GREEN}*${COLOR_RESET}" ]]; then
			BRANCH_TO_LOAD=$i
		fi
	done
}

trap dev_mode 2

dev_mode()
{
	reset
	echo "Welcome to the DEV mode."
	JSON_BRANCHES=$(curl https://api.github.com/repos/wamuu-sudo/orchid/branches)
	while IFS= read -r line
	do
		if [[ "$line" =~ ${REGEXP_BRANCHE} ]]; then
			BRANCHES+=(${BASH_REMATCH[1]})
		fi
	done <<< "$JSON_BRANCHES"
	select_branche_to_test
	wget "https://raw.githubusercontent.com/wamuu-sudo/orchid/${BRANCHES[$BRANCH_TO_LOAD]}/install/install.sh" -O /root/install.sh
  chmod +x /root/install.sh
  /root/install.sh
  exit
}

ping_server() {
	if ping -c 1 -W 1 82.65.199.131 &> /dev/null
	then
		TEST_CONNECTION=1
	else
		TEST_CONNECTION=0
	fi
}

test_connection() {
	TEST_CONNECTION=0
	local TEST_ROUND=15

	while [ $TEST_CONNECTION -eq 0 ]  # This is orchid.juline.tech
	do

		echo -ne "$TEST_ROUND "

		ping_server

		if [ $TEST_ROUND -eq 0 ]
		then
			net-setup #Network tools of gentoo
			
			ping_server
			if [ $TEST_CONNECTION -eq 0 ]
			then
				TEST_ROUND=15
			fi
		fi
		let "TEST_ROUND-=1"
		sleep 1
	done
}

if [ "$(tty)" == "/dev/tty1" ]; then
    reset
    clear
    echo "Bienvenue, l'installation d'Orchid Linux va bientôt commencer."
    echo "Attente de la connection à internet."

    test_connection

    wget https://raw.githubusercontent.com/wamuu-sudo/orchid/main/install/install.sh -O /root/install.sh
    chmod +x /root/install.sh
    /root/install.sh
fi
