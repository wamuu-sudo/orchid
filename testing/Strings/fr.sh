#!/usr/bin/env bash

WHAT_IS_FILESYSTEM="Un système de fichier organise la manière dont les données sont stockées sur votre disque.

Btrfs est récent. Il permet de prendre automatiquement des instantanés
du système pour revenir en arrière si une mise à jour se passe mal.
Toutes les données seront compressées de façon transparente.
Il est possible de redimensionner la taille du système à chaud.

Ext4 est robuste grâce à la journalisation des opérations,
minimise la fragmentation des données et est largement éprouvé.
"

CHOOSE_FILESYSTEM="Choisissez le type de système de fichiers que vous souhaitez installer : [${COLOR_GREEN}Btrfs${COLOR_RESET}]"

SELECT_FS="Sélectionnez le système de fichiers avec son numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider :"

INVALID_CHOICE="Choix invalide : "

CLI_ORCHID_SELECTOR_TEXT="Choisissez la version d'Orchid Linux que vous souhaitez installer :"

CLI_ORCHID_VER_SEL_TEXT="Sélectionnez la version d'Orchid Linux avec son numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider : "

GPU_DRIVERS_SEL="Choisissez les pilotes pour votre GPU à installer :"

GPU_DRIVERS_CHOICE="Sélectionnez les pilotes pour votre GPU avec leur numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider : "

DISK_SEL="Choisissez le disque sur lequel vous souhaitez installer Orchid Linux :\n ${COLOR_YELLOW}! ATTENTION ! Toutes les données sur le disque choisi seront effacées !${COLOR_RESET}"

DISK_CHOICE="Sélectionnez le disque pour installer Orchid Linux avec son numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider :"

DISK_PART="${COLOR_GREEN}*${COLOR_RESET} Partitionnement du disque."

EFI_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition EFI."

SWAP_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition swap."

BTRFS_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition Btrfs."

EXT4_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition EXT4."

HIBERNATION_DANGER="Nous ne recommandons pas d'utiliser l'hibernation avec vos ${RAM_SIZE_GB} Go de RAM, car il faudrait une partition SWAP de ${SWAP_SIZE_GB} Go sur le disque."

HIBERNATION_CONFIRM="Voulez-vous créer une partition SWAP de ${SWAP_SIZE_GB} Go pour permettre l'hibernation ? (Si non, la partition SWAP sera beaucoup plus petite et vous ne pourrez pas utiliser l'hibernation) ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET} "

SWAP_SIZE_QUESTION="Entrez la taille de la partition SWAP que vous souhaitez créer (en Go) ${COLOR_WHITE}[${COLOR_GREEN}${SWAP_SIZE_GB} Go${COLOR_WHITE}]${COLOR_RESET} :"

CREATE_PASSWORD="${COLOR_WHITE}Saisissez le mot de passe pour l'utilisateur ${1} : ${COLOR_YELLOW}(le mot de passe n'apparaîtra pas)${COLOR_RESET}"

CREATE_PASSWORD_REPEAT="${COLOR_WHITE}Ressaisissez le mot de passe pour le confirmer :${COLOR_RESET}"

CREATE_PASSWORD_FAIL="i${COLOR_YELLOW}Les mots de passe ne concordent pas, réessayez.${COLOR_RESET}"

USE_THE_GODDAMN_SUDO="Veuillez relancer avec les droits du superutilisateur root. (su ou sudo)"

WELCOME="${COLOR_YELLOW}L'équipe d'Orchid Linux n'est en aucun cas responsable
d'éventuels problèmes qui pourraient arriver lors de
l'installation ou l'utilisation d'Orchid Linux.
(Licence GPL 3.0 ou supérieure)

Lisez très attentivement les instructions.
Merci d'avoir choisi Orchid Linux !${COLOR_RESET}"

WELCOME_START="Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour commencer l'installation."

RAM_ISSUE="${COLOR_YELLOW}Désolé, il faut au minimum 2 Go de RAM pour utiliser Orchid Linux. Fin de l'installation.${COLOR_RESET}"

INTERNET_FAIL="${COLOR_RED}*${COLOR_RESET} Test de la connection internet KO. Soit vous n'avez pas de conenction à l'internet, soit notre serveur est à l'arrêt."

INTERNET_FAIL_CONTINUE="Nous allons tenter de vous trouver une connection à l'internet ; pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer"

INTERNET_SUCCESS="${COLOR_GREEN}*${COLOR_RESET} La connection à Internet est fonctionnelle."

