# Création stages communautaires

Ce document présente les modalités de création pour construire un stage Orchid.
Il est utilisable pour créer vos propres éditions et nous les soumettre.

![Orchid Logo](img/Orchid-Think.png)

## Préparer l'environnement :

L'idéal est bien sûr d'effectuer la construction sur un système Gentoo.

À noter que les stages doivent être exclusivement compilés sur processeur 64bits.

Vous êtes libre de partir d'un stage 3 classique, de chez Gentoo, et d'implémenter le reste.

Nous fournissons un stage base qui contient déjà les outils Orchid, X.Org, Grub, le noyau binaire ainsi que les locales françaises.

Si c'est celui-ci que vous utilisez, il faudra sélectionner un profil optimal ou adapter les USEFLAGS en fonction de votre objectif.

## Prérequis :

CPU : au moins 4 coeurs

RAM : au moins 4 Go

Espace disque : 20Go

## À partir du stage "base" :

Il faut télécharger le stage :

```
wget https://dl.orchid-linux.org/stage4-orchid-base-latest.tar.bz2
```

et l'extraire afin de travailler dessus, si possible dans un dossier spécifique :

```
tar -jxvf stage4-orchid-base-latest.tar.bz2
```

Vous pouvez supprimer l'archive une fois extraite :

```
rm -rf stage4-orchid-base-latest.tar.bz2
```

## Entrer dans le système :

Nous allons rentrer dans l'environnement du stage à contruire :

Monter les périphériques suivants :

```
mount -t proc /proc proc/
mount --rbind /dev dev/
mount --rbind /sys sys/
mount --rbind /run run/
```

Copions le fichier de résolution DNS :

```
cp -rf /etc/resolv.conf etc/
```

Rentrons dans le système :

```
chroot . /bin/bash
```

## Créer son édition :

Nous sommes donc dans le futur stage.
Comme dit un peu plus tôt, "base" contient déjà les outils Orchid, il n'est donc pas nécessaire des les installer.

Il est conseillé de mettre à jour le système avant tout changement :

```
orchid-sync && orchid-update
```

Nous n'accepterons aussi que les stages incluant un support de BTRFS et de Snapper :

```
orchid-install btrfs-progs snapper
```

Une fois ceci fait, la suite est plus complexe et frustrante.
En effet, vous pouvez désormais installer le bureau de votre choix, les logiciels que vous voulez ...

La chose est surtout que vous ne pouvez appliquer des customisations graphiquement, étant donné que vous êtes root et en CLI.

Il faut savoir que les DE ont leurs propres procédures pour faire les customisations pour tous les utilisateurs avant qu'ils soient créés.
N'hésitez pas à consulter les documentations sur ceux-ci afin d'avoir plus de détails sur comment faire.

N'hésitez pas à nous notifier, sur Discord principalement, si vous compter créer un stage afin que l'on puisse vous aidez au besoin.
Je rappelle que cette opération nécessite des connaissances avancées dans le monde Linux et Gentoo.

## Créer l'archive :

Une fois vos modifications faites, nous pouvons commencer la préparation du stage afin qu'il soit distribué.

Faisons un peu de ménage avant tout :

```
rm -rf /var/cache/distfiles/* && rm -rf /tmp/*
history -c
```

Nous pouvons sortir du chroot :

```
exit
```
Nous utilisons des archives au format tar.bz2, qui offre un bon rapport.
Créons l'archive de votre version, en adaptant le nom mais en respectant la norme :

```
tar jcvpf ../stage4-orchid-nomdevotreversion-latest.tar.bz2 .
```

Votre stage sera disponible dans le fichier parent où vous vous trouver.

## Contributeurs

- [Hydaelyn](https://github.com/wamuu-sudo) : Créateur du projet.
- Vinceff : Documentation et mise en projet.
- [Chevek](https://github.com/chevek) : Outils Gaming et optimisation, développeur du projet.
- [Babilinx](https://github.com/babilinx) : Optimisation du projet et développeur du projet.
- [Crystal](https://crystal-td.github.io) : Développeuse du projet.
- Piaf_Jaune : Responsable look et graphiste.
- Kirik : Vérification de la documentation.
- L'ensemble des membres du serveur [Discord Gaming Linux FR](https://discord.gg/KAzznM4Fnb).
