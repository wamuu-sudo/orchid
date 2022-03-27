#!/usr/bin/env bash
# Contributeurs :
#  - Babilinx : code
#  - Chevek : vérifications et debuging
#  - Wamuu : vérifications et test
# mars 2022
# Script de configuration GNOME pour passer le clavier en AZERTY
#
read -p "Nom de l'utilisateur précédament créé : " username
mv /etc/X11/xorg.conf.d/10-keyboard.conf /etc/X11/xorg.conf.d/30-keyboard.conf
source /etc/conf.d/keymaps &&
KEYMAP=${KEYMAP:-fr}          &&

gdbus call --system                                             \
           --dest org.freedesktop.locale1                       \
           --object-path /org/freedesktop/locale1               \
           --method org.freedesktop.locale1.SetVConsoleKeyboard \
           "$KEYMAP" "$KEYMAP_CORRECTIONS" true true
su -c "gsettings set org.gnome.desktop.input-sources sources \"[('xkb', 'fr')]\"" $username
