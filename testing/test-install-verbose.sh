#!/usr/bin/env bash

# echo """${INFO_VERBOSE}${COLOR_WHITE}Message d'info.${COLOR_RESET}
# ${ERROR_VERBOSE}${COLOR_WHITE}Message d'erreur.${COLOR_RESET}
# ${FUNCTION_VERBOSE}Fonction ${COLOR_WHITE}ce qu'elle fait.
# ${ok_verbose}Fonction ${COLOR_WHITE}ce qu'elle fait mais quand la tache est terminée.${COLOR_RESET}"""
# read

# Setup colors
#-----------------------------------------------------------------------------------
COLOR_YELLOW=$'\033[0;33m'
COLOR_GREEN=$'\033[0;32m'
COLOR_RED=$'\033[0;31m'
COLOR_LIGHTBLUE=$'\033[1;34m'
COLOR_WHITE=$'\033[1;37m'
COLOR_RESET=$'\033[0m'
#-----------------------------------------------------------------------------------

info_verbose()
{
  echo "[  ${COLOR_GREEN}+${COLOR_RESET}  ]  ${COLOR_WHITE}${1}.${COLOR_RESET}"
}


header_info_verbose()
{
  echo "[  ${COLOR_GREEN}*${COLOR_RESET}  ]  ${COLOR_WHITE}${1} :${COLOR_RESET}"
}


smaller_info_verbose()
{
  echo "[  ${COLOR_GREEN}-${COLOR_RESET}  ]    ${COLOR_WHITE}${1}.${COLOR_RESET}"
}
error_verbose()
{
  echo "[  ${COLOR_RED}*${COLOR_RESET}  ]  ${COLOR_WHITE}${1}.${COLOR_RESET}"
}


function_verbose()
{
  echo "          ${1} ${COLOR_WHITE}${2}.${COLOR_RESET}"
}


ok_verbose()
{
  echo "[  ${COLOR_GREEN}OK${COLOR_RESET}  ]  ${1} ${COLOR_WHITE}${2}.${COLOR_RESET}"
}


smaller_ok_verbose()
{
  echo "[  ${COLOR_GREEN}OK${COLOR_RESET}  ]    ${1} ${COLOR_WHITE}${2}.${COLOR_RESET}"
}


warning_verbose()
{
  read -p "[  ${COLOR_YELLOW}!${COLOR_RESET}  ]  ${COLOR_YELLOW}${1}.${COLOR_RESET}"
}


pause()
{
  read -p "[  ${COLOR_WHITE}|${COLOR_RESET}  ]  ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer."
}

function_verbose "Setup" "variables"
sleep 0.5
function_verbose "Setup" "functions"
sleep 0.5
function_verbose "Check" "Internet access"
sleep 0.1
ok_verbose "Check" "Internet access"
info_verbose "Setup keyboard to (fr)"
echo ""
info_verbose "Orchid Linux va s'installer sur ${COLOR_GREEN}CHOOSEN_DISK : CHOOSEN_DISK_LABEL"
warning_verbose "                                  ^^ ! ATTENTION ! Toutes les données sur ce disque seront effacées !"
header_info_verbose "Préparation pour le partitionnement"
smaller_info_verbose "Le démarrage du système d'exploitation est de type ROM"
smaller_info_verbose "Votre RAM a une taille de RAM_SIZE_GB Go"
pause
smaller_info_verbose "Setup SWAP size"
header_info_verbose "Users creation"
smaller_info_verbose "Main user"
smaller_ok_verbose "Password" "user"
smaller_info_verbose "Root user"
smaller_ok_verbose "Password" "root"
smaller_ok_verbose "Hostname" ""



read
