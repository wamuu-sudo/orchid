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

#=== PRECONFIGURATION ==============================================================

# Check for root rights
#-----------------------------------------------------------------------------------
if [ "$(id -u)" -ne 0 ] ; then
    echo -e "Veuillez lancer le script en tant que root D: (soit avec sudo, doas ou su)"
    exit 1
 fi
#-----------------------------------------------------------------------------------
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

#-----------------------------------------------------------------------------------
cp -rf Script_files/* /usr/share/applications/

# Setup functions
#===================================================================================

#=== browser ======================================================================#
# DESCRIPTION : Permet la sélection et l'installation D'un ou plusieurs navigateurs
#               Web.

browser ()
{
    # Affiche les choix possibles
    echo -e "${On_Red}Choisissez le navigateur que vous voulez installer:${Color_Off}"
    echo -e "${BRed}1. Chrome"
    echo -e "2. Blue Chrome (chromium)"
    echo -e "3. Orange Chrome (brave)"
    echo -e "4. Red Chrome (vivaldi)"
    echo -e "5. Microsoft Chrome (edge)"
    echo -e "6. Firefox .__."
    echo -e "7. Firefox mais blue (librewolf)"
    echo -e "8. Un Onion (tor browser)${Color_Off}"
    echo -e "9. Retourner en arrière"
    echo -e ""
    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1")  orchid-install www-client/google-chrome && browser ;;
        "2")  orchid-install www-client/chromium && browser ;;
        "3")  flatpak install flathub com.brave.Browser && browser ;;
        "4")  orchid-install www-client/vivaldi && browser ;;
        "5")  orchid-install www-client/microsoft-edge && browser ;;
        "6")  orchid-install www-client/firefox-bin && browser ;;
        "7") flatpak install flathub io.gitlab.librewolf-community && browser ;;
        "8") flatpak install flathub com.github.micahflee.torbrowser-launcher && browser ;;
        "9") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && browser ;;
    esac

    clear
}

#====================================================================== browser ===#

#=== multimedia ===================================================================#
# DESCRIPTION : Permet l'installation d'applications multimédia.

multimedia ()
{
    # Affiche les choix possibles
    echo -e "Choisissez l'outil que vous voulez installer:"
    echo -e "1. OBS Studio"
    echo -e "2. MPD"
    echo -e "3. Feh"
    echo -e "4. GIMP"
    echo -e "5. Krita"
    echo -e "6. MPV"
    echo -e "7. Celluloid(MPV GTK GUI)"
    echo -e "8. youtube-dl(CLI)"
    echo -e "9. VLC"
    echo -e "10. Blender"
    echo -e "11. Spotify"
    echo -e "12. Kdenlive"
    echo -e "13. Retourner en arrière"
    echo -e ""
    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install media-video/obs-studio && multimedia ;;
        "2") orchid-install media-sound/mpd && multimedia ;;
        "3") orchid-install media-gfx/feh && multimedia ;;
        "4") orchid-install media-gfx/gimp && multimedia ;;
        "5") orchid-install media-gfx/krita && multimedia ;;
        "6") orchid-install media-video/mpv && multimedia ;;
        "7") orchid-install media-video/celluloid && multimedia ;;
        "8") orchid-install net-misc/youtube-dl && multimedia ;;
        "9") orchid-install media-video/vlc && multimedia ;;
        "10") orchid-install media-gfx/blender && multimedia ;;
        "11") orchid-install media-sound/spotify && multimedia ;;
        "12") orchid-install kde-apps/kdenlive && multimedia ;;
        "13") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && multimedia ;;
    esac

    clear
}

#==================================================================== mutimedia ===#

#=== utility ======================================================================#
# DESCRIPTION : Permet l'installation d'applications utilitaires : Document Readers,
#               Gestionnaires d'archives et explorateurs de fichiers.

utility ()
{
    # Affiche les choix possibles
    echo -e "${On_Cyan}Choisissez l'outil que vous voulez installer:${Color_Off}"
    echo -e "${BCyan}===Document Readers:==="
    echo -e "1. Calibre"
    echo -e "2. Zathura"
    echo -e "===Archive management:==="
    echo -e "3. Ark"
    echo -e "4. File-roller"
    echo -e "5. LXQT Archiver"
    echo -e "6. Xarchiver"
    echo -e "===File management:==="
    echo -e "7. Dolphin"
    echo -e "8. PCMANFM"
    echo -e "9. Thunar"
    echo -e "10. Nautilus${Color_Off}"
    echo -e "11. Retourner en arrière"
    echo -e ""
    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install app-text/calibre && utility ;;
        "2") orchid-install app-text/zathura app-text/zathura-meta && utility ;;
        "3") orchid-install kde-apps/ark && utility ;;
        "4") orchid-install app-arch/file-roller && utility ;;
        "5") orchid-install app-arch/lxqt-archiver && utility ;;
        "6") orchid-install app-arch/xarcivher && utility ;;
        "7") orchid-install kde-apps/dolphin && utility ;;
        "8") orchid-install x11-misc/pcmanfm && utility ;;
        "9") orchid-install xfce-base/thunar && utility ;;
        "10") orchid-install gnome-base/nautilus && utility ;;
        "11") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && utility ;;
    esac

    clear
}

#====================================================================== utility ===#

#=== office =======================================================================#
# DESCRIPTION : Permet l'installation d'applications de bureautique.

office ()
{
    # Affiche les choix possibles
    echo -e "${On_Purple}Choisissez l'outil que vous voulez installer:${Color_Off}"
    echo -e "${BPurple}1. LibreOffice"
    echo -e "2. Lyx"
    echo -e "3. Scribus"
    echo -e "4. Calligra${Color_Off}"
    echo -e "5. Retourner en arrière"
    echo -e ""
    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install app-office/libreoffice-bin && office ;;
        "2") orchid-install app-office/lyx && office ;;
        "3") orchid-install app-office/scribus && office ;;
        "4") orchid-install app-office/calligra && office ;;
        "5") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && office ;;
    esac

    clear
}

#======================================================================= office ===#

#=== text_editors =================================================================#
# DESCRIPTION : Permet l'installation d'éditeurs de texte.

text_editors ()
{
    # Affiche les choix possibles
    echo -e "Choisissez l'outil que vous voulez installer:"
    echo -e "===CLI:==="
    echo -e "1. Neovim"
    echo -e "2. Vim"
    echo -e "===GUI:==="
    echo -e "3. GVIM"
    echo -e "4. Kate"
    echo -e "5. Gedit"
    echo -e "6. Emacs"
    echo -e "===IDEs==="
    echo -e "7. Vscode"
    echo -e "8. Bluefish"
    echo -e "9. Geany"
    echo -e "10. Vscodium"
    echo -e "11. Retourner en arrière"
    echo -e "${On_Red}NOTE: Some of these tools look and feel ugly out of the box, please install a rice for the following tools (Optional but highly recommended): neovim(CodeArt or Nvchad) , vim (spacevim) , Emacs (doom emacs)${Color_Off}"
    echo -e ""
    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install app-editors/neovim && text_editors ;;
        "2") orchid-install app-office/vim && text_editors ;;
        "3") orchid-install app-editors/vim && text_editors ;;
        "4") orchid-install kde-apps/kate && text_editors ;;
        "5") orchid-install app-editors/gedit && text_editors ;;
        "6") orchid-install app-editors/emacs && text_editors ;;
        "7") orchid-install app-editors/vscode && text_editors ;;
        "8") orchid-install app-editors/bluefish && text_editors ;;
        "9") orchid-install dev-util/geany && text_editors ;;
        "10") orchid-install app-editors/vscodium && text_editors ;;
        "11") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && text_editors ;;
    esac

    clear
}

#================================================================= text_editors ===#

#=== system =======================================================================#
# DESCRIPTION : Permet l'installation d'outils liés au système.

system ()
{
    # Affiche les choix possibles
    echo -e "${On_Yellow}Choisissez l'outil que vous voulez installer:${Color_Off}"
    echo -e "${BYellow}===Terminals:==="
    echo -e "1. alacritty"
    echo -e "2. Gnome terminal"
    echo -e "3. Kitty"
    echo -e "4. Konsole"
    echo -e "5. Lxterminal"
    echo -e "6. rxvt unicode (urxvt)"
    echo -e "7. Terminator"
    echo -e "8. Terminology"
    echo -e "9. XFCE4-terminal"
    echo -e "10. Xterm"
    echo -e "===Utilities:==="
    echo -e "11. Baobab (disk usage analyzer)"
    echo -e "12. GParted"
    echo -e "13. OpenRGB & Plugins${Color_Off}"
    echo -e "14. Retourner en arrière"
    echo -e ""
    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install x11-terms/alacritty && system ;;
        "2") orchid-install x11-terms/gnome-terminal && system ;;
        "3") orchid-install x11-terms/kitty && system ;;
        "4") orchid-install kde-apps/konsole && system ;;
        "5") orchid-install lxde-base/lxterminal && system ;;
        "6") orchid-install x11-terms/rxvt-unicode && system ;;
        "7") orchid-install x11-terms/terminator && system ;;
        "8") orchid-install x11-terms/terminology && system ;;
        "9") orchid-install x11-terms/xfce4-terminal && system ;;
        "10") orchid-install x11-terms/xterm && system ;;
        "11") orchid-install sys-apps/baobab && system ;;
        "12") orchid-install sys-block/gparted && system ;;
        "13") orchid-install app-misc/openrgb app-misc/openrgb-plugin-effects app-misc/openrgb-plugin-skin app-misc/openrgb-plugin-visualmap ;;
        "14") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && system ;;
    esac

    clear
}

#======================================================================= system ===#

#=== com ==========================================================================#
# DESCRIPTION : Permet l'installation d'applications liés aux comunications.
com ()
{
    # Affiche les choix possibles
    echo -e "${On_Green}Choisissez l'outil que vous voulez installer:${Color_Off}"
    echo -e "${BGreen}1. Discord"
    echo -e "2. HexChat"
    echo -e "3. Weechat"
    echo -e "4. Matrix"
    echo -e "5. Deluge"
    echo -e "6. Qbittorrent"
    echo -e "7. Transmission${Color_Ofow}"
    echo -e "8. Retourner en arrière"
    echo -e ""
    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install net-im/discord-bin && com ;;
        "2") orchid-install net-irc/hexchat && com ;;
        "3") orchid-install net-irc/weechat && com ;;
        "4") flatpak install flathub im.riot.Riot && com ;;
        "5") orchid-install net-p2p/deluge && com ;;
        "6") orchid-install net-p2p/qbittorrent && com ;;
        "7") orchid-install net-p2p/transmission && com ;;
        "8") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && com ;;
    esac

    clear
}

#========================================================================== com ===#

#=== main_menu ==================================
# DESCRIPTION : Affiche le menu sélectif trié par famille, pour installer des
#               applications.

main_menu()
{
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
    echo -e "${BRed}9. Quitter${Color_Off}"
    echo -e ""
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
        "8") echo "WIP" && main_menu ;;
        "9") exit 1 ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "${On_Red}Veuillez choisir une option valide :D!!${Color_Off}" && main_menu ;;
    esac
}

#==================================================================== main_menu ===#

#============================================================== PRECONFIGURATION ===

#=== MAIN ==========================================================================

clear && main_menu

#========================================================================== MAIN ===
