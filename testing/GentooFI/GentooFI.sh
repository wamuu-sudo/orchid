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
                       echo "$MDP" | sudo flathub install ${packages_flathub[*]}
                       for nom_de_paquet in "${!packages_flathub[@]}"; do
                           echo "$MDP" | sudo ln -s /var/lib/flatpak/exports/bin/${packages_flathub[$nom_de_paquet]} /usr/bin/$nom_de_paquet
                       done

                    fi
                   if [ "${#packages[*]}" -lt 1 ] && [ "${#packages_flathub[*]}" -lt 1 ] ; then
                       echo -e "${On_Red}Veuillez faire un choix et ressayer${Color_Off}" && ${FUNCNAME[1]}
             fi

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
echo -e "${On_Red}Choisissez le navigateur que vous voulez installer:${Color_Off}"
echo -e "${Red}"
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
        "1")  [[ -v packages[Google-Chrome] ]] && unset packages[Google-Chrome] || packages+=([Google-Chrome]=www-client/google-chrome)  && browser ;;
        "2")  [[ -v packages[Google-Chromium] ]] && unset packages[Google-Chromium] || packages+=([Google-Chromium]=www-client/chromium)  && browser ;;
        "3")  [[ -v packages_flathub[brave-flatpak] ]] && unset packages_flathub[brave-flatpak] || packages_flathub+=([brave-flatpak]=com.brave.Browser)  && browser ;;
        "4")  [[ -v packages[Vivaldi] ]] && unset packages[Vivaldi] || packages+=([Vivaldi]=www-client/vivaldi)  && browser ;;
        "5")  [[ -v packages["MS Edge"] ]] && unset packages["MS Edge"] || packages+=([MS Edge]=www-client/microsoft-edge)  && browser ;;
        "6")  [[ -v packages["Mozilla Firefox"] ]] && unset packages["Mozilla Firefox"] || packages+=([Mozilla Firefox]=www-client/firefox-bin)  && browser ;;
        "7")  [[ -v packages_flathub[librewolf_flatpak] ]] && unset packages_flathub[librewolf-flatpak] || packages_flathub+=([librewolf-flatpak]=io.gitlab.librewolf-community) && browser ;;
        "8")  [[ -v packages_flathub[tor-flatpak] ]] && unset packages_flathub[tor-flatpak] || packages_flathub+=([tor-flatpak]=com.github.micahflee.torbrowser-launcher) && browser ;;
        "9")  installation ;;
        "10") main_menu ;;
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
        "1")  [[ -v packages[OBS-Studio] ]] && unset packages[OBS-Studio] || packages+=([OBS-Studio]=media-video/obs-studio) && multimedia ;;
        "2")  [[ -v packages[MPD] ]] && unset packages[MPD] || packages+=([MPD]=media-sound/mpd) && multimedia ;;
        "3")  [[ -v packages[Feh] ]] && unset packages[Feh] ||  packages+=([Feh]=media-gfx/feh) && multimedia ;;
        "4")  [[ -v packages[GIMP] ]] && unset packages[GIMP] || packages+=([GIMP]=media-gfx/gimp) && multimedia ;;
        "5")  [[ -v packages[Krita] ]] && unset packages[Krita] || packages+=([Krita]=media-gfx/krita) && multimedia ;;
        "6")  [[ -v packages[MPV] ]] && unset packages[MPV] || packages+=([MPV]=media-video/mpv) && multimedia ;;
        "7")  [[ -v packages[Celluloid] ]] && unset packages[Celluloid] || packages+=([Celluloid]=media-video/celluloid) && multimedia ;;
        "8")  [[ -v packages[Youtube-dl] ]] && unset packages[Youtube-dl] || packages+=([Youtube-dl]=net-misc/youtube-dl) && multimedia ;;
        "9")  [[ -v packages[VLC] ]] && unset packages[VLC] || packages+=([VLC]=media-video/vlc) && multimedia ;;
        "10")  [[ -v packages[Blender] ]] && unset packages[Blender] || packages+=([Blender]=media-gfx/blender) && multimedia ;;
        "11")  [[ -v packages[Spotify] ]] && unset packages[Spotify] || packages+=([Spotify]=media-sound/spotify) && multimedia ;;
        "12")  [[ -v packages[Kdenlive] ]] && unset packages[Kdenlive] || packages+=([KdenLive]=kde-apps/kdenlive) && multimedia ;;
        "13") installation ;;
        "14") main_menu ;;
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
        "1")  [[ -v packages[Calibre] ]] && unset packages[Calibre] || packages+=([Calibre]=app-text/calibre) && utility ;;
        "2") [[ -v packages[Zathura] ]] && unset packages[Zathura] ||  packages+=([Zathura]="app-text/zathura app-text/zathura-meta") && utility ;;
        "3")  [[ -v packages[Ark] ]] && unset packages[Ark] || packages+=([Ark]=kde-apps/ark) && utility ;;
        "4")  [[ -v packages[File-Roller] ]] && unset packages[File-Roller] || packages+=([File-Roller]=app-arch/file-roller) && utility ;;
        "5") [[ -v packages[LXQT-archiver] ]] && unset packages[LXQT-archiver] ||  packages+=([LXQT-archiver]app-arch/lxqt-archiver) && utility ;;
        "6") [[ -v packages[XArchiver] ]] && unset packages[XArchiver] ||  packages+=([XArchiver]=app-arch/xarchiver) && utility ;;
        "7")  [[ -v packages[Dolphin] ]] && unset packages[Dolphin] || packages+=([Dolphin]=kde-apps/dolphin) && utility ;;
        "8")  [[ -v packages[PCMANFM] ]] && unset packages[PCMANFM] || packages+=([PCMANFM]=x11-misc/pcmanfm) && utility ;;
        "9") [[ -v packages[Thunar] ]] && unset packages[Thunar] ||  packages+=([Thunar]=xfce-base/thunar) && utility ;;
        "10")  [[ -v packages[Nautilus] ]] && unset packages[Nautilus] || packages+=([Nautilus]=gnome-base/nautilus) && utility ;;
        "11") installation ;;
        "12") main_menu ;;
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
    echo -e "${BPurple}"
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
        "1")  [[ -v packages[LibreOffice] ]] && unset packages[LibreOffice] || packages+=([LibreOffice]=app-office/libreoffice-bin) && office ;;
        "2")  [[ -v packages[Lyx] ]] && unset packages[Lyx] || packages+=([Lyx]app-office/lyx) && office ;;
        "3")  [[ -v packages[Scribus] ]] && unset packages[Scribus] || packages+=([Scribus]app-office/scribus) && office ;;
        "4")  [[ -v packages[Calligra] ]] && unset packages[Calligra] || packages+=([Calligra]=app-office/calligra) && office ;;
        "5") installation ;;
        "6") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && office ;;
    esac

    clear
}

