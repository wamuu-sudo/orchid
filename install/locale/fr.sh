#!/usr/bin/env bash

# Common used strings

STR_INVALID_CHOICE="Choix invalide :"

STR_INSTALLER_STEPS="Bienvenue|Connection à Internet|Sélection de l'édition d'Orchid Linux|Sélection du disque pour l'installation|Système de fichiers|Hibernation|Sélection de la carte graphique|Nom du système|esync|Mise à jour|Création de l'utilisateur|Mot de passe root|Résumé|Installation"

# Function CLI_filesystem_selector

STR_WHAT_IS_FILESYSTEM="Un système de fichier organise la manière dont les données sont stockées sur votre disque.
Btrfs est récent. Il permet de prendre automatiquement des instantanés
du système pour revenir en arrière si une mise à jour se passe mal.
Toutes les données seront compressées de façon transparente.
Il est possible de redimensionner la taille du système à chaud.
Ext4 est robuste grâce à la journalisation des opérations,
minimise la fragmentation des données et est largement éprouvé.
"
STR_LANGUAGE="French"
STR_CHOOSE_FILESYSTEM="Choisissez le type de système de fichiers que vous souhaitez installer : [${COLOR_GREEN}Btrfs${COLOR_RESET}]"
STR_HIBERNATION_SWAP="Votre SWAP aura une taille de "
# Function select_filesystem_to_install

STR_SELECT_FS="Sélectionnez le système de fichiers avec son numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider :"

# Function CLI_orchid_selector

STR_CLI_ORCHID_SELECTOR_TEXT="Choisissez la version d'Orchid Linux que vous souhaitez installer :"

# Function select_orchid_version_to_install

STR_CLI_ORCHID_VER_SEL_TEXT="Sélectionnez la version d'Orchid Linux avec son numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider : "

# Function CLI_selector

STR_YOUR_GPU="${COLOR_GREEN}*${COLOR_RESET} Votre GPU :"
# Non juuuuure :O
STR_GPU_DRIVERS_SEL="Choisissez les pilotes pour votre GPU à installer :"

STR_GPU_DRIVERS_CHOICE="Sélectionnez les pilotes pour votre GPU avec leur numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider : "

# Function CLI_disk_selector

STR_DISK_SEL="Choisissez le disque sur lequel vous souhaitez installer Orchid Linux :\n ${COLOR_YELLOW}! ATTENTION ! Toutes les données sur le disque choisi seront effacées !${COLOR_RESET}"

# Function select_disk_to_install

STR_DISK_CHOICE="Sélectionnez le disque pour installer Orchid Linux avec son numéro, ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour valider :"

# Function auto_partitionning_full_disk

STR_DISK_PART="${COLOR_GREEN}*${COLOR_RESET} Partitionnement du disque."

STR_EFI_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition EFI."

STR_SWAP_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition swap."

STR_BTRFS_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition Btrfs."

STR_EXT4_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatage de la partition EXT4."

# Function swap_size_hibernation

STR_HIBERNATION_DANGER="Nous ne recommandons pas l'utilisation de l'hibernation avec votre"
#{RAM_SIZE_GB}
STR_HIBERNATION_DANGER_2="Go de RAM, car cela nécessiterait une partition SWAP de "
#{SWAP_SIZE_GB}
STR_HIBERNATION_DANGER_3="Go sur le disque".

STR_HIBERNATION_CONFIRM="Voulez-vous créer une partition SWAP de"
#{SWAP_SIZE_GB}
STR_HIBERNATION_CONFIRM_2="(Sinon, la partition SWAP sera beaucoup plus petite et vous ne pourrez pas utiliser l'hibernation) ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET} "

STR_SWAP_SIZE_QUESTION="Entrez la taille de la partition SWAP que vous voulez créer (en Go)". # Egalement dans la fonction swap_size_no_hibernation
# Function create_password

STR_CREATE_PASSWORD="${COLOR_WHITE}Entrez le mot de passe pour :"

STR_CREATE_PASSWORD_2="${COLOR_YELLOW}(le mot de passe vas pas s'afficher)${COLOR_RESET}"

STR_CREATE_PASSWORD_REPEAT="${COLOR_WHITE}Ressaisissez le mot de passe pour le confirmer :${COLOR_RESET}"

# Function verify_password_concordance

STR_CREATE_PASSWORD_FAIL="i${COLOR_YELLOW}Les mots de passe ne concordent pas, réessayez.${COLOR_RESET}"

# Main part of the install script below

STR_USE_THE_GODDAMN_SUDO="Veuillez relancer avec les droits du superutilisateur root. (su ou sudo)"

