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
    echo "Veuillez lancer le script en tant que root D: (soit avec sudo, doas ou su)"
    exit 1
fi

#-----------------------------------------------------------------------------------
cp -rf Desktop/* /usr/share/applications/

# Setup functions
#===================================================================================

#=== browser ======================================================================#
# DESCRIPTION : Permet la sélection et l'installation D'un ou plusieurs navigateurs
#               Web.

browser ()
{
    # Affiche les choix possibles
    echo "Choisissez le navigateur que vous voulez installer:"
    echo "1. Chrome"
    echo "2. Blue Chrome (chromium)"
    echo "3. Orange Chrome (brave)"
    echo "4. Red Chrome (vivaldi)"
    echo "5. Microsoft Chrome (edge)"
    echo "6. Firefox .__."
    echo "7. Firefox mais blue (librewolf)"
    echo "8. Un Onion (tor browser)"
    echo "9. Retourner en arrière"
    echo ""
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
        *) echo "Veuillez choisir une option valide :D!!" && browser ;;
    esac

    clear
}

#====================================================================== browser ===#

#=== multimedia ===================================================================#
# DESCRIPTION : Permet l'installation d'applications multimédia.

multimedia ()
{
    # Affiche les choix possibles
    echo "Choisissez l'outil que vous voulez installer:"
    echo "1. OBS Studio"
    echo "2. MPD"
    echo "3. Feh"
    echo "4. GIMP"
    echo "5. Krita"
    echo "6. MPV"
    echo "7. Celluloid(MPV GTK GUI)"
    echo "8. youtube-dl(CLI)"
    echo "9. VLC"
    echo "10. Blender"
    echo "11. Spotify"
    echo "12. Retourner en arrière"
    echo ""
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
        "12") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo "Veuillez choisir une option valide :D!!" && multimedia ;;
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
    echo "Choisissez l'outil que vous voulez installer:"
    echo "===Document Readers:==="
    echo "1. Calibre"
    echo "2. Zathura"
    echo "===Archive management:==="
    echo "3. Ark"
    echo "4. File-roller"
    echo "5. LXQT Archiver"
    echo "6. Xarchiver"
    echo "===File management:==="
    echo "7. Dolphin"
    echo "8. PCMANFM"
    echo "9. Thunar"
    echo "10. Nautilus"
    echo "11. Retourner en arrière"
    echo ""
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
        *) echo "Veuillez choisir une option valide :D!!" && utility ;;
    esac

    clear
}

#====================================================================== utility ===#

#=== office =======================================================================#
# DESCRIPTION : Permet l'installation d'applications de bureautique.

office ()
{
    # Affiche les choix possibles
    echo "Choisissez l'outil que vous voulez installer:"
    echo "1. LibreOffice"
    echo "2. Lyx"
    echo "3. Scribus"
    echo "4. Calligra"
    echo "5. Retourner en arrière"
    echo ""
    read -r -p "[Saisissez votre choix]: "  choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install app-office/libreoffice-bin && office ;;
        "2") orchid-install app-office/lyx && office ;;
        "3") orchid-install app-office/scribus && office ;;
        "4") orchid-install app-office/calligra && office ;;
        "5") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo "Veuillez choisir une option valide :D!!" && office ;;
    esac

    clear
}

#======================================================================= office ===#

#=== text_editors =================================================================#
# DESCRIPTION : Permet l'installation d'éditeurs de texte.

text_editors ()
{
    # Affiche les choix possibles
    echo "Choisissez l'outil que vous voulez installer:"
    echo "===CLI:==="
    echo "1. Neovim"
    echo "2. Vim"
    echo "===GUI:==="
    echo "3. GVIM"
    echo "4. Kate"
    echo "5. Gedit"
    echo "6. Emacs"
    echo "===IDEs==="
    echo "7. Vscode"
    echo "8. Bluefish"
    echo "9. Geany"
    echo "10. Vscodium"
    echo "11. Retourner en arrière"
    echo "NOTE: Some of these tools look and feel ugly out of the box, please install a rice for the following tools (Optional but highly recommended): neovim(CodeArt or Nvchad) , vim (spacevim) , Emacs (doom emacs)"
    echo ""
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
        *) echo "Veuillez choisir une option valide :D!!" && text_editors ;;
    esac

    clear
}

#================================================================= text_editors ===#

#=== system =======================================================================#
# DESCRIPTION : Permet l'installation d'outils liés au système.

system ()
{
    # Affiche les choix possibles
    echo "Choisissez l'outil que vous voulez installer:"
    echo "===Terminals:==="
    echo "1. alacritty"
    echo "2. Gnome terminal"
    echo "3. Kitty"
    echo "4. Konsole"
    echo "5. Lxterminal"
    echo "6. rxvt unicode (urxvt)"
    echo "7. Terminator"
    echo "8. Terminology"
    echo "9. XFCE4-terminal"
    echo "10. Xterm"
    echo "===Utilities:==="
    echo "11. Baobab (disk usage analyzer)"
    echo "12. GParted"
    echo "13. Retourner en arrière"
    echo ""
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
        "13") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo "Veuillez choisir une option valide :D!!" && system ;;
    esac

    clear
}

#======================================================================= system ===#

#=== com ==========================================================================#
# DESCRIPTION : Permet l'installation d'applications liés aux comunications.
com ()
{
    # Affiche les choix possibles
    echo "Choisissez l'outil que vous voulez installer:"
    echo "1. Discord"
    echo "2. HexChat"
    echo "3. Weechat"
    echo "4. Matrix"
    echo "5. Deluge"
    echo "6. Qbittorrent"
    echo "7. Transmission"
    echo "8. Retourner en arrière"
    echo ""
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
        *) echo "Veuillez choisir une option valide :D!!" && com ;;
    esac

    clear
}

#========================================================================== com ===#

#=== main_menu ==================================
# DESCRIPTION : Affiche le menu sélectif trié par famille, pour installer des
#               applications.

main_menu()
{
    echo "Bienvenue au script post-installation orchid!"
    echo "Veuillez choisir votre destination:"
    echo ""
    echo "1. Navigateurs"
    echo "2. Multimedia"
    echo "3. Utilities"
    echo "4. Bureautiques"
    echo "5. Editeurs de texte"
    echo "6. System"
    echo "7. Communication & Internet things"
    echo "8. Quitter"
    echo ""
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
        "8") exit 1 ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo "Veuillez choisir une option valide :D!!" && main_menu ;;
    esac
}

#==================================================================== main_menu ===#

#============================================================== PRECONFIGURATION ===

#=== MAIN ==========================================================================

main_menu

#========================================================================== MAIN ===