#======================================================================= office ===#

#=== text_editors =================================================================#
# DESCRIPTION : Permet l'installation d'éditeurs de texte.

text_editors ()
{    # Affiche les choix possibles
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
    echo -e "11. Appliquer"
    echo -e "12. Retourner en arrière"
    echo -e "${On_Red}NOTE: Some of these tools look and feel ugly out of the box, please install a rice for the following tools (Optional but highly recommended): neovim(CodeArt or Nvchad) , vim (spacevim) , Emacs (doom emacs)${Color_Off}"
    echo -e ""
    packets_list
    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") packages+=([NVim]=app-editors/neovim) && text_editors ;;
        "2") packages+=([Vim]=app-office/vim) && text_editors ;;
        "3") packages+=([GVim]=app-editors/vim) && text_editors ;;
        "4") packages+=([Kate]=kde-apps/kate) && text_editors ;;
        "5") packages+=([Gedit]=app-editors/gedit) && text_editors ;;
        "6") packages+=([Emacs]=app-editors/emacs) && text_editors ;;
        "7") packages+=([VSCode]=app-editors/vscode) && text_editors ;;
        "8") packages+=([Bluefish]=app-editors/bluefish) && text_editors ;;
        "9") packages+=([Geany]=dev-util/geany) && text_editors ;;
        "10") packages+=([Vscodium]=app-editors/vscodium) && text_editors ;;
        "11") installation ;;
        "12") main_menu ;;
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
    echo -e "${On_Yellow}14. Appliquer"
    echo -e "15. Retourner en arrière${Color_Off}"
    echo -e ""
    packets_list
    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") packages+=([Alacritty]=x11-terms/alacritty) && system ;;
        "2") packages+=([Gnome-terminal]=x11-terms/gnome-terminal) && system ;;
        "3") packages+=([Kitty]=x11-terms/kitty) && system ;;
        "4") packages+=([Konsole]=kde-apps/konsole) && system ;;
        "5") packages+=([LXterminal]=lxde-base/lxterminal) && system ;;
        "6") packages+=([URXVT]=x11-terms/rxvt-unicode) && system ;;
        "7") packages+=([Terminator]=x11-terms/terminator) && system ;;
        "8") packages+=([Terminology]=x11-terms/terminology) && system ;;
        "9") packages+=([XFCE-Term]=x11-terms/xfce4-terminal) && system ;;
        "10") packages+=([Xterm]=x11-terms/xterm) && system ;;
        "11") packages+=([Baobab]=sys-apps/baobab) && system ;;
        "12") packages+=([Gparted]=sys-block/gparted) && system ;;
        "13") packages+=([OpenRGB]="app-misc/openrgb app-misc/openrgb-plugin-effects app-misc/openrgb-plugin-skin app-misc/openrgb-plugin-visualmap") ;;
        "14") installation ;;

        "15") main_menu ;;
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
    echo -e "8. Appliquer"
    echo -e "9. Retourner en arrière"
    echo -e ""
    packets_list
    read -r -p "[Saisissezvotre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") packages+=([Discord]=net-im/discord-bin) && com ;;
        "2") packages+=([Hexchat]=net-irc/hexchat) && com ;;
        "3") packages+=([Weechat]=net-irc/weechat) && com ;;
        "4") packages_flathub+=([Matrix-flatpak]=im.riot.Riot) && com ;;
        "5") packages+=([Deluge]=net-p2p/deluge) && com ;;
        "6") packages+=([Qbittorrent]=net-p2p/qbittorrent) && com ;;
        "7") packages+=([Transmission]=net-p2p/transmission) && com ;;
        "8") installation ;;
        "9") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && com ;;
    esac

    clear
}

