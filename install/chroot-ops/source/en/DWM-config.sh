# Contributeurs :
#  - Babilinx : code
#  - Chevek : code
#  - Wamuu : vérifications et test
# mars 2022
# Script de configuration de DWM
#
#Copyright (C) 2022 Babilinx, Wamuu-sudo
#This program is free software: you can redistribute it and/or modify it under
#the terms of the GNU General Public License as published by the Free Software
#Foundation, either version 3 of the License, or (at your option) any later
#version.
#This program is distributed in the hope that it will be useful, but WITHOUT
#ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#You should have received a copy of the GNU General Public License along with
#this program. If not, see https://www.gnu.org/licenses/.

# Initialisation des couleurs
COLOR_YELLOW=$'\033[0;33m'
COLOR_GREEN=$'\033[0;32m'
COLOR_RED=$'\033[0;31m'
COLOR_LIGHTBLUE=$'\033[1;34m'
COLOR_WHITE=$'\033[1;37m'
COLOR_RESET=$'\033[0m'
echo "${COLOR_GREEN}*${COLOR_RESET} Configuration de DWM."
runuser -l $1 -c "/usr/share/orchid/fonts/applyorchidfonts"
runuser -l $1 -c "/usr/share/orchid/desktop/dwm/set-dwm"