STR_WELCOME="${COLOR_YELLOW}L'équipe d'Orchid Linux n'est en aucun cas responsable
d'éventuels problèmes qui pourraient arriver lors de
l'installation ou l'utilisation d'Orchid Linux.
(Licence GPL 3.0 ou supérieure)
Lisez très attentivement les instructions.
Merci d'avoir choisi Orchid Linux !${COLOR_RESET}"

STR_WELCOME_START="Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour commencer l'installation."

STR_RAM_ISSUE="${COLOR_YELLOW}Désolé, il faut au minimum 2 Go de RAM pour utiliser Orchid Linux. Fin de l'installation.${COLOR_RESET}"

STR_INTERNET_FAIL="${COLOR_RED}*${COLOR_RESET} Test de la connection internet KO. Soit vous n'avez pas de conenction à l'internet, soit notre serveur est à l'arrêt."

STR_INTERNET_FAIL_CONTINUE="Nous allons tenter de vous trouver une connection à l'internet ; pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer"

STR_INTERNET_SUCCESS="${COLOR_GREEN}*${COLOR_RESET} La connection à Internet est fonctionnelle."

STR_CONTINUE="Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer"

STR_CHANGE_KEYMAP="${COLOR_GREEN}*${COLOR_RESET} Passage du clavier en (fr)."

STR_DISK_WARNING_INST="${COLOR_GREEN}*${COLOR_RESET} Orchid Linux s'installera sur ${COLOR_GREEN}"
STR_DISK_WARNING_INST_2="${COLOR_YELLOW}                                  ^^ ! ATTENTION ! Toutes les données sur ce disque seront effacées !${COLOR_RESET}"

STR_DISK_ROM="${COLOR_GREEN}*${COLOR_RESET} Le démarrage du système d'exploitation est de type:"

STR_DISK_ROM_2="Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour continuer, ${COLOR_WHITE}ou toute autre touche${COLOR_RESET} pour quitter l'installateur."

STR_ORCHID_CANCEL="${COLOR_YELLOW}Installation d'Orchid Linux annulée. Vos disques n'ont pas été écrits. Nous espérons vous revoir bientôt !${COLOR_RESET}"

STR_WHAT_IS_HIBERNATION="L'hibernation, c'est éteindre l'ordinateur en conservant son état.
À l'allumage, on retrouvera son bureau exactement tel qu'il était avant l'arrêt.
Pour ce faire, il est nécessaire de copier toute la mémoire vive sur un disque (SWAP).
Par défaut, nous vous proposons de ne pas utiliser l'hibernation.
"
STR_USE_HIBERNATION_QUESTION="Voulez-vous pouvoir utiliser l'hibernation ? ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET}"

STR_YOUR_SWAP_SIZE=" ${COLOR_GREEN}*${COLOR_RESET} Votre SWAP aura une taille de ${SWAP_SIZE_GB} Go."

STR_WHAT_IS_HOSTNAME="Le hostname est le nom donné à votre ordinateur sur le réseau,
afin de l'identifier lors des communications.
Par défaut, nous vous proposons de l'appeler ${COLOR_GREEN}orchid${COLOR_RESET}.
"
STR_CHOOSE_HOSTNAME="Entrez le nom de ce système (hostname) pour l'identifier sur le réseau [${COLOR_GREEN}orchid${COLOR_RESET}] : "

STR_INCORRECT_HOSTNAME="${COLOR_RED}*${COLOR_RESET} Désolé, \"${COLOR_WHITE}"
# Here there will be the hostname of the user
STR_INCORRECT_HOSTNAME_2="${COLOR_RESET}\" est invalide. Veuillez recommencer."