#========================================================================== com ===#
#=== games ==========================================================================#
# DESCRIPTION : Permet l'installation d'applications liés aux jeux.
games ()
{
    # Affiche les choix possibles
    echo -e "${On_Green}Choisissez les jeux que vous voulez installer:${Color_Off}"
    echo -e "===Jeux d'action:==="
    echo -e "${BGreen}1.Chromium B.S.U."
    echo -e "2. Minetest"
    echo -e "3. SuperTuxKart"
    echo -e "===Jeux d'arcade:==="
    echo -e "4. Frozen Bubble"
    echo -e "5. Kobo Deluxe"
    echo -e "6. Open Sonic"
    echo -e "7. SolarWolf"
    echo -e "8. SuperTux"
    echo -e "9. TecnoballZ"
    echo -e "===Emulateurs de jeux:==="
    echo -e "10. DeSmuME"
    echo -e "11. Dolphin"
    echo -e "12. DOSBox"
    echo -e "13. Higan"
    echo -e "14. Mednafen"
    echo -e "15. mGBA"
    echo -e "16. Mupen64Plus"
    echo -e "17. PCSX-Reloaded"
    echo -e "18. VBA-M"
    echo -e "19. Yabause"
    echo -e "20. ZSNES"
    echo -e "===Jeux FPS:==="
    echo -e "21. Alien Arena"
    echo -e "22. Urban Terror"
    echo -e "23. Xonotic"
    echo -e "===Jeux RogueLike:==="
    echo -e "24. Dungeon Crawl Stone Soup"
    echo -e "25. TomeNET"
    echo -e "===Jeux RPG:==="
    echo -e "26. Daimonin"
    echo -e "27. FreedroidRPG"
    echo -e "28. Summoning Wars"
    echo -e "29. The Mana World"
    echo -e "===Jeux de Simulation:==="
    echo -e "30. FlightGear"
    echo -e "31. OpenTTD"
    echo -e "===Jeux de strategie:==="
    echo -e "32. 0 A.D."
    echo -e "33. Dune Legacy"
    echo -e "34. FreeCiv"
    echo -e "35. Hedgewars"
    echo -e "36. MegaGlest"
    echo -e "37. OpenRA"
    echo -e "38. UFO: Alien Invasion"
    echo -e "39. Warzone 2100"
    echo -e "40. Battle for Wesnoth Athenaeum"
    echo -e "===Launcheur de jeux:==="
    echo -e "41. Athenaeum ${Color_Ofow}"
    echo -e "42. Appliquer"
    echo -e "43. Retourner en arrière"
    echo -e ""
    echo -e "Pour plus d'options hésitez pas a check https://github.com/Chevek/Gaming-Flatpak"
    packets_list

    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") packages+=([Chromium-BSU]="games-action/chromium-bsu") && games ;;
        "2") packages+=([Minetest]="games-action/minetest") && games ;;
        "3") packages+=([Supertuxkart]="games-action/supertuxkart") && games ;;
        "4") packages+=([Forzen-bubble]="games-arcade/frozen-bubble") && games ;;
        "5") packages+=([Kobo-deluxe]="games-arcade/kobodeluxe") && games ;;
        "6") packages+=([Open-Sonic]="games-arcade/opensonic") && games ;;
        "7") packages+=([Solor-wolf]"games-arcade/solarwolf") && games ;;
        "8") packages+=([Supertux]="games-arcade/supertux") && games ;;
        "9") packages+=([TecnoBallz]"games-arcade/tecnoballz") && games ;;
        "10") packages+=([DesmuME]="games-emulation/desmume") && games ;;
        "11") packages+=([Dolphin-Emu]="games-emulation/dolphin") && games ;;
        "12") packages+=([DosBox]="games-emulation/dosbox") && games ;;
        "13") packages+=([Higan]="games-emulation/higan") && games ;;
        "14") packages+=([Mednafen]="games-emulation/mednafen") && games ;;
        "15") packages+=([mGBA]="games-emulation/mgba") && games ;;
        "16") packages+=([Mupen64Plus]="games-emulation/mupen64plus") && games ;;
        "17") packages+=([PCSXR]="games-emulation/pcsxr") && games ;;
        "18") packages+=([VBAm]="games-emulation/vbam") && games ;;
        "19") packages+=([Yabause]="games-emulation/yabause") && games ;;
        "20") packages+=([Znes]="games-emulation/zsnes") && games ;;
        "21") packages+=([Alien-Arena]="games-fps/alienarena") && games ;;
        "22") packages+=([Urban-terror]="games-fps/urbanterror") && games ;;
        "23") packages+=([Xonotic]="games-fps/xonotic") && games ;;
        "24") packages+=([Dungeon-CrawlStone-soup]="games-roguelike/stone-soup") && games ;;
        "25") packages+=([TomeNET]="games-roguelike/tomenet") && games ;;
        "26") packages+=([Daimonin]="games-rpg/daimonin-client") && games ;;
        "27") packages+=([Freedroidrpg]="games-rpg/freedroidrpg") && games ;;
        "28") packages+=([Summoning-Wars]="games-rpg/sumwars") && games ;;
        "29") packages+=([The-Mana-World]="games-rpg/manaplus") && games ;;
        "30") packages+=([Flight-Gear]="games-simulation/flightgear") && games ;;
        "31") packages+=([OpenTTD]="games-simulation/openttd") && games ;;
        "32") packages+=([0.AD]="games-strategy/0ad") && games ;;
        "33") packages+=([Dune-Legacy]="games-strategy/dunelegacy") && games ;;
        "34") packages+=([FreeCIV]="games-strategy/freeciv") && games ;;
        "35") packages+=([HedgeWars]="games-strategy/hedgewars") && games ;;
        "36") packages+=([Megaglest]="games-strategy/megaglest") && games ;;
        "37") packages+=([OpenRA]="games-strategy/openra") && games ;;
        "38") packages+=([UFO-Alien-Invasion]="games-strategy/ufoai") && games ;;
        "39") packages+=([Warzone-2100]="games-strategy/warzone2100") && games ;;
        "40") packages+=([Wesnoth]="games-strategy/wesnoth") && games ;;
        "41") packages_flathub+=([athenaeum-flatpak]=com.gitlab.librebob.Athenaeum) && games ;;
        "42") installation ;;
        "43") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo -e "Veuillez choisir une option valide :D!!" && games ;;
    esac

    clear
}

#=== games ==========================================================================#

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
        *) echo -e "${On_Red}Veuillez choisir une option valide :D!!${Color_Off}" && main_menu ;;
    esac
}

#==================================================================== main_menu ===#

#============================================================== PRECONFIGURATION ===

#=== MAIN ==========================================================================

clear && main_menu

#========================================================================== MAIN ===