CONTINUE="Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer"

CHANGE_KEYMAP="${COLOR_GREEN}*${COLOR_RESET} Passage du clavier en (fr)."


DISK_WARNING_INST="${COLOR_GREEN}*${COLOR_RESET} Orchid Linux s'installera sur ${COLOR_GREEN}${CHOOSEN_DISK} : ${CHOOSEN_DISK_LABEL}${COLOR_RESET} \n ${COLOR_YELLOW}                                  ^^ ! ATTENTION ! Toutes les données sur ce disque seront effacées !${COLOR_RESET}"

DISK_ROM="${COLOR_GREEN}*${COLOR_RESET} Le démarrage du système d'exploitation est de type ${ROM}. \n \n Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer, ${COLOR_WHITE}ou toute autre touche${COLOR_RESET} pour quitter l'installateur."

ORCHID_CANCEL="${COLOR_YELLOW}Installation d'Orchid Linux annulée. Vos disques n'ont pas été écrits. Nous espérons vous revoir bientôt !${COLOR_RESET}"

WHAT_IS_HIBERNATION="L'hibernation, c'est éteindre l'ordinateur en conservant son état.
À l'allumage, on retrouvera son bureau exactement tel qu'il était avant l'arrêt.

Pour ce faire, il est nécessaire de copier toute la mémoire vive sur un disque (SWAP).

Par défaut, nous vous proposons de ne pas utiliser l'hibernation.
"
USE_HIBERNATION_QUESTION="Voulez-vous pouvoir utiliser l'hibernation ? ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET}"

YOUR_SWAP_SIZE=" ${COLOR_GREEN}*${COLOR_RESET} Votre SWAP aura une taille de ${SWAP_SIZE_GB} Go."

WHAT_IS_HOSTNAME="Le hostname est le nom donné à votre ordinateur sur le réseau,
afin de l'identifier lors des communications.

Par défaut, nous vous proposons de l'appeler ${COLOR_GREEN}orchid${COLOR_RESET}.
"
CHOOSE_HOSTNAME"Entrez le nom de ce système (hostname) pour l'identifier sur le réseau [${COLOR_GREEN}orchid${COLOR_RESET}] : "

INCORRECT_HOSTNAME="${COLOR_RED}*${COLOR_RESET} Désolé, \"${COLOR_WHITE}${HOSTNAME}${COLOR_RESET}\" est invalide. Veuillez recommencer."

WHAT_IS_ESYNC="Esync est une technologie créée pour améliorer les performances de jeux
qui utilisent fortement le parallélisme. Elle est particulièrement utile
si vous utilisez votre ordinateur pour jouer.

