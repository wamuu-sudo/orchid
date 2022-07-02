#!/usr/bin/env bash
#===================================================================================
#
# FILE : GantooFI.sh
#
# USAGE : su -
#         ./GentooFI.sh
#
# DESCRIPTION : Script d'installation d'applications pour Orchid Linux.
#
# BUGS : ---
# NOTES : ---
# CONTRUBUTORS : Babilinx, Chevek, Crystal, Wamuu
# CREATED : avril 2022
# REVISION: 18 avril 2022
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
#===Prérequis================================================================================
# On demande le mot de passe root :
read -s -r -p "Veuillez entrer le mot de passe sudo afin de continuer: " MDP
# declarer le array en associatif
declare -A packages_flathub
declare -A packages
#===================================================================================


# Setting Color Variables
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

BG_BLACK="$(tput setab 0)"
BG_GREEN="$(tput setab 2)"
FG_GREEN="$(tput setaf 2)"
FG_WHITE="$(tput setaf 7)"

TEXT_BOLD="$(tput bold)"
TEXT_DIM="$(tput dim)"
TEXT_REV="$(tput rev)"
TEXT_DEFAULT="$(tput sgr0)"

INSTALLER_STEPS="Script de Post installation Orchid linux"

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
TEXT_LINE_START=0	# the banner is at the top
while IFS= read -r TEXT; do
	for l in "${TEXT[@]}"; do
		BANNER_COL_CENTER=$(( $LOGO_COLS + (($TERM_COLS - $LOGO_COLS - ${#l} ) / 2) ))
		tput cup $TEXT_LINE_START $BANNER_COL_CENTER
		echo "${l}"
		((TEXT_LINE_START++))
	done
done <<< "${BANNER}"
}

echo_logo()
{
cat <<- _EOF_
              ::              
            :*@@*:            
          :*@@@@@@*:          
         *@@@%++%@@@*         
      :=:-#@@+  +@@#-:=:      
    :*@@@#--#@==@#--#@@@*:    
  :*@@@%*%@*-=::=-#@%*%@@@*:  
 =@@@%@:  =+*    *+=  :@%@@@= 
  :*@@@%*%@*-=::=-#@%*%@@@*:  
    :*@@@#--#@==@#--#@@@*:    
      :=:-#@@+  +@@#-:=:      
         *@@@%++%@@@*         
          :*@@@@@@*:          
            :*@@*:            
              ::              
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

#-----------------------------------------------------------------------------------
cp -rf Script_files/* ~/Desktop/

# Setup functions
#===================================================================================
installation ()
{
    echo -e "${On_Red}If the installation looks stuck...it isn't , go grab a coffee , a tea, a vodka, maybe even some wine and do NOT panic ${Color_Off}"
    if [ "${#packages[*]}" -ge 1 ]; then
        echo "$MDP" | sudo -S emerge -q --autounmask-write --autounmask=y  ${packages[*]}
    fi
    
    if [ "${#packages_flathub[*]}" -ge 1 ]; then
        echo "$MDP" | sudo flatpak install --assumeyes --noninteractive flathub install ${packages_flathub[*]}
        for nom_de_paquet in "${!packages_flathub[@]}"; do
            echo "$MDP" | sudo ln -s /var/lib/flatpak/exports/bin/${packages_flathub[$nom_de_paquet]} /usr/bin/$nom_de_paquet
        done
    fi
    
    if [ "${#packages[*]}" -lt 1 ] && [ "${#packages_flathub[*]}" -lt 1 ] ; then
    echo -e "${On_Red}Veuillez faire un choix et ressayer${Color_Off}" && ${FUNCNAME[1]}
    fi
}
packets_select ()
{
    [[ -v packages[$1] ]] && unset packages[$1] || packages+=([$1]=$2)
}
packets_select_fp ()
{
      [[ -v packages_flathub[$1] ]] && unset packages_flathub[$1] || packages_flathub+=([$1]=$2)
}
packets_list ()
{
    echo -e "Votre panier ($((${#packages[@]} + ${#packages_flathub[@]}))) : ${!packages[*]} ${!packages_flathub[*]}"
}
#=== browser ======================================================================#
# DESCRIPTION : Permet la sélection et l'installation D'un ou plusieurs navigateurs
#               Web.

browser ()
{
    draw_installer_steps
    echo -e "${On_Red}Choisissez le navigateur que vous voulez installer:${Color_Off}"
    echo -e "${BRed}"
   [[ -v packages[Google-Chrome] ]] && echo -n "[+] " || echo -n "[] " && echo -e "1. Chrome"
   [[ -v packages[Google-Chromium] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "2. Blue Chrome (chromium)"
   [[ -v packages_flathub[brave-flatpak] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "3. Orange Chrome (brave)"
   [[ -v packages[Vivaldi] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "4. Red Chrome (vivaldi)"
   [[ -v packages["MS Edge"] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "5. Microsoft Chrome (edge)"
   [[ -v packages["Mozilla Firefox"] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "6. Firefox .__."
   [[ -v packages_flathub[librewolf-flatpak] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "7. Firefox mais blue (librewolf)"
   [[ -v packages[tor-flatpak] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "8. Un Onion (tor browser)${Color_Off}"
    echo -e "9. Appliquer"
    echo -e "10. Revenir en Arriére"
    echo -e ""
    packets_list
    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1")  packets_select Google-Chrome www-client/google-chrome  && clear && browser ;;
        "2")  packets_select Google-Chromium www-client/chromium  && clear && browser ;;
        "3")  packets_select_fp brave-flatpak com.brave.Browser  && clear && browser ;;
        "4")  packets_select Vivaldi www-client/vivaldi  && clear && browser ;;
        "5")  packets_select MS-Edge www-client/microsoft-edge  && clear && browser ;;
        "6")  packets_select Mozilla-Firefox www-client/firefox-bin  && clear && browser ;;
        "7")  packets_select_fp librewolf-flatpak io.gitlab.librewolf-community && clear && browser ;;
        "8") packets_select_fp tor-flatpak com.github.micahflee.torbrowser-launcher && clear && browser ;;
        "9")  installation ;;
        "10") clear && main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && clear && browser ;;
    esac
    clear
}

#====================================================================== browser ===#

#=== multimedia ===================================================================#
# DESCRIPTION : Permet l'installation d'applications multimédia.

multimedia ()
{
    draw_installer_steps
    # Affiche les choix possibles
    echo -e "Choisissez l'outil que vous voulez installer:"
 [[ -v packages[OBS-Studio] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "1. OBS Studio"
 [[ -v packages[MPD] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "2. MPD"
 [[ -v packages[Feh] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "3. Feh"
 [[ -v packages[GIMP] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "4. GIMP"
 [[ -v packages[Krita] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "5. Krita"
 [[ -v packages[MPV] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "6. MPV"
 [[ -v packages[Celluloid] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "7. Celluloid(MPV GTK GUI)"
 [[ -v packages[Youtube-dl] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "8. youtube-dl(CLI)"
 [[ -v packages[VLC] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "9. VLC"
 [[ -v packages[Blender] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "10. Blender"
 [[ -v packages[Spotify] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "11. Spotify"
 [[ -v packages[Kdenlive] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "12. Kdenlive"

    echo -e "${On_Red}13. Appliquer"
    echo -e "14. Retourner en arrière${Color_Off}"
    echo -e ""
     packets_list
    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") packets_select OBS-Studio media-video/obs-studio && clear && multimedia ;;
        "2") packets_select MPD media-sound/mpd && clear && multimedia ;;
        "3") packets_select Feh media-gfx/feh && clear && multimedia ;;
        "4") packets_select GIMP media-gfx/gimp && clear && multimedia ;;
        "5") packets_select Krita media-gfx/krita && clear && multimedia ;;
        "6") packets_select MPV media-video/mpv && clear && multimedia ;;
        "7") packets_select Celluloid media-video/celluloid && clear && multimedia ;;
        "8") packets_select Youtube-dl net-misc/youtube-dl && clear && multimedia ;;
        "9") packets_select VLC media-video/vlc && clear && multimedia ;;
        "10") packets_select Blender media-gfx/blender && clear && multimedia ;;
        "11") packets_select Spotify media-sound/spotify && clear && multimedia ;;
        "12") packets_select KdenLive kde-apps/kdenlive && clear && multimedia ;;
        "13") installation ;;
        "14") clear && main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && clear && multimedia ;;
    esac

    clear
}

#==================================================================== mutimedia ===#

#=== utility ======================================================================#
# DESCRIPTION : Permet l'installation d'applications utilitaires : Document Readers,
#               Gestionnaires d'archives et explorateurs de fichiers.

utility ()
{
    draw_installer_steps
    # Affiche les choix possibles
    echo -e "${On_Cyan}Choisissez l'outil que vous voulez installer:${Color_Off}"
    echo -e "${BCyan}===Document Readers:==="
  [[ -v packages[Calibre] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "1. Calibre"
  [[ -v packages[Zathura] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "2. Zathura"
    echo -e "===Archive management:==="
  [[ -v packages[Ark] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "3. Ark"
  [[ -v packages[File-Roller] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "4. File-roller"
  [[ -v packages[LXQT-archiver] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "5. LXQT Archiver"
  [[ -v packages[XArchiver] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "6. Xarchiver"
    echo -e "===File management:==="
  [[ -v packages[Dolphin] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "7. Dolphin"
  [[ -v packages[PCMANFM] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "8. PCMANFM"
  [[ -v packages[Thunar] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "9. Thunar"
  [[ -v packages[Nautilus] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "10. Nautilus${Color_Off}"
    echo -e "${On_Cyan}11. Appliquer"
    echo -e "12. Retourner en arrière${Color_Off}"
    echo -e ""
    packets_list

    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") packets_select Calibre app-text/calibre && clear && utility ;;
        "2") packets_select Zathura "app-text/zathura app-text/zathura-meta" && clear && utility ;;
        "3") packets_select Ark kde-apps/ark && clear && utility ;;
        "4") packets_select File-Roller app-arch/file-roller && clear && utility ;;
        "5") packets_select LXQT-archiver app-arch/lxqt-archiver && clear && utility ;;
        "6") packets_select XArchiver app-arch/xarchiver && clear && utility ;;
        "7") packets_select Dolphin kde-apps/dolphin && clear && utility ;;
        "8") packets_select PCMANFM x11-misc/pcmanfm && clear && utility ;;
        "9") packets_select Thunar xfce-base/thunar && clear && utility ;;
        "10") packets_select Nautilus gnome-base/nautilus && clear && utility ;;
        "11") installation ;;
        "12") clear && main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && clear && utility ;;
    esac

    clear
}

#====================================================================== utility ===#

#=== office =======================================================================#
# DESCRIPTION : Permet l'installation d'applications de bureautique.

office ()
{
    draw_installer_steps
    # Affiche les choix possibles
    echo -e "${On_Purple}Choisissez l'outil que vous voulez installer:${Color_Off}"
   [[ -v packages[LibreOffice] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "1. LibreOffice"
   [[ -v packages[Lyx] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "2. Lyx"
   [[ -v packages[Scribus] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "3. Scribus"
   [[ -v packages[Calligra] ]] && echo -n "[+] " || echo -n "[] " &&   echo -e "4. Calligra${Color_Off}"
    echo -e "${On_Purple}5. Appliquer"
    echo -e "6. Retourner en arrière${Color_Off}"
    echo -e ""
    packets_list

    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") packets_select LibreOffice app-office/libreoffice-bin && clear && office ;;
        "2") packets_select Lyx app-office/lyx && clear && office ;;
        "3") packets_select Scribus app-office/scribus && clear && office ;;
        "4") packets_select Calligra app-office/calligra && clear && office ;;
        "5") installation ;;
        "6") clear && main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && clear && office ;;
    esac

    clear
}

#======================================================================= office ===#

#=== text_editors =================================================================#
# DESCRIPTION : Permet l'installation d'éditeurs de texte.

text_editors ()
{
    draw_installer_steps
    # Affiche les choix possibles
    echo -e "Choisissez l'outil que vous voulez installer:"
    echo -e "===CLI:==="
  [[ -v packages[NVim] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "1. Neovim"
  [[ -v packages[Vim] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "2. Vim"
    echo -e "===GUI:==="
  [[ -v packages[GVim] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "3. GVIM"
  [[ -v packages[Kate] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "4. Kate"
  [[ -v packages[Gedit] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "5. Gedit"
  [[ -v packages[Emacs] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "6. Emacs"
    echo -e "===IDEs==="
  [[ -v packages[VSCode] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "7. Vscode"
  [[ -v packages[Bluefish] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "8. Bluefish"
  [[ -v packages[Geany] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "9. Geany"
  [[ -v packages[Vscodium] ]] && echo -n "[+] " || echo -n "[] " &&    echo -e "10. Vscodium"
    echo -e "11. Appliquer"
    echo -e "12. Retourner en arrière"
    echo -e "${On_Red}NOTE: Some of these tools look and feel ugly out of the box, please install a rice for the following tools (Optional but highly recommended): neovim(CodeArt or Nvchad) , vim (spacevim) , Emacs (doom emacs)${Color_Off}"
    echo -e ""
     packets_list

    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") packets_select NVim app-editors/neovim && clear && text_editors ;;
        "2") packets_select Vim app-office/vim && clear && text_editors ;;
        "3") packets_select GVim app-editors/vim && clear && text_editors ;;
        "4") packets_select Kate kde-apps/kate && clear && text_editors ;;
        "5") packets_select Gedit app-editors/gedit && clear && text_editors ;;
        "6") packets_select Emacs app-editors/emacs && clear && text_editors ;;
        "7") packets_select VSCode app-editors/vscode && clear && text_editors ;;
        "8") packets_select Bluefish app-editors/bluefish && clear && text_editors ;;
        "9") packets_select Geany dev-util/geany && clear && text_editors ;;
        "10") packets_select Vscodium app-editors/vscodium && clear && text_editors ;;
        "11") installation ;;
        "12") clear && main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && clear && text_editors ;;
    esac

    clear
}

#================================================================= text_editors ===#

#=== system =======================================================================#
# DESCRIPTION : Permet l'installation d'outils liés au système.

system ()
{
  draw_installer_steps
    # Affiche les choix possibles
    echo -e "${On_Yellow}Choisissez l'outil que vous voulez installer:${Color_Off}"
    echo -e "${BYellow}===Terminals:==="
    [[ -v packages[Alacritty] ]] && echo -n "[*] " || echo -n "[] " && echo -e "1. alacritty"
    [[ -v packages[Gnome-terminal] ]] && echo -n "[*] " || echo -n "[] " && echo -e "2. Gnome terminal"
    [[ -v packages[Kitty] ]] && echo -n "[*] " || echo -n "[] " && echo -e "3. Kitty"
    [[ -v packages[Konsole] ]] && echo -n "[*] " || echo -n "[] " && echo -e "4. Konsole"
    [[ -v packages[LXterminal] ]] && echo -n "[*] " || echo -n "[] " && echo -e "5. Lxterminal"
    [[ -v packages[URXVT] ]] && echo -n "[*] " || echo -n "[] " && echo -e "6. rxvt unicode (urxvt)"
    [[ -v packages[Terminator] ]] && echo -n "[*] " || echo -n "[] " && echo -e "7. Terminator"
    [[ -v packages[Terminology] ]] && echo -n "[*] " || echo -n "[] " && echo -e "8. Terminology"
    [[ -v packages[XFCE-Term] ]] && echo -n "[*] " || echo -n "[] " && echo -e "9. XFCE4-terminal"
    [[ -v packages[Xterm] ]] && echo -n "[*] " || echo -n "[] " && echo -e "10. Xterm"
    echo -e "===Utilities:==="
    [[ -v packages[Baobab] ]] && echo -n "[*] " || echo -n "[] " && echo -e "11. Baobab (disk usage analyzer)"
    [[ -v packages[Gparted] ]] && echo -n "[*] " || echo -n "[] " && echo -e "12. GParted"
    [[ -v packages[OpenRGB] ]] && echo -n "[*] " || echo -n "[] " && echo -e "13. OpenRGB & Plugins${Color_Off}"
    echo -e "${On_Yellow}14. Appliquer"
    echo -e "15. Retourner en arrière${Color_Off}"
    echo -e ""
 packets_list

    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") packets_select Alacritty x11-terms/alacritty && clear && system ;;
        "2") packets_select Gnome-terminal x11-terms/gnome-terminal && clear && system ;;
        "3") packets_select Kitty x11-terms/kitty && clear && system ;;
        "4") packets_select Konsole kde-apps/konsole && clear && system ;;
        "5") packets_select LXterminal lxde-base/lxterminal && clear && system ;;
        "6") packets_select URXVT x11-terms/rxvt-unicode && clear && system ;;
        "7") packets_select Terminator x11-terms/terminator && clear && system ;;
        "8") packets_select Terminology x11-terms/terminology && clear && system ;;
        "9") packets_select XFCE-Term x11-terms/xfce4-terminal && clear && system ;;
        "10") packets_select Xterm x11-terms/xterm && clear && system ;;
        "11") packets_select Baobab sys-apps/baobab && clear && system ;;
        "12") packets_select Gparted sys-block/gparted && clear && system ;;
        "13") packets_select OpenRGB "app-misc/openrgb app-misc/openrgb-plugin-effects app-misc/openrgb-plugin-skin app-misc/openrgb-plugin-visualmap" && clear && system ;;
        "14") installation ;;

        "15") clear && main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && clear && system ;;
    esac

    clear
}

#======================================================================= system ===#

#=== com ==========================================================================#
# DESCRIPTION : Permet l'installation d'applications liés aux comunications.
com ()
{
  draw_installer_steps 
    # Affiche les choix possibles
    echo -e "${On_Green}Choisissez l'outil que vous voulez installer:${Color_Off}"
    echo -e "${BGreen}"
    [[ -v packages[Discord] ]] && echo -n "[*] " || echo -n "[] " && echo -e "1. Discord"
    [[ -v packages[Hexchat] ]] && echo -n "[*] " || echo -n "[] " && echo -e "2. HexChat"
    [[ -v packages[Weechat] ]] && echo -n "[*] " || echo -n "[] " && echo -e "3. Weechat"
    [[ -v packages_flathub[Matrix-flatpak] ]] && echo -n "[*] " || echo -n "[] " && echo -e "4. Matrix"
    [[ -v packages[Deluge] ]] && echo -n "[*] " || echo -n "[] " && echo -e "5. Deluge"
    [[ -v packages[Qbittorrent] ]] && echo -n "[*] " || echo -n "[] " && echo -e "6. Qbittorrent"
    [[ -v packages[Transmission] ]] && echo -n "[*] " || echo -n "[] " && echo -e "7. Transmission${Color_Ofow}"
    echo -e "8. Appliquer"
    echo -e "9. Retourner en arrière"
    echo -e ""
     packets_list

    read -r -p "[Saisissezvotre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") packets_select Discord net-im/discord-bin && clear && com ;;
        "2") packets_select Hexchat net-irc/hexchat && clear && com ;;
        "3") packets_select Weechat net-irc/weechat && clear && com ;;
        "4") packets_select_fp Matrix-flatpak im.riot.Riot && clear && com ;;
        "5") packets_select Deluge net-p2p/deluge && clear && com ;;
        "6") packets_select Qbittorrent net-p2p/qbittorrent && clear && com ;;
        "7") packets_select Transmission net-p2p/transmission && clear && com ;;
        "8") installation ;;
        "9") clear && main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && clear && com ;;
    esac

    clear
}

#========================================================================== com ===#
#=== games ==========================================================================#
# DESCRIPTION : Permet l'installation d'applications liés aux jeux.
games ()
{   
    draw_installer_steps
    # Affiche les choix possibles
    echo -e "${On_Green}Choisissez les jeux que vous voulez installer:${Color_Off}"
    echo -e "===Jeux d'action:==="
    [[ -v packages[Chromium-BSU] ]] && echo -n "[*] " || echo -n "[] " && echo -e "${BGreen}1.Chromium B.S.U."
    [[ -v packages[Minetest] ]] && echo -n "[*] " || echo -n "[] " && echo -e "2. Minetest"
    [[ -v packages[Supertuxkart] ]] && echo -n "[*] " || echo -n "[] " && echo -e "3. SuperTuxKart"
    echo -e "===Jeux d'arcade:==="
    [[ -v packages[Frozen-bubble] ]] && echo -n "[*] " || echo -n "[] " && echo -e "4. Frozen Bubble"
    [[ -v packages[Kobo-deluxe] ]] && echo -n "[*] " || echo -n "[] " && echo -e "5. Kobo Deluxe"
    [[ -v packages[Open-Sonic] ]] && echo -n "[*] " || echo -n "[] " && echo -e "6. Open Sonic"
    [[ -v packages[Solor-wolf] ]] && echo -n "[*] " || echo -n "[] " && echo -e "7. SolarWolf"
    [[ -v packages[Supertux] ]] && echo -n "[*] " || echo -n "[] " && echo -e "8. SuperTux"
    [[ -v packages[TecnoBallz] ]] && echo -n "[*] " || echo -n "[] " && echo -e "9. TecnoballZ"
    echo -e "===Emulateurs de jeux:==="
    [[ -v packages[DesmuME] ]] && echo -n "[*] " || echo -n "[] " && echo -e "10. DeSmuME"
    [[ -v packages[Dolphin] ]] && echo -n "[*] " || echo -n "[] " && echo -e "11. Dolphin"
    [[ -v packages[DosBox] ]] && echo -n "[*] " || echo -n "[] " && echo -e "12. DOSBox"
    [[ -v packages[Higan] ]] && echo -n "[*] " || echo -n "[] " && echo -e "13. Higan"
    [[ -v packages[Mednafen] ]] && echo -n "[*] " || echo -n "[] " && echo -e "14. Mednafen"
    [[ -v packages[mGBA] ]] && echo -n "[*] " || echo -n "[] " && echo -e "15. mGBA"
    [[ -v packages[Mupen64Plus] ]] && echo -n "[*] " || echo -n "[] " && echo -e "16. Mupen64Plus"
    [[ -v packages[PCSXR] ]] && echo -n "[*] " || echo -n "[] " && echo -e "17. PCSX-Reloaded"
    [[ -v packages[VBAm] ]] && echo -n "[*] " || echo -n "[] " && echo -e "18. VBA-M"
    [[ -v packages[Yabause] ]] && echo -n "[*] " || echo -n "[] " && echo -e "19. Yabause"
    [[ -v packages[Znes] ]] && echo -n "[*] " || echo -n "[] " && echo -e "20. ZSNES"
    echo -e "===Jeux FPS:==="
    [[ -v packages[Alien-Arena] ]] && echo -n "[*] " || echo -n "[] " && echo -e "21. Alien Arena"
    [[ -v packages[Urban-terror] ]] && echo -n "[*] " || echo -n "[] " && echo -e "22. Urban Terror"
    [[ -v packages[Xonotic] ]] && echo -n "[*] " || echo -n "[] " && echo -e "23. Xonotic"
    echo -e "===Jeux RogueLike:==="
    [[ -v packages[Dungeon-CrawlStone-soup] ]] && echo -n "[*] " || echo -n "[] " && echo -e "24. Dungeon Crawl Stone Soup"
    [[ -v packages[TomeNET] ]] && echo -n "[*] " || echo -n "[] " && echo -e "25. TomeNET"
    echo -e "===Jeux RPG:==="
    [[ -v packages[Daimonin] ]] && echo -n "[*] " || echo -n "[] " && echo -e "26. Daimonin"
    [[ -v packages[Freedroidrpg] ]] && echo -n "[*] " || echo -n "[] " && echo -e "27. FreedroidRPG"
    [[ -v packages[Summoning-Wars] ]] && echo -n "[*] " || echo -n "[] " && echo -e "28. Summoning Wars"
    [[ -v packages[The-Mana-World] ]] && echo -n "[*] " || echo -n "[] " && echo -e "29. The Mana World"
    echo -e "===Jeux de Simulation:==="
    [[ -v packages[Flight-Gear] ]] && echo -n "[*] " || echo -n "[] " && echo -e "30. FlightGear"
    [[ -v packages[OpenTTD] ]] && echo -n "[*] " || echo -n "[] " && echo -e "31. OpenTTD"
    echo -e "===Jeux de strategie:==="
    [[ -v packages[0.AD] ]] && echo -n "[*] " || echo -n "[] " && echo -e "32. 0 A.D."
    [[ -v packages[Dune-Legacy] ]] && echo -n "[*] " || echo -n "[] " && echo -e "33. Dune Legacy"
    [[ -v packages[FreeCIV] ]] && echo -n "[*] " || echo -n "[] " && echo -e "34. FreeCiv"
    [[ -v packages[HedgeWars] ]] && echo -n "[*] " || echo -n "[] " && echo -e "35. Hedgewars"
    [[ -v packages[Megaglest] ]] && echo -n "[*] " || echo -n "[] " && echo -e "36. MegaGlest"
    [[ -v packages[OpenRA] ]] && echo -n "[*] " || echo -n "[] " && echo -e "37. OpenRA"
    [[ -v packages[UFO-Alien-Invasion] ]] && echo -n "[*] " || echo -n "[] " && echo -e "38. UFO: Alien Invasion"
    [[ -v packages[Warzone-2100] ]] && echo -n "[*] " || echo -n "[] " && echo -e "39. Warzone 2100"
    [[ -v packages[Wesnoth] ]] && echo -n "[*] " || echo -n "[] " && echo -e "40. Battle for Wesnoth Athenaeum"
    echo -e "===Launcheur de jeux:==="
    [[ -v packages_flathub[NVIM] ]] && echo -n "[*] " || echo -n "[] " && echo -e "41. Athenaeum ${Color_Ofow}"
    echo -e "42. Appliquer"
    echo -e "43. Retourner en arrière"
    echo -e ""
    echo -e "Pour plus d'options hésitez pas a check https://github.com/Chevek/Gaming-Flatpak"
    packets_list

    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") packets_select Chromium-BSU "games-action/chromium-bsu" && clear && games ;;
        "2") packets_select Minetest "games-action/minetest" && clear && games ;;
        "3") packets_select Supertuxkart "games-action/supertuxkart" && clear && games ;;
        "4") packets_select Forzen-bubble "games-arcade/frozen-bubble" && clear && games ;;
        "5") packets_select Kobo-deluxe "games-arcade/kobodeluxe" && clear && games ;;
        "6") packets_select Open-Sonic "games-arcade/opensonic" && clear && games ;;
        "7") packets_select Solor-wolf"games-arcade/solarwolf" && clear && games ;;
        "8") packets_select Supertux "games-arcade/supertux" && clear && games ;;
        "9") packets_select TecnoBallz"games-arcade/tecnoballz" && clear && games ;;
        "10") packets_select DesmuME "games-emulation/desmume" && clear && games ;;
        "11") packets_select Dolphin "games-emulation/dolphin" && clear && games ;;
        "12") packets_select DosBox "games-emulation/dosbox" && clear && games ;;
        "13") packets_select Higan "games-emulation/higan" && clear && games ;;
        "14") packets_select Mednafen "games-emulation/mednafen" && clear && games ;;
        "15") packets_select mGBA "games-emulation/mgba" && clear && games ;;
        "16") packets_select Mupen64Plus "games-emulation/mupen64plus" && clear && games ;;
        "17") packets_select PCSXR "games-emulation/pcsxr" && clear && games ;;
        "18") packets_select VBAm "games-emulation/vbam" && clear && games ;;
        "19") packets_select Yabause "games-emulation/yabause" && clear && games ;;
        "20") packets_select Znes "games-emulation/zsnes" && clear && games ;;
        "21") packets_select Alien-Arena "games-fps/alienarena" && clear && games ;;
        "22") packets_select Urban-terror "games-fps/urbanterror" && clear && games ;;
        "23") packets_select Xonotic "games-fps/xonotic" && clear && games ;;
        "24") packets_select Dungeon-CrawlStone-soup "games-roguelike/stone-soup" && clear && games ;;
        "25") packets_select TomeNET "games-roguelike/tomenet" && clear && games ;;
        "26") packets_select Daimonin "games-rpg/daimonin-client" && clear && games ;;
        "27") packets_select Freedroidrpg "games-rpg/freedroidrpg" && clear && games ;;
        "28") packets_select Summoning-Wars "games-rpg/sumwars" && clear && games ;;
        "29") packets_select The-Mana-World "games-rpg/manaplus" && clear && games ;;
        "30") packets_select Flight-Gear "games-simulation/flightgear" && clear && games ;;
        "31") packets_select OpenTTD "games-simulation/openttd" && clear && games ;;
        "32") packets_select 0.AD "games-strategy/0ad" && clear && games ;;
        "33") packets_select Dune-Legacy "games-strategy/dunelegacy" && clear && games ;;
        "34") packets_select FreeCIV "games-strategy/freeciv" && clear && games ;;
        "35") packets_select HedgeWars "games-strategy/hedgewars" && clear && games ;;
        "36") packets_select Megaglest "games-strategy/megaglest" && clear && games ;;
        "37") packets_select OpenRA "games-strategy/openra" && clear && games ;;
        "38") packets_select UFO-Alien-Invasion "games-strategy/ufoai" && clear && games ;;
        "39") packets_select Warzone-2100 "games-strategy/warzone2100" && clear && games ;;
        "40") packets_select Wesnoth "games-strategy/wesnoth" && clear && games ;;
        "41") packets_select_fp athenaeum-flatpak com.gitlab.librebob.Athenaeum && clear && games ;;
        "42") installation ;;
        "43") clear && main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && clear && games ;;
    esac

    clear
}

#=== games ==========================================================================#
#=== clear && main_menu ==================================
# DESCRIPTION : Affiche le menu sélectif trié par famille, pour installer des
#               applications.

clear && main_menu()
{   
    draw_installer_steps
    echo -e "${Blue}Bienvenue au script post-installation orchid!${Color_Off}"
    echo -e "${Green}Veuillez choisir votre destination:${Color_Off}"
    echo -e ""
    echo -e "${Red}1. Navigateurs${Color_Off}"
    echo -e "2. Multimedia"
    echo -e "${Cyan}3. Utilities${Color_Off}"
    echo -e "${Purple}4. Bureautiques${Color_Off}"
    echo -e "5. Editeurs de texte"
    echo -e "${Yellow}6. System${Color_Off}"
    echo -e "${Green}7. Communication & Internet things${Color_Off}"
    echo -e "8. ${BRed}F${BBlack}o${BCyan}s${BPurple}s ${BWhite}G${BYellow}a${BGreen}m${BRed}e${BCyan}s${Color_Off}(WIP)"
    echo -e "9. Appliquer tout"
    echo -e "${BRed}10. Quitter${Color_Off}"
    echo -e ""
  packets_list

   read -r -p "[Saisissez votre choix]: "  choix
    clear
    case "$choix" in
        "1") browser ;;
        "2") multimedia ;;
        "3") utility ;;
        "4") office ;;
        "5") text_editors ;;
        "6") system ;;
        "7") com ;;
        "8") games ;;
        "9") installation ;;
        "10") exit 1 ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "${On_Red}Veuillez choisir une option valide :D!!${Color_Off}" && clear && main_menu ;;
    esac
}

#==================================================================== clear && main_menu ===#

#============================================================== PRECONFIGURATION ===

#=== MAIN ==========================================================================

trap set_term_size WINCH	# We trap window changing size to adapt our interface

clear && main_menu

#========================================================================== MAIN ===
