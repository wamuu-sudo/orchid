# Installation d'Orchid Linux 

Orchid est un installateur rapide de Gentoo, pour les ordinateurs de bureau et ordinateurs portables.

![Orchid Logo](img/Orchid-Think.png)

## Télécharger et lancer le LiveCD :

Comme nous n'avons pas d'iso spécifique, nous utiliserons l'iso de Gentoo.

À noter que vous avez deux versions ci-dessous, avec ou sans interface graphique.

Veuillez-noter que la version avec interface graphique n'est pas du tout représentative du bureau que vous aurez.

Elle a été implémentée pour permettre de suivre graphiquement ce guide d'installation tout en installant le système.

Ces ISOs sont fournies par Gentoo, et nous n'en sommes pas responsable.

Les fichiers nécessaires à la vérification de l'intégrité sont disponibles sur le [miroir](https://dl.orchid-linux.org).

[Télécharger l'iso sans GUI](https://dl.orchid-linux.org/install-amd64-minimal-20220508T170538Z.iso) [~500Mo]

[Télécharger la version avec GUI](https://dl.orchid-linux.org/livegui-amd64-20220508T170538Z.iso) [~5Go]

Il est nécessaire de rendre cette ISO bootable sur votre support à l'aide d'outils comme BalenaEtcher ou encore Ventoy.

## Prérequis :

La machine doit avoir accès à Internet, afin de pouvoir télécharger les archives.

CPU : au moins 4 coeurs, plus c'est encore mieux !

RAM : au moins 4 Go

Espace disque : 20Go

## Utilisation du script (testing) et ne nécessite pas la suite du guide :

Il faut télécharger le script :

```
wget https://raw.githubusercontent.com/wamuu-sudo/orchid/main/testing/install.sh
```

et appliquer les bons droits :

```
chmod +x ./install.sh
```

puis lancer le script interactif avec les droits root (avec `sudo` ou en root via `su root` après avoir mis un mot de passe à root) :

```
./install.sh
```

## Préparer l'installation :

Vous pouvez démarrer sur votre support.

Suivant l'ISO que vous aurez prise, vous aurez soit un environnement CLI, soit un environnement graphique.

Pour avoir un clavier français (voir fenêtre ouverte en auto pour la version GUI) :

```
loadkeys fr
```

Vérification de l'accès au réseau :

```
ip a
```

Si vous n'avez pas d'ip, vous pouvez relancer une requête à votre serveur DHCP :

```
dhcpcd
```

Si vous avez besoin du WiFi, l'ISO intègre des outils :

```
net-setup
```

ou sur l'iso graphique :

```
nmtui
```

## Partitionnement :

Pour repérer le nom de votre disque, vous pouvez utiliser fdisk :

```
fdisk -l
```

Attention, le nom peut varier suivant la technologie employée (nvme ou sata) :

```
cfdisk /dev/sdX ou cfdisk /dev/nvme0nX
```

Voici le schéma recommandé pour une utilisation optimale :

- Une partition d'une taille d'1Mo non formatée mais qui dispose du flag "Bios Boot". (Si installation BIOS)
- Une partition EFI de 256Mo formatée en vfat (si UEFI uniquement).
- Une partition swap de quelques Go, en général 2 ou 4Go.
- Le reste de l'espace en ext4.

L'utilisation de cfdisk étant assez facile, elle n'est pas traitée ici.

On formate les nouvelles partitions (exemple avec un disque sda) :

```
mkfs.vfat -F32 /dev/sda1 (si UEFI uniquement)
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
```

Il faut ensuite monter les partitions pour pouvoir travailler dessus:

Pour la partition root :

```
mkdir /mnt/orchid && mount /dev/sda3 /mnt/orchid
```

Activation du swap :

```
swapon /dev/sda2
```

Pour la partition EFI (pas nécessaire si bios):

```
mkdir -p /mnt/orchid/boot/EFI && mount /dev/sda1 /mnt/orchid/boot/EFI
```

Vérification de la date du système (doit être à H-1) :

```
date
```

Pour modifier la date si elle est incorrecte :

```
date MMJJhhmmAAAA
```

## Installer le système complet :

Déplaçons-nous dans la future racine :

```
cd /mnt/orchid
```

Il faut ensuite télécharger l'archive qui convient pour un système Orchid complet avec wget par exemple (l'archive est assez volumineuse) :

[Version standard DWM](https://dl.orchid-linux.org/stage4-orchid-dwmstandard-latest.tar.bz2) [1.9Go]

[Version DWM Gaming Edition](https://dl.orchid-linux.org/stage4-orchid-dwmgaming-latest.tar.bz2) [2.9Go]

[Version Gnome complète](https://dl.orchid-linux.org/stage4-orchid-gnomefull-latest.tar.bz2) [2.4Go]

[Version XFCE Gaming](https://dl.orchid-linux.org/stage4-orchid-xfcegaming-latest.tar.bz2) [2.6Go]

[Version Base X.Org](https://dl.orchid-linux.org/stage4-orchid-base-latest.tar.bz2) [1.7Go]

[Version KDE Plasma](https://dl.orchid-linux.org/testing/stage4-orchid-kdeplasma-latest.tar.bz2) [2.9Go]

[Version Gnome Gaming](https://dl.orchid-linux.org/testing/stage4-orchid-gnomegaming-latest.tar.bz2) [3.1Go]

[Version Gnome Gaming SystemD](https://dl.orchid-linux.org/testing/stage4-orchid-gnomegaming-systemd-latest.tar.bz2) [3.1Go]

Exemple:

```
wget https://dl.orchid-linux.org/stage4-orchid-gnomefull-latest.tar.bz2
```

Extraire l'archive téléchargée : 

```
tar -jxvpf stage4-*.tar.bz2 --xattrs
```

## Configuration préliminaire du système :

On édite le fichier make.conf pour modifier quelques options si elles ne vous conviennent pas :

```
nano -w /mnt/orchid/etc/portage/make.conf
```

Le fichier /etc/portage/make.conf est le fichier de configuration dans lequel on va définir les variables de notre future architecture (nombre de coeurs, carte vidéo, périphériques d'entrée, langue, choix des variables d'utilisation, etc... ). Par défaut, Orchid est déjà configurée avec les bonnes options par défaut :

- Optimisation de GCC pour un système générique.
- Utilisation des fonctions essentielles comme : Pulseaudio, networkmanager, ALSA.
- Choix des pilotes propriétaires Nvidia.
- Les locales françaises.

Configuration du fichier make.conf :

Ici, il faudra juste changer votre nombre de coeurs pour qu'Orchid tire au mieux profit de votre processeur :

```
MAKEOPTS="-jX" X étant votre nombre de coeurs 
```

Support graphique :

Par défaut Orchid supporte la majorité des cartes graphiques. Vous pouvez néanmoins supprimer celles que vous n'utilisez pas (bien garder fbdev et vesa !):

```
VIDEO_CARDS="fbdev vesa intel i915 nvidia nouveau radeon amdgpu radeonsi virtualbox vmware"
```

Enregistrez le fichier quand vous avez terminé.

## Montage et chroot :

On monte ensuite les dossiers proc et dev dans /mnt/orchid, qui sont nécessaire au bon fonctionnement du chroot :

```
mount -t proc /proc /mnt/orchid/proc
mount --rbind /dev /mnt/orchid/dev
mount --rbind /sys /mnt/orchid/sys
```

On chroot dans le système temporaire :

```
chroot /mnt/orchid /bin/bash
```

Il faut mettre à jour certaines variables d'environnement :

```
env-update && source /etc/profile
```

Nous pouvons rajouter un indicateur au shell afin de réperer que nous sommes bien en chroot :

```
export PS1="[chroot] $PS1"
```

On recheck la date :

```
date
```

Si elle est incorrecte, on la modifie à nouveau :

```
date MMJJhhmmAAAA
```

## Fichier fstab :

Le fichier qui suit est très important ! Si vous avez une erreur dans celui-ci, le système ne démarrera pas :

```
nano -w /etc/fstab
```

Exemple (avec les partitions exemples créées au début pour un disque nommée sda) :

```
/dev/sda3               /               ext4            defaults,noatime         0 1
/dev/sda2               none            swap            sw              0 0
/dev/sda1              /boot/EFI           vfat            defaults         0 0
```

## Définir le nom d'hôte :

Pour modifier le nom de la machine :

```
nano -w /etc/conf.d/hostname
```

## Utilisateurs : 

Mettre un mot de passe à root : 

```
passwd
```

Nous devons créer un utilisateur standard pour pouvoir se connecter à votre futur environnement graphique : 

```
useradd -m -G users,wheel,audio,video -s /bin/bash utilisateur
```

Il faut lui appliquer un mot de passe :

```
passwd utilisateur
```

## Configurer l'amorçage du système :

Pour installer le bootloader Grub : 

EFI :

```
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --recheck
```

Ou Bios :

```
grub-install /dev/sdX
```


Générer grub.cfg :

```
grub-mkconfig -o /boot/grub/grub.cfg 
```

## Activation de DWM (concerne uniquement les versions DWM):

L'ensemble des dossiers et fichiers nécessaires sont déjà sur le système.

Il suffit de lancer ces deux scripts *en tant qu'utilisateur non-root* :

```
/usr/share/orchid/fonts/applyorchidfonts && /usr/share/orchid/desktop/dwm/set-dwm
```
Slim lancera alors directement la session dwm.

## Finalisation :

On sort du système : 

```
exit
```

Il faut supprimer l'archive téléchargée :

```
rm -f /mnt/orchid/*.tar.gz
```

Il faut démonter le système :

```
cd /
umount -R /mnt/orchid
```

Orchid est désormais installée.

On peut `reboot`.

## Usage de DWM :

Raccourci utiles sous DWM :

* Ouvrir dmenu (le lanceur d'appli/flatpaks) :

```Win+p```

* Ouvrir un terminal : 

```Win+Shift+Enter```

* Fermer la fenêtre sous focus : 

```Win+Shift+c```

* Quitter DWM (logout) :

```Win+Shift+q```


## Aller plus loin :

Découvrez nos outils permettant une utilisation simple et rapide d'Orchid : [Nos outils](https://github.com/wamuu-sudo/orchid/blob/main/TOOLS.md)

Vous pouvez rejoindre notre serveur Discord : [Rejoindre le serveur](https://discord.gg/DeRhvP7M)


## Source : 

Ce document est basé sur le guide d'installation disponible sur Linuxtricks (https://www.linuxtricks.fr/wiki/installer-gentoo-facilement), disponible sous licence CC BY-SA.

## Contributeurs

- [Hydaelyn](https://github.com/wamuu-sudo) : Créateur du projet.
- Vinceff : Documentation et mise en projet, directeur de la communication.
- [Chevek](https://github.com/chevek) : Outils Gaming et optimisation, développeur du projet.
- [Babilinx](https://github.com/babilinx) : Optimisation du projet et développeur du projet.
- [Crystal](https://crystal-trd.github.io) : Développeuse du projet.
- Piaf_Jaune : Responsable look et graphiste.
- Kirik : Vérification de la documentation.
- L'ensemble des membres du serveur [Discord Gaming Linux FR](https://discord.gg/KAzznM4Fnb).
