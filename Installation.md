# Installation d'Orchid Linux 

Orchid est une variante moderne et soignée de Gentoo, pour les ordianteurs de bureau et ordinateurs portables.

![Orchid Logo](img/ORCHID_LOGO.png)

## Télécharger et lancer le LiveCD :

Comme nous n'avons pas d'iso spécifique, nous utiliserons l'iso de Gentoo.

[Télécharger l'iso](https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/20220220T170542Z/install-amd64-minimal-20220220T170542Z.iso)

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


## Contributors

- Juline : Creator and main maintener.
- Kirik : English documentation tester.
