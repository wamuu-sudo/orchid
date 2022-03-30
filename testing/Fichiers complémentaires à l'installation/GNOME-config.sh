#!/usr/bin/env bash
# Contributeurs :
#  - Babilinx : code
#  - Chevek : vérifications et debuging
#  - Wamuu : vérifications et test
# mars 2022
# Script de configuration GNOME pour passer le clavier en AZERTY
#
# On récupère la langue du système
if [ -r /etc/env.d/02locale ]; then source /etc/env.d/02locale; fi
LANG_SYSTEM="${LANG:0:2}"
read -p "Nom de l'utilisateur précédament créé : " username
mv /etc/X11/xorg.conf.d/10-keyboard.conf /etc/X11/xorg.conf.d/30-keyboard.conf
source /etc/conf.d/keymaps
KEYMAP=${LANG_SYSTEM}

gdbus call --system                                             \
           --dest org.freedesktop.locale1                       \
           --object-path /org/freedesktop/locale1               \
           --method org.freedesktop.locale1.SetVConsoleKeyboard \
           "$KEYMAP" "$KEYMAP_CORRECTIONS" true true
su -c "gsettings set org.gnome.desktop.input-sources sources \"[('xkb', '${LAND_SYSTEM}')]\"" $username
