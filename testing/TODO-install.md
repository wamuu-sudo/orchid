# TODO Script d'installation

## LIVE CD ISO :
* Création de sa propre ISO Gentoo Mini CD Live avec :
  * Une font unicode pour la console (avec les symboles)
  * Autodémarrage du script
  * pv installé (pour de vraies barres de progression avec ETA)
  * un meilleur support pour les VM ? (résolution graphique)

## INSTALLATEUR, PHASE I :
* Les entrées utilisateur :
  * Test automatisé de la connection à internet + essai de réaliser la connection au besoin. Sans connection, échec de l'installation = STOP, EXIT
  * Ecran d'acceuil avec Support i18n (fr, en, etc. : présentation en liste, choix unique)
    * Mettre l'interface dans la langue choisie
  * Choix du clavier (azerty, qwerty, etc. : présentation en liste, choix unique) (+ RETOUR)
    * Mettre la bonne disposition du clavier choisi
  * Partitionnement : automatisé (disque entier), ou manuel mais alors l'écriture des partitions se fera à ce moment là (Variables à récupérer : nom du disque + / + swap) (+ RETOUR)
    * Manuel = quel logiciel ? Candidats : cfdisk, gdisk
  * Le choix de la version d'Orchid (présentation en liste, choix unique)
  * Création de l'utilisateur avec les droits d'administration + son mot de passe + mot de passe pour root (validation du nom choisi + évaluation de la résistance du mot de passe ?) (+ RETOUR)
  * Choix des cartes graphiques (à automatiser plus tard, au moins au niveau du choix proposé)
  * Choix du hostname
  * Récapitulatif avant d'effectuer tous les changements (+ RETOUR)
  * Dernier avertissement avant les changements ?
## INSTALLATEUR, PHASE II :
* L'installation du système : à l'écran soit les retous sur les différentes étapes, soit un slide show (libcaca ?)
  * Partitionnement (si automatisé)
  * On monte les partitions (/ + swap + EFI si besoin)
  * Téléchargement et extraction de la version d'Orchid
  * Mettre les fichiers d'Orchid dans la langue et le clavier choisi
    * Quel fichiers ?
  * autoconfiguration du make.conf : la langue, le nombre de processeurs, les cartes graphiques, les options du CPU)
  * Support esync : éditer /etc/security/limits.conf avec nouvelle ligne "$username hard nofile 524288"
  * Mount proc, dev et sys pour le chroot
  * chroot
    * Mise à jour des variables d'environnement
    * Changement du fstab
    * Changement du hostname
    * Mot de passe root
    * Création de l'utilisation avec les droits d'administration (Quels groups d'appartenance?)
      * Mot de passe de l'utilisateur
    * Installation de grub (EFI ou BIOS)
    * Activation des services openrc
    * Post configuration des versions ( scripts DWM, GNOME & GDM dans la bonne langue, etc.)
  * Hors chroot : on efface les scripts et l'archove stage 4
  * umount tout (+ fermer les services openrc, systemd ?)
  * Ecran final "installation terminée, enlever le support et reboot [Entrée]"
  * reboot
