# Outils d'Orchid Linux


![Orchid Logo](img/Orchid-Think_3.3_-_N.png)

## Nos outils

Nous avons intégrer des commandes permettant l'utilisation et la maintenance du système, de façon rapide et simple.

### orchid-sync

Il s'agit de l'outil principal car il permets de récupérer et de garder à jour tout les autres.
Basiquement, cet outil synchronise les différents sous-repos d'Orchid :

- Les fonds d'écrans. (d'origine diverses)
- Les outils.
- DWM si vous l'avez choisi.
- Les outils gaming si vous les avez aussi.

Cette commande s'utilise simplement en lançant `orchid-sync`.

### orchid-install

Cette commande permets l'installation de logiciel.
Cela permets l'acceptation de paquets masqués.

Elle s'utilise comme suit :
 ```
sudo orchid-install monpaquet
 ```

### orchid-delete

Cette commande permets la suppression et le nettoyage d'un logiciel.
Elle nettoie donc les dépendances et paquets inutiles après la suppression.

Elle s'utilise comme suit :
 ```
sudo orchid-delete monpaquet
 ```

### orchid-update

Cette commande permets la mise à jour du système. Elle effectue également un `orchid-sync`.

Elle s'utilise comme suit :
 ```
sudo orchid-update
 ```
### orchid-update-sleep

Cette commande permets la mise à jour du système et l'extinction du système à la fin, utile avant d'aller dormir.

Elle s'utilise comme suit :
 ```
sudo orchid-update-sleep
 ```
### orchid-update-reboot

Cette commande permets la mise à jour du système et de le redémarrer à la fin.

Elle s'utilise comme suit :
 ```
sudo orchid-update-reboot
 ```

### orchid-boot-update

Cette commande permets la mise à jour de grub, utile en cas de changement ou de majs du noyau.

Elle s'utilise comme suit :
 ```
sudo orchid-boot-update
 ```


### orchid-kernel-up

Cette commande autorise l'installation des noyaux masqués, par exemple le 5.16.17.
La commande à elle seule n'installe rien, il faut lancer une mise à jour du système après.

Elle s'utilise comme suit :
 ```
sudo orchid-kernel-up
 ```

### orchid-nvidia

Cette commande autorise l'installation des pilotes nvidia en dernière version disponible, ainsi que les paquets nécessaires à CUDA/NVENC selon la documentation Gentoo.

Elle s'utilise comme suit :
 ```
sudo orchid-nvidia
 ```
### orchid-get-tkg

Télécharge l'ensemble des prérequis à la mise en place du noyau TkG. Installe aussi les dépendances manquantes. Mets à jour les dernières versions disponibles.
La commande à elle seule n'installe rien, il faut lancer la commande ci-dessous par la suite.

Elle s'utilise comme suit :
 ```
sudo orchid-get-tkg
 ```

### orchid-set-tkg

Vérifie les dernières versions du noyau, mets à jour le repo, et exécute le script d'installation et de compilation.

Elle s'utilise comme suit :
 ```
sudo orchid-set-tkg
 ```
 
### orchid-optimizer

Recompile l'ensemble des paquets avec les optimisations processeur.
Permets de rejoindre l'élitisme suprême proposé par Gentoo et Orchid.

Lancer la commande et l'opération se fait automatiquement :

 ```
 sudo orchid-optimizer
 ```

### orchid-transform

Transforme une Gentoo en Orchid avec la suite d'outils Orchid, ainsi que les wallpapers, logiciels partenaires et autres.

Lancer la commande et l'opération se fait automatiquement :

```
wget https://raw.githubusercontent.com/wamuu-sudo/orchid-bins/main/bins/orchid-transform && chmod +x ./orchid-transform && sudo ./orchid-transform
```

## Contributeurs
- [Hydaelyn](https://github.com/wamuu-sudo) : Créateur du projet.
- Vinceff : Documentation et mise en projet.
- [Chevek](https://github.com/chevek) : Outils Gaming et optimisation, développeur du projet.
- [Babilinx](https://github.com/babilinx) : Optimisation du projet et développeur du projet.
- [Crystal](https://crystal-trd.github.io) : Développeuse du projet.
- Piaf_Jaune : Responsable look et graphiste.
- Kirik : Vérification de la documentation.
- L'ensemble des membres du serveur [Discord Gaming Linux FR](https://discord.gg/KAzznM4Fnb).