Elle nécessite une petite modification d'un paramètre de sécurité
(l'augmentation significative du nombre de 'file descriptors' par processus).

Par défaut, nous vous proposons de l'activer : ${COLOR_GREEN}o${COLOR_RESET}.
"

ESYNC_GAMING="Pour les éditions Gaming, Orchid Linux active automatiquement esync. \n"


ESYNC_CONFIGURE="Voulez-vous configurer votre installation avec esync ? ${COLOR_WHITE}[${COLOR_GREEN}o${COLOR_WHITE}/n]${COLOR_RESET}"

WHAT_IS_UPDATE="La mise à jour de votre ordinateur est une opération qui consiste à vérifier
que les logiciels de votre ordinateur utilisent bien la dernière version disponible.
Ceci est particulièrement important pour la sécurité du système,
sa cohérence et fourni aussi parfois de nouvelles fonctionnalités.

Par défaut, nous conseillons de faire la mise à jour juste après l'installation,
car cette opération peut être longue et si vous choisissez de la faire pendant
l'installation vous devrez attendre sans rien pouvoir faire d'autre.
"

UPDATE_QUESTION="Voulez-vous mettre à jour votre Orchid Linux durant cette installation ? ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET}"

WHAT_IS_USERNAME="Sur un système Linux, comme Orchid Linux, chaque utilisateur doit avoir
son propre compte qui l'identifie et sépare ses fichiers des autres.

Par defaut, le premier utilisateur que vous allez créer aura
les droits d'administration grâce à la commande ${COLOR_WHITE}sudo${COLOR_RESET}.
"

USERNAME_SELECT="${COLOR_GREEN}*${COLOR_RESET} ${COLOR_WHITE}Nom du compte que vous voulez créer : ${COLOR_RESET}"

INCORRECT_USERNAME="${COLOR_RED}*${COLOR_RESET} Désolé, \"${COLOR_WHITE}${USERNAME}${COLOR_RESET}\" est invalide. Veuillez recommencer."

WHAT_IS_ROOT="Vous allez maintenant choisir le mot de passe pour le superutilisateur (root).

Ce compte particulier a tous les droits sur l'ordinateur."
RESUME_INST="${COLOR_WHITE}Résumé de l'installation${COLOR_RESET}"
RESUME_CONNEXION_TEST="Test de la connection internet : [${COLOR_GREEN}OK${COLOR_RESET}]"
RESUME_EDITION="Version d'Orchid Linux choisie : ${COLOR_GREEN}${ORCHID_VERSION[$no_archive]}${COLOR_RESET}."
RESUME_KEYBOARD="Passage du clavier en ${COLOR_GREEN}(fr)${COLOR_RESET} : [${COLOR_GREEN}OK${COLOR_RESET}]"
RESUME_DISK="Orchid Linux s'installera sur : ${COLOR_GREEN}${CHOOSEN_DISK_LABEL}${COLOR_RESET}"
RESUME_FS="Le système de fichiers choisi est : ${COLOR_GREEN}${FILESYSTEM}${COLOR_RESET}"
RESUME_HIBERNATION="Vous pourrez utiliser l'${COLOR_GREEN}hibernation${COLOR_RESET} : mémoire de ${RAM_SIZE_GB} Go, ${PROCESSORS} coeurs de processeur, SWAP de ${COLOR_GREEN}${SWAP_SIZE_GB} Go${COLOR_RESET})."
RESUME_HIBERNATIONNT="Votre mémoire a une taille de ${RAM_SIZE_GB} Go avec ${PROCESSORS} coeurs de processeur. Votre SWAP sera de ${COLOR_GREEN}${SWAP_SIZE_GB} Go${COLOR_RESET}."

RESUME_GPU="Les pilotes graphiques suivants vont être installés : ${COLOR_GREEN}${SELECTED_GPU_DRIVERS_TO_INSTALL}${COLOR_RESET}"
RESUME_HOSTNAME="Sur le réseau, ce système aura pour nom : ${COLOR_GREEN}${HOSTNAME}${COLOR_RESET}."
RESUME_ESYNC="La configuration ${COLOR_GREEN}esync${COLOR_RESET} sera faite pour le compte : ${COLOR_GREEN}${USERNAME}${COLOR_RESET}."
RESUME_UPDATE="Orchid Linux sera ${COLOR_GREEN}mise à jour${COLOR_RESET} durant cette installation. \n                                ^^ ${COLOR_YELLOW}Cela peut être très long.${COLOR_RESET}"
RESUME_USERNAME="En plus du superutilisateur root, le compte pour l'utilisateur suivant va être créé : ${COLOR_GREEN}${USERNAME}${COLOR_RESET}"

INSTALL_BEGIN="Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour commencer l'installation sur le disque, ${COLOR_WHITE}ou toute autre touche${COLOR_RESET} pour quitter l'installateur."

INSTALL_CANCEL="${COLOR_YELLOW}Installation d'Orchid Linux annulée. Vos disques n'ont pas été écrits. Nous espérons vous revoir bientôt !${COLOR_RESET}"

INSTALL_MOUNTING="${COLOR_GREEN}*${COLOR_RESET} Montage des partitions :"
INSTALL_MOUNTING_ROOT="  ${COLOR_GREEN}*${COLOR_RESET} Partition racine."
INSTALL_MOUNTING_SWAP="  ${COLOR_GREEN}*${COLOR_RESET} Activation du SWAP."
INSTALL_MOUNTING_EFI="  ${COLOR_GREEN}*${COLOR_RESET} Partition EFI."
INSTALL_MOUNTING_PART_STOP="${COLOR_GREEN}*${COLOR_RESET} Partitionnement terminé !"
INSTALL_EXTRACT="${COLOR_GREEN}*${COLOR_RESET} Téléchargement et extraction de la version d'Orchid Linux choisie."
INSTALL_EXTRACT_FINISH="${COLOR_GREEN}*${COLOR_RESET} Extraction terminée."
INSTALL_SYS_MOUNT="${COLOR_GREEN}*${COLOR_RESET} On monte les dossiers proc, dev, sys et run pour le chroot."
ENDING="Installation terminée ! ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour redémarrer. Pensez bien à enlever le support d'installation. Merci de nous avoir choisi !"
