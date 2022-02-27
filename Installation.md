# Installation d'Orchid Linux 

Orchid est une variante moderne et soignée de Gentoo, pour les ordinateurs de bureau et ordinateurs portables.

![Orchid Logo](img/ORCHID_LOGO.png)

## Télécharger et lancer le LiveCD :

Comme nous n'avons pas d'iso spécifique, nous utiliserons l'iso de Gentoo.

[Télécharger l'iso](https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/20220220T170542Z/install-amd64-minimal-20220220T170542Z.iso){: .btn .btn-purple }

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

- Une partition EFI de 256Mo formattée en vfat.
- Une partition swap de quelques Go, en général 2 ou 4Go.
- Le reste de l'espace en ext4.

L'utilisation de cfdisk étant assez facile, elle n'est pas traitée ici.

On formate les nouvelles partitions (exemple avec un disque sda) :

- mkfs.ext4 /dev/sda3
- mkswap /dev/sda2
- mkfs.vfat -F32 /dev/sda1 

Il faut ensuite monter les partitions :

Pour la partition racine :

```
mkdir /mnt/orchid && mount /dev/sda3 /mnt/orchid
```

Activer le swap :

```
swapon /dev/sda2
```

La partition EFI :

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

Il faut ensuite télécharger l'archive qui convient pour un système Orchid complet (l'archive est assez volumineuse) :

[Version standard KDE](https://orchid.juline.tech){: .btn .btn-purple }

Extraire ensuite l'archive : 

```
tar xJvpf stage*.tar.gz --xattrs
```

## Configuration essentielle avant le chroot :

On édite le fichier make.conf pour lui ajouter quelques options supplémentaires.

Le fichier /etc/portage/make.conf est le fichier de configuration dans lequel on va définir les variables de notre future architecture (nombre de coeurs, carte vidéo, périphériques d'entrée, langue, choix des variables d'utilisation, etc... ). Par défaut, Orchid est déjà configurée avec beaucoup de bonnes options par défaut.

Configuration du fichier make.conf :

Ici, il faudra juste changer votre nombre de coeurs pour que Orchid tire les meilleurs profits de votre processeur :

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
/dev/sda2               /               ext4            defaults,noatime         0 1
/dev/sda2               none            swap            sw              0 0
/dev/sda1              /boot/EFI           vfat            defaults         0 0
```

## Définir le nom d'hôte :

 Configurer le nom d'hôte de la machine. Éditer le fichier hostname :

```
nano -w /etc/hostname
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

```
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=orchid_grub
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

## Finalisation :

On sort du chroot : 

```
exit
```

On supprime les fichiers précédemment téléchargés :

```
rm -f /mnt/orchid/*.tar.gz
```

On revient à la racine du live CD et on démonte tout ce dont on a plus besoin :

```
cd /
umount -R /mnt/gentoo
```

On reboot, on enlève le Live CD et on croise les doigts.
Voila Orchid est installée.

## Contributeurs

- Juline : Créatrice du projet.
- Kirik : Vérification de la documentation.
