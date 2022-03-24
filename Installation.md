# Installation d'Orchid Linux 

Orchid est une variante moderne et soignée de Gentoo, pour les ordinateurs de bureau et ordinateurs portables.

![Orchid Logo](img/ORCHID_LOGO.png)

## Télécharger et lancer le LiveCD :

Comme nous n'avons pas d'iso spécifique, nous utiliserons l'iso de Gentoo.

A noter que vous avez deux versions ci-dessous, avec ou sans interface graphique.

Veuillez-noter que la version avec interface graphique n'est pas du tout représentative du bureau que vous aurez.

Elle a été implémentée pour permettre de suivre graphiquement ce guide d'installation tout en installant le système.

Ces ISOS sont fournies par Gentoo, et nous n'en sommes pas responsable.

Les fichiers nécessaires à la vérification de l'intégrité sont disponibles sur le [miroir](https://orchid.juline.tech).

[Télécharger l'iso sans GUI](https://orchid.juline.tech/install-amd64-minimal-20220315T091810Z.iso) [~500Mo]

[Télécharger la version avec GUI](https://orchid.juline.tech/livegui-amd64-20220315T091810Z.iso) [~5Go]

Il faut ensuite "graver" l'iso sur un CD ou une clé USB à l'aide d'outils comme BalenaEtcher ou Rufus.

Une fois votre support d'installation bootable en main, vous pouvez démarrer sur celui-ci sur votre ordinateur.

## Prérequis :

Vérifier que la machine dispose du réseau, surtout d'Internet.

Disposer d'une deuxième machine avec un client SSH est un plus (le copier coller sera plus facile).

## Préparer l'installation :

Booter sur votre support.

Le Live CD charge les modules et démarre.

Une invite demande de sélectionner la langue. Je choisis 18 (fr).

Le chargement est terminé lorsque le prompt livecd ~ # s'affiche.

Si le clavier n'est pas en français :

```
loadkeys fr
```

On vérifie que nous disposons bien d'une IP :

```
ip a
```

Si besoin, demander une IP à notre serveur DHCP :

```
dhcpcd
```

Dans le cas d'une interface wi-fi, on pourra utiliser l'outil semi-graphique :

```
net-setup
```

## Configurer l'accès distant ssh (optionnel) :

On démarre le service ssh :

```
/etc/init.d/sshd start
```

Et on initialise le mot de passe root :

```
passwd
```

Nous pouvons alors accéder à la machine depuis une autre via SSH.

## Partitionnement :

Il existe plusieurs manières de partitionner son disque, avec des outils différents.

Moi, je vais utiliser cfdisk, il est plus "facile" à utiliser que fdisk.

Nous pouvons identifier le nom du disque si vous en avez plusieurs :

```
fdisk -l
```

Une fois que vous avez son nom (ex: sda ou nvme0n1), on peut lancer cfdisk avec la bonne valeur :

```
cfdisk /dev/sdX
```

Voici le schéma recommandé :

- Une partition EFI de 256Mo formatée en vfat (si UEFI uniquement).
- Une partition swap de quelques Go, en général 2 ou 4Go.
- Le reste de l'espace en ext4.

L'utilisation de cfdisk étant assez facile, elle n'est pas traitée ici.

On formate les nouvelles partitions (exemple avec un disque sda) :

- mkfs.vfat -F32 /dev/sda1 (si UEFI uniquement)
- mkfs.ext4 /dev/sda3
- mkswap /dev/sda2

Il faut ensuite monter les partitions :

Pour la partition racine :

```
mkdir /mnt/orchid && mount /dev/sda3 /mnt/orchid
```

Activer le swap :

```
swapon /dev/sda2
```

La partition EFI (pas nécessaire si bios):

```
mkdir -p /mnt/orchid/boot/EFI && mount /dev/sda1 /mnt/orchid/boot/EFI
```

Vérifions la date du système (doit être à H-1) :

```
date
```

Modifier si besoin la date et l'heure :

```
date MMJJhhmmAAAA
```

## Installer le système complet :

Déplaçons-nous dans la future racine :

```
cd /mnt/orchid
```

Il faut ensuite télécharger l'archive qui convient pour un système Orchid complet avec wget par exemple (l'archive est assez volumineuse) :

[Version standard DWM](https://orchid.juline.tech/stage4-orchid-dwm-standard-20032022-r1.tar.gz) [2.2Go]

[Version DWM Gaming Edition](https://orchid.juline.tech/stage4-orchid-dwm-gaming-20032022-r1.tar.gz) [2.9Go]

[Version Gnome complète](https://orchid.juline.tech/stage4-orchid-gnome-full-20032022-r2.tar.gz) [2.8Go]

[Version Gnome light](https://orchid.juline.tech/stage4-orchid-gnome-light-20032022-r2.tar.gz) [2.7Go]

[Version KDE Plasma](https://orchid.juline.tech/stage4-orchid-kde-20032022-r2.tar.gz) [3.5Go]

Exemple:

```
wget https://orchid.juline.tech/stage4-orchid-dwm-gaming-19032022-r1.tar.gz
```

Extraire ensuite l'archive : 

```
tar xvpf stage4-*.tar.gz --xattrs
```

## Configuration essentielle avant le chroot :

On édite le fichier make.conf pour lui ajouter quelques options supplémentaires :

```
nano /mnt/orchid/etc/portage/make.conf
```

Le fichier /etc/portage/make.conf est le fichier de configuration dans lequel on va définir les variables de notre future architecture (nombre de coeurs, carte vidéo, périphériques d'entrée, langue, choix des variables d'utilisation, etc... ). Par défaut, Orchid est déjà configurée avec les bonnes options par défaut :

- Détection et optimisation de GCC en fonction de votre processeur.
- Utilisation des fonctions essentielles comme : Pulseaudio, networkmanager, ALSA.
- Choix des pilotes propriétaires Nvidia.

Configuration du fichier make.conf :

Ici, il faudra juste changer votre nombre de coeurs pour qu'Orchid tire le meilleur profit de votre processeur :

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

On monte ensuite les dossiers proc et dev dans /mnt/orchid :

```
mount -t proc /proc /mnt/orchid/proc
mount --rbind /dev /mnt/orchid/dev
mount --rbind /sys /mnt/orchid/sys
```

On change l’environnement du live CD pour basculer vers l'environnement final.

On chroot le système :

```
chroot /mnt/orchid /bin/bash
```

On met à jour des variables d'environnement :

```
env-update && source /etc/profile
```

Pour ne pas s’emmêler les pinceaux, on peut ajouter un repère à notre prompt pour bien distinguer que l'on est en chroot :

```
export PS1="[chroot] $PS1"
```

N'hésitez pas à voir si l'heure est bonne :

```
date
```

Modifier si besoin la date et l'heure :

```
date MMJJhhmmAAAA
```

## Fichier fstab :

Editer le fichier fstab pour renseigner les partitions et leur point de montage :

```
nano -w /etc/fstab
```

Exemple (avec les partitions exemples créées au début) :

```
/dev/sda3               /               ext4            defaults,noatime         0 1
/dev/sda2               none            swap            sw              0 0
/dev/sda1              /boot/EFI           vfat            defaults         0 0
```

## Définir le nom d'hôte :

 Configurer le nom d'hôte de la machine. Éditer le fichier hostname :

```
nano -w /etc/conf.d/hostname
```

## Utilisateurs : 

N'oublions pas le plus important, le mot de passe root : 

```
passwd
```

Il faut également créer un utilisateur non-priviligié : 

```
useradd -m -G users,wheel,audio,cdrom,video,portage -s /bin/bash utilisateur
```

Et créer son mot de passe :

```
passwd utilisateur
```

## Configurer Grub :

Pour installer Grub, on lance la commande : 

EFI :

```
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=orchid_grub
```
Ou Bios :

```
grub-install /dev/sdX
```


Utilisez l'outil grub-mkconfig pour générer grub.cfg :

```
grub-mkconfig -o /boot/grub/grub.cfg 
```

## Services à activer :

Voici la liste des services à activer pour que le système fonctionne :

```
rc-update add display-manager default
rc-update add dbus default
rc-update add NetworkManager default
rc-update add elogind boot
```

## Activation de DWM (concerne uniquement les versions DWM):

L'ensemble des dossiers et fichiers nécessaires sont déjà sur le système.

Il suffit de lancer ces deux scripts *en tant qu'utilisateur non-root* :

```
/usr/share/orchid/fonts/applyorchidfonts && /usr/share/orchid/desktop/dwm/set-dwm
```
Slim lancera alors directement la session dwm.

## Finalisation :

On sort du chroot : 

```
exit
```

On supprime les fichiers précédemment téléchargés :

```
rm -f /mnt/orchid/*.tar.gz
```

On revient à la racine du live CD et on démonte tout ce dont on n'a plus besoin :

```
cd /
umount -R /mnt/orchid
```

On reboot, on enlève le Live CD et on croise les doigts.

Voilà, Orchid est installée.

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

Vous pouvez rejoindre notre serveur Discord : [Rejoindre le serveur](https://discord.gg/DeRhvP7M)


## Contributeurs

   - Wamuu : Créateur du projet.
   - Vinceff : Documentation et mise en projet, directeur de la communication.
   - Chevek : Outils Gaming et optimisation.
   - Babilinx : Optimisation du projet.
   - Piaf_Jaune : Responsable look.
   - Kirik : Vérification de la documentation.
   - L'ensemble des membres du serveur Discord Gaming Linux FR.