STR_WHAT_IS_ESYNC="Esync est une technologie créée pour améliorer les performances de jeux
qui utilisent fortement le parallélisme. Elle est particulièrement utile
si vous utilisez votre ordinateur pour jouer.
Elle nécessite une petite modification d'un paramètre de sécurité
(l'augmentation significative du nombre de 'file descriptors' par processus).
Par défaut, nous vous proposons de l'activer : ${COLOR_GREEN}o${COLOR_RESET}.
"

STR_ESYNC_GAMING="Pour les éditions Gaming, Orchid Linux active automatiquement esync. \n"


STR_ESYNC_CONFIGURE="Voulez-vous configurer votre installation avec esync ? ${COLOR_WHITE}[${COLOR_GREEN}o${COLOR_WHITE}/n]${COLOR_RESET}"

STR_WHAT_IS_UPDATE="La mise à jour de votre ordinateur est une opération qui consiste à vérifier
que les logiciels de votre ordinateur utilisent bien la dernière version disponible.
Ceci est particulièrement important pour la sécurité du système,
sa cohérence et fourni aussi parfois de nouvelles fonctionnalités.
Par défaut, nous conseillons de faire la mise à jour juste après l'installation,
car cette opération peut être longue et si vous choisissez de la faire pendant
l'installation vous devrez attendre sans rien pouvoir faire d'autre.
"

STR_UPDATE_QUESTION="Voulez-vous mettre à jour votre Orchid Linux durant cette installation ? ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET}"

STR_WHAT_IS_USERNAME="Sur un système Linux, comme Orchid Linux, chaque utilisateur doit avoir
son propre compte qui l'identifie et sépare ses fichiers des autres.
Par defaut, le premier utilisateur que vous allez créer aura
les droits d'administration grâce à la commande ${COLOR_WHITE}sudo${COLOR_RESET}.
"

STR_USERNAME_SELECT="${COLOR_GREEN}*${COLOR_RESET} ${COLOR_WHITE}Nom du compte que vous voulez créer : ${COLOR_RESET}"

STR_INCORRECT_USERNAME="${COLOR_RED}*${COLOR_RESET} Désolé, \"${COLOR_WHITE}"
# Here there will be the Username of the users
STR_INCORRECT_USERNAME_2="${COLOR_RESET}\" est invalide. Veuillez recommencer."

STR_WHAT_IS_ROOT="Vous allez maintenant choisir le mot de passe pour le superutilisateur (root).
Ce compte particulier a tous les droits sur l'ordinateur."
STR_RESUME_INST="${COLOR_WHITE}Résumé de l'installation${COLOR_RESET}"
STR_RESUME_CONNEXION_TEST="Test de la connection internet : [${COLOR_GREEN}OK${COLOR_RESET}]"
STR_RESUME_EDITION="Version d'Orchid Linux choisie :"
STR_RESUME_KEYBOARD="Passage du clavier en ${COLOR_GREEN}(fr)${COLOR_RESET} : [${COLOR_GREEN}OK${COLOR_RESET}]"
STR_RESUME_DISK="Orchid Linux s'installera sur :"
STR_RESUME_FS="Le système de fichiers choisi est :"
STR_RESUME_HIBERNATION="Vous pourrez utiliser l'${COLOR_GREEN}hibernation${COLOR_RESET} : mémoire de"
# Here we show the user his RAM + His CPU cores
STR_RESUME_HIBERNATION_2="coeurs de processeur, SWAP de ${COLOR_GREEN}"
STR_RESUME_HIBERNATIONNOT="Votre mémoire a une taille de"
# Here we show the user his RAM + His CPU cores
STR_RESUME_HIBERNATIONNOT_2="coeurs de processeur, SWAP de ${COLOR_GREEN}"

STR_RESUME_GPU="Les pilotes graphiques suivants vont être installés :"
STR_RESUME_HOSTNAME="Sur le réseau, ce système aura pour nom :"
STR_RESUME_ESYNC="La configuration ${COLOR_GREEN}esync${COLOR_RESET} sera faite pour le compte :"
STR_RESUME_UPDATE="Orchid Linux sera ${COLOR_GREEN}mise à jour${COLOR_RESET} durant cette installation.
                                ^^ ${COLOR_YELLOW}Cela peut être très long.${COLOR_RESET}"
STR_RESUME_USERNAME="En plus du superutilisateur root, le compte pour l'utilisateur suivant va être créé : "
STR_INSTALL_BEGIN="Pressez ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour commencer l'installation sur le disque, ${COLOR_WHITE}ou toute autre touche${COLOR_RESET} pour quitter l'installateur."
STR_INSTALL_CANCEL="${COLOR_YELLOW}Installation d'Orchid Linux annulée. Vos disques n'ont pas été écrits. Nous espérons vous revoir bientôt !${COLOR_RESET}"
STR_INSTALL_MOUNTING="${COLOR_GREEN}*${COLOR_RESET} Montage des partitions :"
STR_INSTALL_MOUNTING_ROOT="  ${COLOR_GREEN}*${COLOR_RESET} Partition racine."
STR_INSTALL_MOUNTING_SWAP="  ${COLOR_GREEN}*${COLOR_RESET} Activation du SWAP."
STR_INSTALL_MOUNTING_EFI="  ${COLOR_GREEN}*${COLOR_RESET} Partition EFI."
STR_INSTALL_MOUNTING_PART_STOP="${COLOR_GREEN}*${COLOR_RESET} Partitionnement terminé !"
STR_INSTALL_EXTRACT="${COLOR_GREEN}*${COLOR_RESET} Téléchargement et extraction de la version d'Orchid Linux choisie."
STR_INSTALL_EXTRACT_FINISH="${COLOR_GREEN}*${COLOR_RESET} Extraction terminée."
STR_INSTALL_SYS_MOUNT="${COLOR_GREEN}*${COLOR_RESET} On monte les dossiers proc, dev, sys et run pour le chroot."
STR_ENDING="Installation terminée ! ${COLOR_WHITE}[Entrée]${COLOR_RESET} pour redémarrer. Pensez bien à enlever le support d'installation. Merci de nous avoir choisi !"
