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
    echo "Veuillez lancer le script en tant que root  D: (soit avec sudo , doas ou su)"
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
    echo "[Saisissez votre choix:]"
    read -r choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1")  orchid-install www-client/google-chrome && main_menu ;;
        "2")  orchid-install www-client/chromium && main_menu ;;
        "3")  flatpak install flathub com.brave.Browser && main_menu ;;
        "4")  orchid-install www-client/vivaldi && main_menu ;;
        "5")  orchid-install www-client/microsoft-edge && main_menu ;;
        "6")  orchid-install www-client/firefox-bin && main_menu ;;
        "7") flatpak install flathub io.gitlab.librewolf-community && main_menu ;;
        "8") flatpak install flathub com.github.micahflee.torbrowser-launcher && main_menu ;;
        "9") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo "Veuillez choisir une option valide :D!!" && browser ;;
    esac
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
    echo "[Saisissez votre choix:]"
    read -r choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install media-video/obs-studio && main_menu ;;
        "2") orchid-install media-sound/mpd && main_menu ;;
        "3") orchid-install media-gfx/feh && main_menu ;;
        "4") orchid-install media-gfx/gimp && main_menu ;;
        "5") orchid-install media-gfx/krita && main_menu ;;
        "6") orchid-install media-video/mpv && main_menu ;;
        "7") orchid-install media-video/celluloid && main_menu ;;
        "8") orchid-install net-misc/youtube-dl && main_menu ;;
        "9") orchid-install media-video/vlc && main_menu ;;
        "10") orchid-install media-gfx/blender && main_menu ;;
        "11") orchid-install media-sound/spotify && main_menu ;;
        "12") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo "Veuillez choisir une option valide :D!!" && multimedia ;;
    esac
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
    echo "[Saisissez votre choix:]"
    read -r choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install app-text/calibre && main_menu ;;
        "2") orchid-install app-text/zathura app-text/zathura-meta && main_menu ;;
        "3") orchid-install kde-apps/ark && main_menu ;;
        "4") orchid-install app-arch/file-roller && main_menu ;;
        "5") orchid-install app-arch/lxqt-archiver && main_menu ;;
        "6") orchid-install app-arch/xarcivher && main_menu ;;
        "7") orchid-install kde-apps/dolphin && main_menu ;;
        "8") orchid-install x11-misc/pcmanfm && main_menu ;;
        "9") orchid-install xfce-base/thunar && main_menu ;;
        "10") orchid-install gnome-base/nautilus && main_menu ;;
        "11") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo "Veuillez choisir une option valide :D!!" && utility ;;
    esac
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
    echo "[Saisissez votre choix:]"
    read -r choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install app-office/libreoffice-bin && main_menu ;;
        "2") orchid-install app-office/lyx && main_menu ;;
        "3") orchid-install app-office/scribus && main_menu ;;
        "4") orchid-install app-office/calligra && main_menu ;;
        "5") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo "Veuillez choisir une option valide :D!!" && office ;;
    esac
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
    echo "[Saisissez votre choix:]"
    read -r choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install app-editors/neovim && main_menu ;;
        "2") orchid-install app-office/vim && main_menu ;;
        "3") orchid-install app-editors/vim && main_menu ;;
        "4") orchid-install kde-apps/kate && main_menu ;;
        "5") orchid-install app-editors/gedit && main_menu ;;
        "6") orchid-install app-editors/emacs && main_menu ;;
        "7") orchid-install app-editors/vscode && main_menu ;;
        "8") orchid-install app-editors/bluefish && main_menu ;;
        "9") orchid-install dev-util/geany && main_menu ;;
        "10") orchid-install app-editors/vscodium && main_menu ;;
        "11") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo "Veuillez choisir une option valide :D!!" && text_editors ;;
    esac
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
    echo "[Saisissez votre choix:]"
    read -r choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install x11-terms/alacritty && main_menu ;;
        "2") orchid-install x11-terms/gnome-terminal && main_menu ;;
        "3") orchid-install x11-terms/kitty && main_menu ;;
        "4") orchid-install kde-apps/konsole && main_menu ;;
        "5") orchid-install lxde-base/lxterminal && main_menu ;;
        "6") orchid-install x11-terms/rxvt-unicode && main_menu ;;
        "7") orchid-install x11-terms/terminator && main_menu ;;
        "8") orchid-install x11-terms/terminology && main_menu ;;
        "9") orchid-install x11-terms/xfce4-terminal && main_menu ;;
        "10") orchid-install x11-terms/xterm && main_menu ;;
        "11") orchid-install sys-apps/baobab && main_menu ;;
        "12") orchid-install sys-block/gparted && main_menu ;;
        "13") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo "Veuillez choisir une option valide :D!!" && system ;;
    esac
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
    echo "[Saisissez votre choix:]"
    read -r choix
    # Exécution de la commande appropriée.
    case "$choix" in
        "1") orchid-install net-im/discord-bin && main_menu ;;
        "2") orchid-install net-irc/hexchat && main_menu ;;
        "3") orchid-install net-irc/weechat && main_menu ;;
        "4") flatpak install flathub im.riot.Riot && main_menu ;;
        "5") orchid-install net-p2p/deluge && main_menu ;;
        "6") orchid-install net-p2p/qbittorrent && main_menu ;;
        "7") orchid-install net-p2p/transmission && main_menu ;;
        "8") main_menu ;;
        # Si choix incorrect, avertissement de l'utilisateur et rééxécution.
        *) echo "Veuillez choisir une option valide :D!!" && com ;;
    esac
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
    echo "[Saisissez votre choix:]"
    read -r choix
    echo "Votre choix était:" $choix
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
