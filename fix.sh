#!/bin/bash

# Exec dev fix, new packages, directly added by devs.
echo "Vérification des modifications/ajouts de paquets Orchid ..."
orchid-sync
echo "Applications des mises à jours ..."
eix-sync && emerge -avuDN @world
clear
echo "Mises à jours terminées."
echo ""
echo "Installation des paquets manquants..."
emerge sof-firmware
echo "Paquets manquants installés."
